import 'package:flutter/material.dart';

Widget buildTab(String title, int notifications) {
    return SizedBox(
      width: 70,
      child: Tab(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              notifications != 0
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 9,
                      child: Text(
                        notifications.toString(),
                        style: const TextStyle(
                          color: Color(0xff008069),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }