import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lesson_5_sqflite/model/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lesson_5_sqflite/service/sqflite_service.dart';

class CategoryController extends GetxController {
  // 0= add new , not 0 = edit
  var keyID = 0;
  var listCategory = List<CategoryModel>().obs;

  var formKey = GlobalKey<FormState>();

  TextEditingController tecCategoryName;
  FocusNode fn;

  var nameValidator = MultiValidator([
    RequiredValidator(errorText: 'category name is required'),
  ]);

  @override
  void onInit() {
    readCategory();
    tecCategoryName = TextEditingController();
    fn = FocusNode();
    super.onInit();
  }

  @override
  onClose() {
    tecCategoryName.dispose();
    fn.dispose();
    super.onClose();
  }

  loadEditForm(int keyId) async {
    keyID = keyId;
    var list = await SqfliteService.instance
        .read(tableName: 'tbl_category', id: keyId);
    tecCategoryName.text = list[0]['category_name'];
    fn.requestFocus();
    tecCategoryName.selection =
        TextSelection(baseOffset: 0, extentOffset: tecCategoryName.text.length);
  }

  loadAddForm() {
    keyID = 0;
    tecCategoryName.text = '';
    fn.requestFocus();
  }

  readCategory() async {
    listCategory.clear();
    var list = await SqfliteService.instance.read(tableName: 'tbl_category');

    list.forEach((element) {
      listCategory.add(CategoryModel.fromMap(element));
    });
  }

  insertCategory() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      int id = 0;
      //=0
      if (keyID == 0) {
        var model = CategoryModel(
          categoryName: tecCategoryName.text,
        );
        id = await SqfliteService.instance
            .create(model.toMapNoId(), 'tbl_category');
        model = CategoryModel(
          id: id,
          categoryName: tecCategoryName.text,
        );
        listCategory.add(model);
      } else {
        var model = CategoryModel(
          id: keyID,
          categoryName: tecCategoryName.text,
        );
        id =
            await SqfliteService.instance.update(model.toMap(), 'tbl_category');
        readCategory();
      }

      Get.back();
    }
  }

  deleteCategory(int keyId) async {
    var id = await SqfliteService.instance.delete(keyId, 'tbl_category');
    readCategory();
    Get.back();
  }
}
