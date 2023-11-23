import 'package:flutter/material.dart';
import 'package:whatsapp/helpers/auth_methods.dart';
import 'package:whatsapp/screens/login_screen.dart';

class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(
        builder: (context) => const EmailVerifyScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await AuthMethods().verifyUser();
          },
          child: const Text('send verification email'),
        ),
        TextButton(
            child: const Text('Restart'),
            onPressed: () async {
              await AuthMethods().logout();
              Navigator.pushReplacement(context, LoginScreen.route);
            },
          ),
      ],
    );
  }
}
