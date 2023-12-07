import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/modules/Contact.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CF_purple,
        title: const Text('Menu'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _handleNewContact(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<Contact>>(
        stream: readContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final contacts = snapshot.data!;
            if (contacts.isEmpty) {
              return const Padding(
                  padding: EdgeInsets.only(left: 55, top: 300),
                  child: Text("You don't have any contacts added "));
            }

            return ListView(
              children: contacts.map(buildContact).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          IconButton(
            onPressed: () {
              Contact contact = Contact(
                  name: "Me", email: "email@email.com", number: "123456789");
              _handleProfile(context, contact);
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              _handleLogin(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }

  void _handleChat(BuildContext context, String contactName) {
    Navigator.pushNamed(context, '/chat', arguments: contactName);
  }

  void _handleProfile(BuildContext context, Contact contact) {
    Navigator.pushReplacementNamed(context, '/profile', arguments: contact);
  }

  void _handleNewContact(BuildContext context) {
    Navigator.pushNamed(context, '/addContact');
  }

  Widget buildContact(Contact contact) => GestureDetector(
        onTap: () {
          _handleChat(context, contact.name);
        },
        child: ListTile(
          leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile', arguments: contact);
              },
              child: CircleAvatar(
                  child: contact.name == ""
                      ? const Icon(Icons.account_circle)
                      : Text(contact.name[0].toUpperCase()))),
          title: Text(contact.name),
          subtitle: Text(contact.number),
        ),
      );

  Stream<List<Contact>> readContacts() => FirebaseFirestore.instance
      .collection('contacts')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList());
}
