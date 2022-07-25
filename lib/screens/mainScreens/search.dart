import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../model/cubit/appcCubit.dart';
import '../../model/cubit/appStates.dart';
import 'package:news_app/widgets/serchItem.dart';

import '../../constants.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Column(
              children: [
                TextFormField(
                  autofocus: true,
                  enabled: true,
                  controller: search,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  onChanged: (value) {
                    cubit.searchAbout(search.value.text);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Conditional.single(
                    context: context,
                    conditionBuilder: (context) => cubit.search.length > 0,
                    widgetBuilder: (context) => ListView.separated(
                      itemBuilder: (context, index) => SearchItem(
                        url: cubit.search[index]['url'].toString(),
                        profileImageUrl:
                            cubit.search[index]['urlToImage'].toString(),
                        title: cubit.search[index]['title'].toString(),
                      ),
                      separatorBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        color: const Color(0xFF232836),
                        height: 2,
                        width: 35,
                      ),
                      itemCount: cubit.search.length,
                    ),
                    fallbackBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
