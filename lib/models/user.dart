import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String photoURL;
  final List followers;
  final List following;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoURL,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'photoURL': photoURL,
        'bio': bio,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      photoURL: snapshot['photoURL'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
