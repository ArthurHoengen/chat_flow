import 'package:chat_flow/colors.dart';
import 'package:chat_flow/pages/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/modules/contact.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cfPurple,
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
              Contact contact =
                  Contact(name: "Me", email: user!.email!, number: "123456789");
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

  void _handleProfile(BuildContext context, Contact contact) {
    Navigator.pushReplacementNamed(context, '/profile', arguments: contact);
  }

  void _handleNewContact(BuildContext context) {
    Navigator.pushNamed(context, '/addContact');
  }

  Widget buildContact(Contact contact) {
    if (user!.email != contact.email) {
      return GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                  receiverUserEmail: contact.email, receiverUserId: contact.id),
            ),
          ),
        },
        child: ListTile(
          leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile', arguments: contact);
              },
              child: CircleAvatar(child: Text(contact.name[0].toUpperCase()))),
          title: Text(contact.name),
          subtitle: Text(contact.number),
        ),
      );
    }
    return const SizedBox();
  }

  Stream<List<Contact>> readContacts() => FirebaseFirestore.instance
      .collection('contacts')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Contact.fromJson(doc.data())).toList());
}
