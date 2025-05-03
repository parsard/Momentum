import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn(
    clientId:
        '320871441213-s6dedp8ubijhjqbjri1gkaksjh0rkfvf.apps.googleusercontent.com',
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
  void loginWithGoogle() async {
    final signInAccount = await _googleSignIn.signIn().catchError((error) {
      print('signIn error :$error');
    });
    final googleAuth = await signInAccount?.authentication;

    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final response = await FirebaseAuth.instance
        .signInWithCredential(googleCredential)
        .catchError((error) {
          print('cred error :$error');
        });

    final user = response.user;
    if (user != null) {
      print('User signed in: ${user.displayName},${user.email}');
    } else {
      print('User sign in failed');
    }
    notifyListeners(); // Notify listeners if needed
  }
}
