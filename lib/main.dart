import 'package:chat_flow/pages/chat.dart';
import 'package:chat_flow/pages/login.dart';
import 'package:chat_flow/pages/menu.dart';
import 'package:chat_flow/pages/profile.dart';
import 'package:chat_flow/pages/updateContact.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/pages/register.dart';
import 'package:chat_flow/pages/addContact.dart';
import 'package:chat_flow/modules/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
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
        '/': (context) => const MainPage(),
        '/register': (context) => const Register(),
        '/profile': (context) => const Profile(),
        '/addContact': (context) => const AddContact(),
        '/updateContact': (context) => const UpdateContact(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            return const Menu();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
