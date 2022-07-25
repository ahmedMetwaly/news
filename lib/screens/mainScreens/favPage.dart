import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/widgets/newsWidget.dart';

import '../../model/cubit/appcCubit.dart';
import '../../model/cubit/appStates.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Column(
            children: [
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
                    "Clear Favourites",
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(cubit.favData[index]["url"].toString()),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: NewsWidget(
                            index: index,
                            title: cubit.favData[index]["title"],
                            description: cubit.favData[index]["description"],
                            publisherImage: cubit.favData[index]
                                ["publisherImage"],
                            publisherName: cubit.favData[index]
                                ["publisherName"],
                            descriptionImage: cubit.favData[index]
                                ["descriptionImage"],
                            url: cubit.favData[index]["url"],
                          ),
                        ),
                        onDismissed: (direction) {
                          AppCubit.get(context)
                              .deleteData(url: cubit.favData[index]["url"]);
                          cubit.getData(AppCubit.favNews);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: cubit.favData.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
