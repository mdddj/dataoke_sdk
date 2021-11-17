import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MyButton(this.text, {Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
