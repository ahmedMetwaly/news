import 'package:flutter/material.dart';

class LineSeperator extends StatelessWidget {
   Color? color ;
   LineSeperator({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      height: 1,
      color: color,
    );
  }
}
