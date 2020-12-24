import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/view/category_add_view.dart';
import 'package:lesson_5_sqflite/view/category_view.dart';

import 'view/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      initialRoute: '/',
      //initialBinding: CounterBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeView(),
        ),
        GetPage(
          name: '/category',
          page: () => CategoryView(),
        ),
        GetPage(
          name: '/add_category',
          page: () => CategoryAddView(),
        ),
      ],
    );
  }
}

class InitBinding implements Bindings {
  @override
  void dependencies() {
    //Get.put<ListController>(ListController());
  }
}
