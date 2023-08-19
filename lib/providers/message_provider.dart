import 'package:book/models/message.dart';
import 'package:book/models/service_data.dart';
import 'package:book/services/message_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageProvider =
    NotifierProvider<MessageService, ServiceData>(() => MessageService());

final messagesStreamProvider =
    StreamProvider.family<List<Message>, String>((ref, uidTo) {
  return ref.watch(messageProvider.notifier).messagesStream(uidTo: uidTo);
});

final fetchLastMessageProvider =
    FutureProvider.family<Message?, String>((ref, uidTo) async {
  final message = ref.watch(messageProvider.notifier);
  return await message.fetchLastMessage(uidTo: uidTo);
});
