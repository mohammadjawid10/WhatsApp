import 'package:flutter/material.dart';

Widget buildStatusWidget({
  required String userName,
  required String date,
  required String imageUrl,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(imageUrl),
    ),
    title: Text(
      userName,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(date, style: const TextStyle(fontSize: 16)),
    ),
  );
}
