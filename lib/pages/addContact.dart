import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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

  XFile? _selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

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
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: _getImage,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Center(
                child: _selectedImage == null
                    ? const Icon(
                  Icons.camera_alt,
                  size: 80.0,
                )
                    : Image.file(
                  File(_selectedImage!.path),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Name"),
            controller: nameController,
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          SizedBox(
            height: 24,
          ),
          TextField(
            decoration: InputDecoration(labelText: "Phone number"),
            keyboardType: TextInputType.number,
            controller: phoneController,
          ),
          SizedBox(
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact added successfully!')));
              },
              child: Text("Add contact"))
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