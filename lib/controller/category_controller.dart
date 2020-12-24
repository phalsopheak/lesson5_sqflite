import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lesson_5_sqflite/helper/database_ref.dart';
import 'package:lesson_5_sqflite/model/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lesson_5_sqflite/service/sqflite_service.dart';

class CategoryController extends GetxController {
  var keyID = 0;
  var listCategory = List<CategoryModel>().obs;

  var formKey = GlobalKey<FormState>();

  var txtCategoryName = '';

  var nameValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
  ]);

  @override
  void onInit() {
    readCategory();
    super.onInit();
  }

  String getButtonSaveText() {
    if (keyID == 0) {
      return 'Save';
    } else {
      return 'Update';
    }
  }

  readCategory() async {
    var list = await SqfliteService.instance.read('tbl_category');

    list.forEach((element) {
      listCategory.add(CategoryModel.fromMap(element));
    });
  }

  insertCategory() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var model = CategoryModel(
        categoryName: txtCategoryName,
      );

      int id = await SqfliteService.instance
          .create(model.toMapNoId(), 'tbl_category');

      model = CategoryModel(
        id: id,
        categoryName: txtCategoryName,
      );
      listCategory.add(model);

      Get.back();
    }
  }
}
