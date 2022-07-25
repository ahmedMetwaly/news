import 'package:flutter/material.dart';

import '../../model/cubit/appcCubit.dart';

class FavButton extends StatefulWidget {
  final String publisherImage;
  final String publisherName;
  final String description;
  final String descriptionImage;
  final String title;
  final String url;
  const FavButton({
    key,
    required this.title,
    required this.description,
    required this.publisherImage,
    required this.publisherName,
    required this.descriptionImage,
    required this.url,
  }) : super(key: key);

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool clickedFav = false;
  Color? favColor;
  void clickedFavButton() {
    clickedFav = !clickedFav;
    if (clickedFav == true ) {
      favColor = Theme.of(context).scaffoldBackgroundColor == const Color(0xFF232836) ? Colors.yellow : const Color(0xFFF5564B);
    } else {
      favColor = Theme.of(context).iconTheme.color!;
    }
    print("Clicked : $clickedFav \n favColor : $favColor");
  }

  void insertToFav() {
    AppCubit.favNews?.transaction(
      (txn) => txn
          .rawInsert(
        'INSERT INTO favouriteNews(title, description, publisherImage, publisherName, descriptionImage, url) VALUES ("${widget.title}", "${widget.description}", "${widget.publisherImage}", "${widget.publisherName}", "${widget.descriptionImage}","${widget.url}")',
      )
          .then(
        (value) {
          print('$value is inserted successfully ');
        },
      ).catchError(
        (error) {
          print('$error created when inserting a row in');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(
          () {
            clickedFavButton();
            insertToFav();
          },
        );
      },
      icon: Icon(
        Icons.favorite_rounded,
        color: favColor,
      ),
      splashRadius: 15,
    );
  }
}
/*
if (cubit.favData.contains(widget.url) == false) {
              cubit.insertToFav(
                publisherImage: widget.publisherImage,
                publisherName: widget.publisherName,
                description: widget.description,
                descriptionImage: widget.descriptionImage,
                title: widget.title,
                url: widget.url,
              );
            } else if (cubit.favColor == Colors.white) {
              AppCubit.clickedFav = false;
              cubit.deleteData(url: widget.url);
            }*/