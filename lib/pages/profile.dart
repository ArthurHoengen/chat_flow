import 'package:chat_flow/colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Suponha que você tenha informações do usuário
    final String userName = 'Nome do Usuário';
    final String userEmail = 'usuario@email.com';
    final String userPhoneNumber = '+1234567890';
    final AssetImage userImage = AssetImage('assets/imagem_usuario_medio.png');

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: CF_purple,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundImage: userImage,
            ),
            SizedBox(height: 20.0),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              userEmail,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              userPhoneNumber,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {_handleMenu(context);},
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {_handleLogin(context);},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

void _handleLogin(BuildContext context) {
  Navigator.pushNamed(context, '/login');
}

void _handleMenu(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/menu');
}