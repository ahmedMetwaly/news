import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/news4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
