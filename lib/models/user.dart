import 'package:cloud_firestore/cloud_firestore.dart';

class User_h {
  String uid;
  String email;
  String username;
  String profileImage;
  String type;

  User_h({
    required this.uid,
    required this.email,
    required this.username,
    required this.profileImage,
    required this.type
  });

  static User_h fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<dynamic, dynamic>;
    return User_h(
      uid: snapshot['uid'] as String,
      email: snapshot['email'] as String,
      username: snapshot['username'] as String,
      profileImage: snapshot['profileImage'] as String,
      type: snapshot['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profileImage': profileImage,
    };
  }
}
