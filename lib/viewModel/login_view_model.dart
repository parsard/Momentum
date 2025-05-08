import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';

class LoginViewModel extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn(scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  void loginWithGoogle(BuildContext context) async {
    final signInAccount = await _googleSignIn.signIn().catchError((error) {
      print('signIn error :$error');
    });
    final googleAuth = await signInAccount?.authentication;

    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final response = await FirebaseAuth.instance.signInWithCredential(googleCredential).catchError((error) {
      print('cred error :$error');
    });

    final user = response.user;
    if (user != null) {
      print('User signed in: ${user.displayName},${user.email}');
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TimeTrackerPage()));
      }
    } else {
      print('User sign in failed');
    }
    notifyListeners(); // Notify listeners if needed
  }
}
