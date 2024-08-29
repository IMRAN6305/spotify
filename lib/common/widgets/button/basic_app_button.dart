import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  // final double wight;

  const BasicAppButton(
      {super.key,
      required this.onPressed,
      required this.title, this.height,
      // required this.wight
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(minimumSize: Size.fromHeight(height ?? 80),foregroundColor: Colors.white),
      child:  Text(title),
    );
  }
}
