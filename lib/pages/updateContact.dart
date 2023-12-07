import 'package:chat_flow/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:chat_flow/modules/contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({Key? key}) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Contact contact =
        ModalRoute.of(context)?.settings.arguments as Contact;
    nameController.text = contact.name;
    emailController.text = contact.email;
    phoneController.text = contact.number;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
        backgroundColor: cfPurple,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) => name == null || name == ''
                    ? 'The name field cannot be empty'
                    : null),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid Email'
                      : null,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.number,
              controller: phoneController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLength: 11,
              validator: (phone) => phone != null && phone.length < 11
                  ? '(##) #####-#### Type only the numbers'
                  : null,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: cfPurple),
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  final docUser = FirebaseFirestore.instance
                      .collection('contacts')
                      .doc(contact.id);

                  docUser.update({
                    'name': nameController.text,
                    'email': emailController.text,
                    'number': phoneController.text,
                  });
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Contact updated successfully!')));
                },
                child: const Text("Update Contact"))
          ],
        ),
      ),
    );
  }
}
