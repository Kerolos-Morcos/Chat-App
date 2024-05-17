import 'package:flutter/material.dart';

getTitleText(String title, MainAxisAlignment textAlign) => Row(
  mainAxisAlignment: textAlign,
  children: [
    Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 12,
      ),
    ),
  ],
);