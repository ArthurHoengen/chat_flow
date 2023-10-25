import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/modules/Contact.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Contact contact =
        ModalRoute.of(context)?.settings.arguments as Contact;

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
              child: Text(contact.name[0], textScaleFactor: 2.125),
            ),
            SizedBox(height: 20.0),
            Text(
              contact.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            contact.email == ''
            ? Text(
              contact.email,
              style: TextStyle(fontSize: 18.0),
            )
            : SizedBox(),

            SizedBox(height: 10.0),
            Text(
              contact.number,
              style: TextStyle(fontSize: 18.0),
            ),
            Center(
                child: contact.id != ''
                    ? Column(children: [
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CF_purple),
                          onPressed: () {
                            _handleUpdate(context, contact);
                          },
                          child: Text('Update contact'),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            final docUser = FirebaseFirestore.instance
                                .collection('contacts')
                                .doc(contact.id);

                            docUser.delete();
                            _handleMenu(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact deleted successfully!')));
                          },
                          child: Text('Delete contact'),
                        ),
                      ])
                    : SizedBox(height: 10))
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          IconButton(
            onPressed: () {
              if (contact.id != '') {
                Contact contact = Contact(
                    name: "Me", email: "email@email.com", number: "123456789");
                _handleProfile(context, contact);
              }
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              _handleMenu(context);
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              _handleLogin(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  void _handleProfile(BuildContext context, Contact contact) {
    Navigator.pushNamed(context, '/profile', arguments: contact);
  }

  void _handleLogin(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }

  void _handleMenu(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/menu');
  }

  void _handleUpdate(BuildContext context, Contact contact) {
    Navigator.pushNamed(context, '/updateContact', arguments: contact);
  }
}
