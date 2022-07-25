import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/screens/mainScreens/connectionError.dart';
import 'package:news_app/screens/mainScreens/home.dart';
import 'constants.dart';
import 'model/SharedPrefrence/shared_prefrence.dart';
import 'model/cubit/appcCubit.dart';
import 'model/cubit/appStates.dart';
import 'model/dioPackage/dio.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  DIoClass.initDio();
  AppCubit().webViewInit();
  bool? fromShared = CashHelper.getData(key: "isDark");
  bool? isConnected = await InternetConnectionChecker().hasConnection;

  runApp(
    NewsApp(
      fromShared: fromShared,
      isConnected: isConnected,
    ),
  );
}

class NewsApp extends StatelessWidget {
  final bool? fromShared;
  final bool isConnected;

  const NewsApp({Key? key, this.fromShared, required this.isConnected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppCubit()
                  ..switchValue(fromShared: fromShared)
                  ..createDataBase()
                  ..getBusiness()
                  ..getEntertainment()
                  ..getHealth()
                  ..getScience()
                  ..getSports(),
              ),
            ],
            child: BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  AppCubit cubit = AppCubit.get(context);
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "News App",
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                    home: const Home(),
                  );
                }),
          )
        : BlocProvider<AppCubit>(
            create: (context) => AppCubit(),
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "News App",
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                  home: const ConnectionError(),
                );
              },
            ),
          );
  }
}
