import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:whatsapp/constants/constants.dart';
import 'package:whatsapp/helpers/auth_methods.dart';
import 'package:whatsapp/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.fullName,
    required this.imageUrl,
    required this.email,
    required this.bio,
  }) : super(key: key);

  final String fullName;
  final String imageUrl;
  final String email;
  final String bio;

  static const routeName = '/profile';

  logout() async {
    String res = 'Error';
    try {
      res = await AuthMethods().logout();
      log(res);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Hero(
                    tag: 'profile_picture',
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: greenColor,
                    radius: 26,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: buttonGreyColor),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            subtitle: const Text(
              'This is not your username or pin. This name will be visible to your contacts.',
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: greenColor),
            ),
          ),
          //! Divider
          const Divider(),
          //! Divider
          ListTile(
            leading: const Icon(Icons.info_outline, color: buttonGreyColor),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bio,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: greenColor),
            ),
          ),
          //! Divider
          const Divider(),
          //! Divider
          ListTile(
            leading: const Icon(Icons.phone, color: buttonGreyColor),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Phone',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 4),
                Text('+23 343 2299 332',
                    style: TextStyle(fontWeight: FontWeight.w400)),
                SizedBox(height: 10),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: greenColor),
            ),
          ),
          const Divider(),
          TextButton(
            onPressed: () async {
              await logout();
              Navigator.of(context).pushReplacement(LoginScreen.route);
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
