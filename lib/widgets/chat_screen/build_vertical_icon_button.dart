import 'package:flutter/material.dart';

import 'package:whatsapp/constants/constants.dart';

Widget buildVerticalIconButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Column(
      children: [
        Icon(icon, color: brightGreenColor),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(color: brightGreenColor)),
      ],
    ),
  );
}
