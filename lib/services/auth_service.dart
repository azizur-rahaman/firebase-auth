import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late final credential;

  Future<User?> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Google Sign In

  Future<User?> signInWithGoogle() async {
    try {
      //Trigger the Authentication Dialogue
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        //Optain the Auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
