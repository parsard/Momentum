import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';

class LoginViewModel extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn(
    clientId:
        '320871441213-s6dedp8ubijhjqbjri1gkaksjh0rkfvf.apps.googleusercontent.com',
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      // Sign in with Google
      final signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        // User canceled the sign-in
        print('Sign-in was canceled');
        return;
      }

      final googleAuth = await signInAccount.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final response = await FirebaseAuth.instance.signInWithCredential(
        googleCredential,
      );

      final user = response.user;
      if (user != null) {
        print('User signed in: ${user.displayName}, ${user.email}');

        // Navigate to TimeTrackerPage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TimeTrackerPage()),
        );
      } else {
        print('User sign-in failed');
      }
    } catch (error) {
      print('Error during sign-in: $error');
    }

    notifyListeners();
  }
}
