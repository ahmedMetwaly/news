import "package:flutter/material.dart";
import '../../model/cubit/appcCubit.dart';
import 'package:news_app/screens/mainScreens/webView.dart';
import 'package:news_app/widgets/profileImage.dart';


class SearchItem extends StatelessWidget {
  final String url;
  final String profileImageUrl;
  final String title;
  const SearchItem({
    required this.url,
    required this.profileImageUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppCubit.navTo(
        context,
        WebViewPage(url: url),
      ),
      child: Row(
        children: [
          ProfileImage(
            profileImage: profileImageUrl,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
