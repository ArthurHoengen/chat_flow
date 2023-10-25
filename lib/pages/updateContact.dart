import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:chat_flow/modules/Contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({Key? key}) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
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
    final Contact contact = ModalRoute.of(context)?.settings.arguments as Contact;
    nameController.text = contact.name;
    emailController.text = contact.email;
    phoneController.text = contact.number;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
        backgroundColor: CF_purple,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SizedBox(
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
                final docUser = FirebaseFirestore.instance.collection('contacts').doc(contact.id);


                docUser.update({
                  'name': nameController.text,
                  'email': emailController.text,
                  'number': phoneController.text,
                });
                Navigator.popUntil(context, ModalRoute.withName('/menu'));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact updated successfully!')));
              },
              child: Text("Update Contact"))
        ],
      ),
    );
  }
}