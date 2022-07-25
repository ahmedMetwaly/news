import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cubit/appcCubit.dart';
import '../../model/cubit/appStates.dart';
import 'package:news_app/widgets/lineSeperator.dart';
import 'favPage.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            "Hello, Ahmed Mohamed",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Expanded(
                          flex: 4,
                          child: CircleAvatar(
                            foregroundImage: AssetImage("assets/images/me.jpg"),
                            radius: 100,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Change Image",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Text(
                                "Dark Theme",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Switch(
                                value: cubit.isDark,
                                onChanged: (value) {
                                  cubit.switchValue(fromButton: value);
                                },
                                inactiveTrackColor: Colors.grey,
                                activeColor: Theme.of(context)
                                    .appBarTheme
                                    .iconTheme
                                    ?.color,
                              ),
                            ],
                          ),
                        ),
                        LineSeperator(
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        ),
                        InkWell(
                          onTap: () async {
                            AppCubit.navTo(
                              context,
                              const FavPage(),
                            );
                            await cubit.getData(AppCubit.favNews);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  "Favourite",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: cubit.isDark == true
                                      ? Colors.yellow
                                      : const Color(0xFFF5564B),
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                        LineSeperator(
                          color: cubit.isDark == true
                              ? Colors.yellow
                              : const Color(0xFFF5564B),
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.deleteAllData();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: cubit.isDark == true
                                  ? Colors.yellow
                                  : const Color(0xFFF5564B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
