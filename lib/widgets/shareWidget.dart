// import "package:flutter/material.dart";
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_app/cubit/appStates.dart';
// import 'package:news_app/cubit/appcCubit.dart';
//
// class ShareUrl extends StatelessWidget {
//   const ShareUrl({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, stat) {
//
//         AppCubit cubit = AppCubit.get(context);
//         return IconButton(
//           onPressed: () {
//             cubit.shareUrl();
//           },
//           icon: const Icon(
//             Icons.share,
//             color: Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatefulWidget {
  final String url;
  final String title;

  const ShareButton({
    required this.title,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return
       IconButton(
        icon:  Icon(
          Icons.share,
          color: Theme.of(context).textTheme.headline4?.color,
        ),
        onPressed: () {
          Share.share('${widget.title} \n Link : ${widget.url}');
        },

    );
  }
}
