import 'package:firebase_auth_test/firebase_options.dart';
import 'package:firebase_auth_test/screens/home.dart';
import 'package:firebase_auth_test/screens/login_screen.dart';
import 'package:firebase_auth_test/screens/register_screen.dart';
import 'package:firebase_auth_test/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            }
            return LoginSreen();
          }),
    );
  }
}
