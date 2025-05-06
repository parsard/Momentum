import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:momentum/ui/view/login_page.dart';
import 'package:momentum/ui/view/time_tracker_page.dart';
import 'package:momentum/viewModel/login_view_model.dart';
import 'package:momentum/viewModel/time_tracker_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBGzqoOx-_F9RWs83-hcHdqPhhdRZ0CtaE',
      appId: '1:320871441213:android:f63229f8a6917c6f9c5b54',
      messagingSenderId: '320871441213',
      projectId: 'momentum-abbf6',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => TimeTrackerViewModel()),
      ],
      //child: LoginPage(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Momentum',
        home: LoginPage(),
      ),
    );
  }
}
