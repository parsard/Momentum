import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';

class LoginViewModel extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      print('Attempting Google Sign-In...');
      final signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        print('Sign-in was canceled by the user.');
        return;
      }

      print('Google Sign-In successful. Fetching authentication...');
      final googleAuth = await signInAccount.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Signing in with Firebase...');
      final response = await FirebaseAuth.instance.signInWithCredential(
        googleCredential,
      );

      final user = response.user;
      if (user != null) {
        print('User signed in: ${user.displayName}, ${user.email}');
        Navigator.of(context).pushNamed('/tracker');
      } else {
        print('User sign-in failed.');
      }
    } catch (error) {
      print('Error during sign-in: $error');
    }
  }
}
