import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String chatId;
  final String uidFrom;
  final String uidTo;
  final String text;
  final Timestamp time;
  final bool isLiked;
  final bool isRead;
  final String? photoUrl;

  bool get isImage => photoUrl != null;

  bool isMe(String uid) => uidFrom == uid;

  Message({
    required this.id,
    required this.chatId,
    required this.uidFrom,
    required this.uidTo,
    required this.text,
    required this.time,
    required this.isLiked,
    required this.isRead,
    required this.photoUrl,
  });

  factory Message.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Message(
      id: map['id'],
      chatId: map['chatId'],
      uidFrom: map['uidFrom'],
      uidTo: map['uidTo'],
      isLiked: map['isLiked'],
      isRead: map['isRead'],
      photoUrl: map['photoUrl'],
      text: map['text'],
      time: map['time'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'uidFrom': uidFrom,
      'uidTo': uidTo,
      'text': text,
      'time': time,
      'isLiked': isLiked,
      'isRead': isRead,
      'photoUrl': photoUrl
    };
  }

  Message copyWith({
    String? id,
    String? chatId,
    String? uidFrom,
    String? uidTo,
    String? text,
    Timestamp? time,
    bool? isLiked,
    bool? isRead,
    String? photoUrl,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      uidFrom: uidFrom ?? this.uidFrom,
      uidTo: uidTo ?? this.uidTo,
      text: text ?? this.text,
      time: time ?? this.time,
      isLiked: isLiked ?? this.isLiked,
      isRead: isRead ?? this.isRead,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Message hasRead() {
    return copyWith(isRead: true);
  }

  Message toggleLike() {
    return copyWith(isLiked: !isLiked);
  }
}
