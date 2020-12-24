import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite Demo'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text('Sqflite Demo'),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
                title: Text('Category'),
                leading: Icon(Icons.category),
                onTap: () {
                  Get.back();
                  Get.toNamed('/category');
                }),
          ],
        ),
      ),
    );
  }
}
