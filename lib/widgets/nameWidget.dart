import 'package:flutter/material.dart';

import '../constants.dart';

class defaultTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  TextInputType? keyBoardType = TextInputType.name;
  String? hintText = "example";
   defaultTextInput({
    required this.labelText,
    Key? key,
    required this.controller,
     this.keyBoardType,
     this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       TextFormField(
        style:Theme.of(context).textTheme.subtitle1,
        controller: controller,
        decoration: InputDecoration(
          label: Text(labelText),
          hintText: hintText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty ) {
            return 'This field is required';
          }
          if(hintText!=null){
            if(value.length<11 || value.length>11){
              return "Phone number must be 11 digits";
            }
          }
          return null;
        },
        keyboardType: keyBoardType,

    );
  }
}
