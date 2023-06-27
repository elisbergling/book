import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final List<String> bookIds;
  final List<String> followingUserIds;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.bookIds,
    required this.followingUserIds,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      profileImageUrl: data['profileImageUrl'],
      bookIds: List<String>.from(data['bookIds']),
      followingUserIds: List<String>.from(data['followingUserIds']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'bookIds': bookIds,
      'followingUserIds': followingUserIds,
    };
  }
}
