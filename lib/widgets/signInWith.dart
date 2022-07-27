import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/cubit/appStates.dart';
import 'package:news_app/model/cubit/appcCubit.dart';
import '../../model/writeReadDataFormFireBase.dart';

class SignInOrUpWith extends StatelessWidget {
  final String imagePath;

  const SignInOrUpWith({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, states) {
          AppCubit cubit = AppCubit.get(context);
          return TextButton(
            onPressed: () async {
              cubit.userData(
                await signInWithGoogle(context),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        listener: (context, states) {});
  }
}
