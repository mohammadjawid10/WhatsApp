import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/helpers/auth_methods.dart';
import 'package:whatsapp/helpers/utils.dart';
import 'package:whatsapp/screens/screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  resetTextFields() {
    setState(() {
      _emailController.text = '';
      _passwordController.text = '';
    });
  }

  final _formKey = GlobalKey<FormState>();

  login() async {
    setState(() {
      isLoading = true;
    });
    String res = 'Error';

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => isLoading = true);

      try {
        res = await AuthMethods().login(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final user = FirebaseAuth.instance.currentUser;

        if (res == 'success') {}

        if (res == 'success') {
          resetTextFields();
          setState(() {
            isLoading = true;
          });
          if (user?.emailVerified ?? false) {
            Navigator.of(context).pushReplacement(HomeScreen.route);
          } else {
            Navigator.of(context).pushReplacement(EmailVerifyScreen.route);
          }
        }

        setState(() => isLoading = false);
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
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
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
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: login,
                      child: const Text('Login'),
                    ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(SignupScreen.route);
                    },
                    child: const Text(
                      'Sign up',
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
