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
              child: Container(
                child: Center(
                  child: Text(
                    'Sqflite Demo',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
                title: Text(
                  'Category',
                  style: TextStyle(color: Colors.redAccent),
                ),
                leading: Icon(
                  Icons.category,
                  color: Colors.redAccent,
                ),
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
