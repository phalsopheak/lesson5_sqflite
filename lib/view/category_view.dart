import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/controller/category_controller.dart';

class CategoryView extends StatelessWidget {
  final CategoryController cc = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          cc.loadAddForm();
          Get.toNamed('/add_category');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Obx(
          () => ListTile(
            title: Text(
              'Category List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              ' ${cc.listCategory.length} record',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
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
        cc.loadEditForm(keyId);
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
                width: 10,
              ),
              Expanded(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Category',
                    content: Text('Do you want to delete this record?'),
                    confirm: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () => cc.deleteCategory(keyId),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    cancel: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () => Get.back(),
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
