import 'package:chat_flow/pages/chat.dart';
import 'package:chat_flow/pages/menu.dart';
import 'package:chat_flow/pages/profile.dart';
import 'package:chat_flow/pages/updateContact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/pages/login.dart';
import 'package:chat_flow/pages/register.dart';
import 'package:chat_flow/pages/addContact.dart';
import 'package:chat_flow/modules/Utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flow',
      theme: ThemeData(),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/register': (context) => const Register(),
        '/menu': (context) => const Menu(),
        '/chat': (context) => Chat(),
        '/profile': (context) => const Profile(),
        '/addContact': (context) => const AddContact(),
        '/updateContact': (context) => const UpdateContact(),
      },
    );
  }
}
