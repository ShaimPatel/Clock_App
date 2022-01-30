import 'package:clock_app/screen/home_page.dart';
import 'package:clock_app/screen/ragistration_page.dart';
import 'package:clock_app/screen/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initilization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // ignore: avoid_print
          print("Something went wrong..!");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'FireseBase',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: const SignUpPage(),
            initialRoute: '/loginPage',
            routes: {
              '/loginPage': (context) => const SigninPage(),
              '/signUpPage': (context) => const SignUpPage(),
              '/homepage': (context) => const HomePage(),
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
