import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/login_screen.dart';

import 'package:whatsapp/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff008069),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        AddChatScreen.routeName: (context) => const AddChatScreen(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const HomeScreen();
              } else {
                return const EmailVerifyScreen();
              }
            } else {
              return const LoginScreen();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }

        return const LoginScreen();
      },
    );
  }
}
