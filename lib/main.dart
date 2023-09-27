import 'package:chat_flow/pages/chat.dart';
import 'package:chat_flow/pages/menu.dart';
import 'package:chat_flow/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/pages/login.dart';
import 'package:chat_flow/pages/register.dart';

void main() {
  runApp(const MyApp());
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