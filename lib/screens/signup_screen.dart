import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/constants/colors.dart';
import 'package:whatsapp/helpers/auth_methods.dart';
import 'package:whatsapp/helpers/utils.dart';
import 'package:whatsapp/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      );

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    // _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  resetTextFields() {
    setState(() {
      _nameController.text = '';
      // _usernameController.text = '';
      _emailController.text = '';
      _passwordController.text = '';
      _bioController.text = '';
    });
    // Focus.of(context).unfocus();
  }

  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  signup() async {
    String res = 'Error';

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isLoading = true);

      try {
        res = await AuthMethods().signup(
          email: _emailController.text,
          password: _passwordController.text,
          bio: _bioController.text,
          fullName: _nameController.text,
          // username: _usernameController.text,
          file: _image!,
        );

        if (res == 'success') {
          resetTextFields();
          setState(() => isLoading = false);
          Navigator.of(context).pushReplacement(LoginScreen.route);
          await AuthMethods().verifyUser();
        } else {
          setState(() => isLoading = false);
        }

        showSnackBar(context, res);
      } catch (e) {
        setState(() {
          isLoading = true;
        });
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Account'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            // shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    _image == null
                        ? const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                'https://th.bing.com/th/id/R.86ddf59f73f9ad652fa8d5aa4b91803b?rik=FkmJyBJWUlailg&pid=ImgRaw&r=0'),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(_image!),
                          ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: greenColor,
                        radius: 20,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Full Name',
                ),
                validator: (name) => name!.length < 2
                    ? 'Name should at least contain 3 characters'
                    : null,
              ),
              const SizedBox(height: 5),
              // TextFormField(
              //   controller: _usernameController,
              //   decoration: const InputDecoration(
              //     contentPadding: EdgeInsets.zero,
              //     hintText: 'Username',
              //   ),
              //   validator: (username) => username!.length < 2
              //       ? 'Username should at least contain 3 characters'
              //       : null,
              // ),
              // const SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Email',
                ),
                validator: (email) =>
                    email!.isEmpty ? 'Email cannot be empty' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (email) =>
                    email!.isEmpty ? 'Password cannot be empty' : null,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Bio',
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: signup,
                      child: const Text('Sign up'),
                    ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(LoginScreen.route);
                    },
                    child: const Text(
                      'Login',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
