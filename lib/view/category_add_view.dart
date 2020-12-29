import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/controller/category_controller.dart';

class CategoryAddView extends StatelessWidget {
  final CategoryController cc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<CategoryController>(
          builder: (lc) =>
              lc.keyID == 0 ? Text('Add Category') : Text('Update Category'),
        ),
      ),
      body: GetBuilder<CategoryController>(
        builder: (lc) => Center(
          child: Form(
            key: lc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: cc.fn,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    controller: lc.tecCategoryName,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                    ),
                    validator: lc.nameValidator,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    onPressed: () => lc.insertCategory(),
                    child: Text(
                      lc.keyID == 0 ? 'Save' : 'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
