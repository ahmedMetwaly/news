import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  final double radius;
  const ProfileImage({
    required this.profileImage,
    this.radius = 27,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileImage == "null"
        ? CircleAvatar(
            radius: radius,
            foregroundImage:
                const AssetImage('assets/images/nbc-social-default.png'),
          )
        : CircleAvatar(
            radius: radius,
            foregroundImage: NetworkImage(
              profileImage,
            ),
          );
  }
}
