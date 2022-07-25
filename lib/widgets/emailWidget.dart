import 'package:flutter/material.dart';

import '../constants.dart';


class Email extends StatelessWidget {
  final TextEditingController controller;
  const Email({
    Key? key,
    required this.controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.subtitle1,
      controller: controller,
      decoration: const InputDecoration(
        label: Text("Email"),
        hintText: "name@example.com",
        prefixIcon: Icon(Icons.email_rounded),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
