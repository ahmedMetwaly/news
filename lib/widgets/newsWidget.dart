import "package:flutter/material.dart";
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../model/cubit/appcCubit.dart';
import 'package:news_app/screens/mainScreens/webView.dart';
import 'package:news_app/widgets/profileImage.dart';
import 'package:news_app/widgets/shareWidget.dart';

import 'favButton.dart';

class NewsWidget extends StatelessWidget {
  final String publisherImage;
  final String publisherName;
  final String description;
  final String descriptionImage;
  final String title;
  final String url;
  final index;

  const NewsWidget({
    key,
    required this.title,
    required this.description,
    required this.publisherImage,
    required this.publisherName,
    required this.descriptionImage,
    required this.url,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 8,
            color: Colors.black,
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfileImage(
                  profileImage: publisherImage,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // source name
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        publisherName == "null" ? "News" : publisherName,
                        style: Theme.of(context).textTheme.headline1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "2 hours ago",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //The description
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 10),

            InkWell(
              excludeFromSemantics: true,
              enableFeedback: true,
              focusColor: Colors.yellow,
              onTap: () {
                AppCubit.navTo(
                  context,
                  WebViewPage(url: url),
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => descriptionImage == "null",
                    widgetBuilder: (context) => const Image(
                      image: AssetImage('assets/images/nbc-social-default.png'),
                    ),
                    fallbackBuilder: (context) =>
                        Image(image: NetworkImage(descriptionImage)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(45, 51, 62, 50),
                    ),
                    // the title
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FavButton(
                  key: Key(index.toString()),
                  url: url,
                  description: description,
                  descriptionImage: descriptionImage,
                  publisherImage: publisherImage,
                  publisherName: publisherName,
                  title: title,
                ),
                ShareButton(
                  title: title,
                  url: url,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
