import 'package:flutter/material.dart';

Widget buildMyStatusWidget() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 70,
        child: Stack(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1556157382-97eda2d62296?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xff00A884),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      title: const Text(
        'My status',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Tap to add status update',
          style: TextStyle(fontSize: 16)),
    );
  }