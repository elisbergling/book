import 'package:book/models/message.dart';
import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/image_provider.dart';
import 'package:book/providers/providers.dart';
import 'package:book/services/service_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MessageService extends ServiceNotifier {
  late final String? uid = ref.watch(firebaseAuthProvider).currentUser?.uid;

  late final CollectionReference messagesCollection =
      ref.watch(firebaseFirestoreProvider).collection('messages');

  String _chatIdGenerator(String uidTo) {
    String chatRoomId = '';

    if (uid.hashCode < uidTo.hashCode) {
      chatRoomId = uid! + uidTo;
    } else if (uidTo.hashCode < uid.hashCode) {
      chatRoomId = uidTo + uid!;
    } else if (uidTo == uid) {
      chatRoomId = uid!;
    } else if (uidTo.hashCode == uid.hashCode) {
      chatRoomId = uidTo.hashCode.toString() + uid.hashCode.toString();
    } else {
      chatRoomId = 'JUNKY CHAT';
    }

    return chatRoomId;
  }

  Query<Object?> _messagesReferance(String uidTo) {
    String chatId = _chatIdGenerator(uidTo);
    return messagesCollection
        .where('chatId', isEqualTo: chatId)
        .orderBy('time');
  }

  Future<void> createMessage({
    required String text,
    required String uidTo,
    required XFile? photo,
  }) async {
    try {
      toggleLoading();
      String chatId = _chatIdGenerator(uidTo);
      final id = ref.read(uuidProvider).v4();
      String? photoUrl;
      if (photo != null) {
        photoUrl = await ref
            .read(imageProvider.notifier)
            .uploadMessage(file: photo, id: id);
        if (photoUrl == null) {
          throw Exception('Sending photo failed');
        }
      }
      Message message = Message(
        id: id,
        chatId: chatId,
        uidFrom: uid!,
        uidTo: uidTo,
        text: text,
        time: Timestamp.now(),
        isLiked: false,
        isRead: false,
        photoUrl: photoUrl,
      );
      return await messagesCollection.doc(message.id).set(message.toMap());
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> updateMessage({
    required Message message,
  }) async {
    try {
      toggleLoading();
      return await messagesCollection.doc(message.id).update(message.toMap());
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> deleteMessage({
    required String id,
  }) async {
    try {
      toggleLoading();
      return await messagesCollection.doc(id).delete();
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<Message?> fetchLastMessage({required String uidTo}) async {
    try {
      return await _messagesReferance(uidTo)
          .limit(1)
          .get()
          .then((value) => value.docs.map((e) => Message.fromMap(e)).first);
    } catch (e) {
      setError(e);
      return null;
    }
  }

  Stream<List<Message>> messagesStream({required String uidTo}) {
    try {
      return _messagesReferance(uidTo)
          .snapshots()
          .map((event) => event.docs.map((e) => Message.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }
}
