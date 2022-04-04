import 'package:flutter/material.dart';

const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

const appColor = Color(0xff003cc0);

SnackBar snackBar(text) => SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    ));
