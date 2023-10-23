import 'package:chat_flow/pages/chat.dart';
import 'package:chat_flow/pages/menu.dart';
import 'package:chat_flow/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/pages/login.dart';
import 'package:chat_flow/pages/register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flow',
      initialRoute: '/login',
      routes: {
        '/chat': (context) => Chat(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/menu': (context) => const Menu(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
