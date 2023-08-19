import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;
  final String name;
  final String username;
  final String email;
  final String? profileImageUrl;
  final List<String> conversationUids;
  final List<String> followingUids;

  MyUser({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.conversationUids,
    required this.followingUids,
  });

  factory MyUser.fromMap(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return MyUser(
      uid: map['uid'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      profileImageUrl: map['profileImageUrl'],
      conversationUids: List<String>.from(map['conversationUids']),
      followingUids: List<String>.from(map['followingUids']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'conversationUids': conversationUids,
      'followingUids': followingUids,
    };
  }
}
