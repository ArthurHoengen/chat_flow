import 'package:chat_flow/modules/Utils.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_flow/pages/menu.dart';
import 'package:chat_flow/main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LoginForm(),
                  ),
                );
              }
            }));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(width: 50.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
              onPressed: () {
                _handleRegister(context);
              },
              child: const Text('Register'),
            )
          ],
        ),
      ],
    );
  }

  Future _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (exception) {
      print(exception);

      Utils.showSnackBar(exception.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void _handleRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }
}
