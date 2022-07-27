import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/buttomNavBar/business.dart';
import 'package:news_app/screens/buttomNavBar/entertainment.dart';
import 'package:news_app/screens/buttomNavBar/health.dart';
import 'package:news_app/screens/buttomNavBar/science.dart';
import 'package:news_app/screens/buttomNavBar/sports.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../SharedPrefrence/shared_prefrence.dart';
import '../dioPackage/dio.dart';
import 'appStates.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Map> favData = [];
  dynamic business = [];
  dynamic sports = [];
  dynamic entertainment = [];
  dynamic health = [];
  dynamic science = [];
  static Database? favNews;

  // switch between darkTheme and lightTheme
  bool isDark = false;

  void switchValue({bool? fromShared, bool? fromButton}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeSwitchValue());
    } else if (fromButton != null) {
      isDark = fromButton;
      CashHelper.putData(key: "isDark", value: isDark);
      emit(ChangeSwitchValue());
    }
  }

  //get data from Api newsApi.org
  Future getScience() async {
    print('getData Is called');
    emit(LoadingData());
    await DIoClass.getData(
      url: 'v2/top-headlines',
      quiry: {
        'country': dropDownValue,
        'category': "science",
        'apikey': '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then((value) {
      emit(DataIsRetrivedSuccesfully());
      science = value;
      print('success the value of Science is : $science');
      //print(bussinus);
    }).catchError(
      (error) {
        emit(DataHasError());
        print(error);
      },
    );
  }

  Future getHealth() async {
    print('getData Is called');
    emit(LoadingData());
    await DIoClass.getData(
      url: 'v2/top-headlines',
      quiry: {
        'country': dropDownValue,
        'category': "health",
        'apikey': '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then((value) {
      emit(DataIsRetrivedSuccesfully());
      health = value;
      print('success the value of Health is : $health');
      //print(bussinus);
    }).catchError(
      (error) {
        emit(DataHasError());
        print(error);
      },
    );
  }

  Future getEntertainment() async {
    print('getData Is called');
    emit(LoadingData());
    await DIoClass.getData(
      url: 'v2/top-headlines',
      quiry: {
        'country': dropDownValue,
        'category': "entertainment",
        'apikey': '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then((value) {
      emit(DataIsRetrivedSuccesfully());
      entertainment = value;
      print('success the value of Entertainment is : $entertainment');
      //print(bussinus);
    }).catchError(
      (error) {
        emit(DataHasError());
        print(error);
      },
    );
  }

  Future getSports() async {
    print('getData Is called');
    emit(LoadingData());
    await DIoClass.getData(
      url: 'v2/top-headlines',
      quiry: {
        'country': dropDownValue,
        'category': "sports",
        'apikey': '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then((value) {
      emit(DataIsRetrivedSuccesfully());
      sports = value;
      print('success the value of Sports is : $sports');
      //print(bussinus);
    }).catchError(
      (error) {
        emit(DataHasError());
        print(error);
      },
    );
  }

  Future getBusiness() async {
    print('getData Is called');
    emit(LoadingData());
    await DIoClass.getData(
      url: 'v2/top-headlines',
      quiry: {
        'country': dropDownValue,
        'category': "business",
        'apikey': '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then((value) {
      emit(DataIsRetrivedSuccesfully());
      business = value;
      print('success the value of business is : $business');
      //print(bussinus);
    }).catchError(
      (error) {
        emit(DataHasError());
        print(error);
      },
    );
  }

  //search Bar
  dynamic search = [];

  Future searchAbout(String searchTitle) async {
    search = [];
    print('Search starts');
    emit(LoadSearchData());
    await DIoClass.getData(
      url: "v2/everything",
      quiry: {
        "q": searchTitle,
        "sortBy": "popularity",
        "apikey": '3f6e44e9736949b79a97c733bbf2ed58',
      },
    ).then(
      (value) {
        emit(SearchedDataArrived());
        search = value;
        print(search);
        print("Search is done");
        return null;
      },
    ).catchError(
      (error) {
        emit(ErrorInArrivingSearchData());
        print(error);
      },
    );
  }

  // dropDown Button To Switch Between Countries and refresh data
  String dropDownValue = 'eg';

  Widget dropDownButton() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        value: dropDownValue,
        onChanged: (String? newValue)  {
          dropDownValue = newValue!;
          emit(ChangeDropDownValue());

          //get the data to reload the page
          getBusiness();
          getSports();
          getEntertainment();
          getHealth();
          getScience();


        },
        items: <String>[
          'eg',
          'us',
          'fr',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/images/$value.png'),
                  width: 40,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  value,
                  style: const TextStyle(color: Color(0xFF232836)),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

// BottomNavBar
  List<BottomNavigationBarItem> bottomScreens = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_rounded),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball_rounded),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie_filter_outlined),
      label: "Entertainment",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.health_and_safety_outlined),
      label: "Health",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_rounded),
      label: "Science",
    ),
  ];

  // list of screens of navBar
  List screens = const [
    Business(),
    Sports(),
    Entertainment(),
    Health(),
    Science(),
  ];

  //to change between screens
  int currentIndex = 0;

  void indexChanged(index) {
    currentIndex = index;
    emit(BottumNavBarIndexChanged());
  }

  // to initialize webView
  void webViewInit() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  // To Move from Function To another page
  static void navTo(context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  //Create dataBase
  void createDataBase() {
    print("CreateDataBase Function is called");
    openDatabase(
      "favNews.db",
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                "Create Table favouriteNews (id INTEGER PRIMARY KEY, title TEXT, description TEXT, publisherImage TEXT, publisherName TEXT, descriptionImage TEXT, url TEXT)")
            .then((value) {
          print("Table Is Created Successfully");
        }).catchError(
          (error) {
            print("it was an error : $error");
          },
        );
      },
      onOpen: (db) {
        print("data is opened");
        getData(db);
      },
    ).then((value) {
      favNews = value;
      emit(CreatedDataBaseSuccesfully());
    });
  }

  Future getData(Database? db) async {
    await db?.rawQuery('SELECT * FROM favouriteNews').then((value) {
      favData = value;
      emit(DataIsGot());
    });
  }

  void deleteData({required String url}) {
    favNews?.rawDelete('DELETE FROM favouriteNews WHERE url = ?', [url]).then(
        (value) {
      print('$value is deleted');
      emit(Deleted());
      getData(favNews);
    });
  }

  void deleteAllData() {
    favNews?.rawDelete('DELETE FROM favouriteNews').then(
      (value) {
        print("All data deleted");
        emit(DeleteAllData());
        getData(favNews);
      },
    );
  }

  // change user data
  String userImageProfileUrl = "https://firebasestorage.googleapis.com/v0/b/newsapp-1e98c.appspot.com/o/profilePic.png?alt=media&token=3df3443d-9dec-4110-8347-82e9ad994d90";
  String userName = "Visitor";
  Future userData(User? user) async{
    if(user!=null){
      userName = user.displayName!;
      userImageProfileUrl = user.photoURL!;
      emit(ChangeUserData(),);
    }
  }
}
