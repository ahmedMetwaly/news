import 'package:dio/dio.dart';

class DIoClass {
  static late Dio dio;
  static void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        receiveTimeout: 4000,
        connectTimeout: 6000,
      ),
    );
  }

  static List b = [];
  static Future getData(
      {required url, required Map<String, dynamic> quiry}) async {
    return await dio
        .get(
      url,
      queryParameters: quiry,
    )
        .then((value) {
      b = value.data['articles'];
      //print(b);
      return b;
    });
  }
}
