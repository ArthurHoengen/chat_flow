import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/colors.dart';

class Login extends StatelessWidget{
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: CF_purple,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoginForm(),
            )
        ),
    );
  }
}

void _handleMenu(BuildContext context) {
  Navigator.pushNamed(context, '/menu');
}

void _handleRegister(BuildContext context) {
  Navigator.pushNamed(context, '/register');
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == '' && password == '') {
      // Substituir pela lógica depois
      _handleMenu(context);
    } else {
      // Caso contrário, exiba uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credenciais inválidas. Tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(width: 50.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
              onPressed: () {_handleRegister(context);},
              child: Text('Register'),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }
}