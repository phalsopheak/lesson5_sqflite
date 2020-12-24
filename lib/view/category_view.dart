import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/controller/category_controller.dart';

class CategoryView extends StatelessWidget {
  final CategoryController cc = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed('/add_category'),
          )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: cc.listCategory.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildCategoryRow(
                cc.listCategory[index].id, cc.listCategory[index].categoryName);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryRow(int keyId, String categoryName) {
    return GestureDetector(
      onTap: () {
        cc.keyID = keyId;
        Get.toNamed('/add_category');
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(9),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(categoryName[0]),
                backgroundColor: Colors.redAccent,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                categoryName,
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
