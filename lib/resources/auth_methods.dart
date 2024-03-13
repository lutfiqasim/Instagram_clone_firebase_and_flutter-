import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/resources/storage_methods.dart';
// import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sign up a new user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List profileImage,
  }) async {
    String result = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          profileImage != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //  print(cred.user!.uid);

        //sotre image
        String photoURL = await StorageMethods()
            .uploadImageToStorage('profilePics', profileImage, false);

        // add user to firebase firestore
        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          username: userName,
          bio: bio,
          photoURL: photoURL,
          followers: [],
          following: [],
        );
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        result = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted.';
      } else if (err.code == 'email-already-in-use') {
        result = 'The email is already in use by another account.';
      } else if (err.code == 'weak-password') {
        result = 'The password is too weak.';
      } else if (err.code == 'operation-not-allowed') {
        result = 'Indicates that email and password accounts are not enabled.';
      } else if (err.code == 'too-many-requests') {
        result =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
      } else if (err.code == 'network-request-failed') {
        result =
            'Network error (such as timeout, interrupted connection or unreachable host) has occurred.';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      } else {
        result = 'Please enter email and password';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted.';
      } else if (err.code == 'user-not-found') {
        result = "Email or password is incorrect";
      } else if (err.code == 'wrong-password') {
        result = 'Email or password is incorrect';
      } else {
        result = "check your credentials";
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
