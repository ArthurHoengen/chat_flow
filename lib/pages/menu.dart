import 'package:chat_flow/colors.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CF_purple,
        title: Text('Menu'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: 10, // Número de conversas
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              // Imagem do perfil do contato
              backgroundColor: CF_purple,
              child: Icon(Icons.person),
            ),
            title: Text('Contato ${index + 1}'),
            subtitle: Text('Última mensagem'),
            onTap: () {
              // Navegar para a tela de conversa ao tocar em um contato
              _handleChat(context, 'Contato ${index + 1}');
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          IconButton(
            onPressed: () {_handleProfile(context);},
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {},
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
  Navigator.pop(context);
}

void _handleChat(BuildContext context, String contactName) {
  Navigator.pushNamed(context, '/chat', arguments: contactName);
}

void _handleProfile(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/profile');
}