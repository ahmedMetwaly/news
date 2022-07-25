import 'package:flutter/material.dart';

class SignInOrUpWith extends StatelessWidget {
  final String imagePath;

  const SignInOrUpWith({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {

      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage(
              imagePath,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
