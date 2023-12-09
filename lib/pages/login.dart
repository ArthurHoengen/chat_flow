import 'package:chat_flow/modules/utils.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_flow/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cfPurple,
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cfPurple),
                onPressed: _login,
                child: const Text('Login'),
              ),
              const SizedBox(width: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cfPurple),
                onPressed: () {
                  _handleRegister(context);
                },
                child: const Text('Register'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future _login() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (exception) {
      Utils.showSnackBar(exception.message);
      navigatorKey.currentState!.pop();
      return;
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void _handleRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }
}
