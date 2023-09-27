import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_flow/colors.dart';
import 'dart:io';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationPage();
  }
}

void _handleMenu(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/menu');
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  void _register(BuildContext context) {
    String number = _numberController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    //LOGICA PARA TRATAMENTO DA IMAGEM:
    // if (_selectedImage != null) {
    //
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Por favor, selecione uma imagem.'),
    //     ),
    //   );
    // }

    _handleMenu(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CF_purple,
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: _selectedImage == null
                        ? Icon(
                      Icons.camera_alt,
                      size: 40.0,
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
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
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
              TextField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: CF_purple),
                onPressed: () {
                  _register(context);
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
