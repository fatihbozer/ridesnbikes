import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final VoidCallback? function;
  final Color backgroundColor;
  final String text;

  const FollowButton({super.key, this.function, required this.backgroundColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
