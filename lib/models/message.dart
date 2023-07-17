import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
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
    required this.uidFrom,
    required this.uidTo,
    required this.text,
    required this.time,
    required this.isLiked,
    required this.isRead,
    required this.photoUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      uidFrom: json['uidFrom'],
      uidTo: json['uidTo'],
      isLiked: json['isLiked'],
      isRead: json['isRead'],
      photoUrl: json['photoUrl'],
      text: json['text'],
      time: json['time'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uidFrom': uidFrom,
        'uidTo': uidTo,
        'text': text,
        'time': time,
        'isLiked': isLiked,
        'isRead': isRead,
        'photoUrl': photoUrl
      };
}
