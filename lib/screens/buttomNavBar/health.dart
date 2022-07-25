import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/widgets/displayNews.dart';

import '../../model/cubit/appcCubit.dart';
import '../../model/cubit/appStates.dart';
class Health extends StatelessWidget {
  const Health({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return DisplayData(
          category: cubit.health,
        );
      },
    );
  }
}
