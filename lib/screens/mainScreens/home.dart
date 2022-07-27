import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cubit/appcCubit.dart';
import '../../model/cubit/appStates.dart';
import 'package:news_app/screens/mainScreens/search.dart';
import 'package:news_app/screens/mainScreens/settings.dart';
import 'package:news_app/screens/mainScreens/signIn.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cloudDb = FirebaseFirestore.instance;
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, states) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: SizedBox(
                height: 40.0,
                child: TextFormField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    label: Text("Search"),
                    labelStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(45, 51, 62, 80),
                    prefixIconColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  onTap: () {
                    AppCubit.navTo(
                      context,
                      const SignIn(),
                    );
                  },
                ),
              ),
              actions: [
                IconButton(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 2, right: 5),
                  constraints: const BoxConstraints(
                    maxHeight: 90,
                    maxWidth: 90,
                    minHeight: 50,
                    minWidth: 50,
                  ),
                  splashRadius: 25,
                  onPressed: () {
                    AppCubit.navTo(
                      context,
                      const UserSettings(),
                    );
                  },
                  icon: ClipOval(
                    child: Image.network(cubit.userImageProfileUrl),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomScreens,
              onTap: (value) => cubit.indexChanged(value),
              currentIndex: cubit.currentIndex,
            ),
            body: Container(
              padding: const EdgeInsets.only(
                left: 16,
                top: 10,
                right: 16,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discover",
                        style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      cubit.dropDownButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  cubit.screens[cubit.currentIndex],
                ],
              ),
            ),
          );
        },
        listener: (context, states) {});
  }
}
