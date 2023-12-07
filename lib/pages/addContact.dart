import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/modules/Contact.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new contact"),
        backgroundColor: CF_purple,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SizedBox(
            height: 24,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Name"),
            controller: nameController,
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Phone number"),
            keyboardType: TextInputType.number,
            controller: phoneController,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
              onPressed: () {
                final contact = Contact(
                  name: nameController.text,
                  email: emailController.text,
                  number: phoneController.text,
                );
                createContact(contact);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Contact added successfully!')));
              },
              child: const Text("Add contact"))
        ],
      ),
    );
  }

  Future createContact(Contact contact) async {
    final docUser = FirebaseFirestore.instance.collection('contacts').doc();
    contact.id = docUser.id;

    final json = contact.toJson();
    await docUser.set(json);
  }
}
