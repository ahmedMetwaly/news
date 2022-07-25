import 'package:flutter/material.dart';

import '../../main.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                "assets/images/connectionError.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Check the internet connection, please ?"),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: (){
                main();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Retry",
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
