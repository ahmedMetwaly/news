import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import 'newsWidget.dart';

class DisplayData extends StatelessWidget {
  final dynamic category;
  const DisplayData({required this.category, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Conditional.single(
        context: context,
        conditionBuilder: (context) => category.length > 0,
        widgetBuilder: (context) => ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: NewsWidget(
                index: index,
                url: category[index]['url'].toString(),
                description: category[index]['description'].toString(),
                descriptionImage: category[index]['urlToImage'].toString(),
                publisherImage: category[index]['urlToImage'].toString(),
                publisherName: category[index]['author'].toString(),
                title: category[index]['title'].toString(),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemCount: category.length,
          physics: const BouncingScrollPhysics(),
        ),
        fallbackBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.yellow,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
