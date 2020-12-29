import 'dart:math';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lesson_5_sqflite/model/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lesson_5_sqflite/model/product_model.dart';
import 'package:lesson_5_sqflite/model/view_model/product_category_model.dart';
import 'package:lesson_5_sqflite/service/sqflite_service.dart';

class ProductController extends GetxController {
  // 0= add new , not 0 = edit
  var keyID = 0;
  var listProduct = List<ProductCategoryModel>().obs;
  var listCategory = List<CategoryModel>();
  var selectedCategory = CategoryModel();
  var picturePath = '';
  var formKey = GlobalKey<FormState>();

  TextEditingController tecProductCode;
  TextEditingController tecProductName;
  TextEditingController tecProductPrice;
  TextEditingController tecProductDescription;
  TextEditingController tecTimestamp;

  FocusNode fn;

  var nameValidator = MultiValidator([
    RequiredValidator(errorText: 'category name is required'),
  ]);

  @override
  void onInit() {
    listCategory.add(
      CategoryModel(
        id: 0,
        categoryName: 'Select Category',
      ),
    );
    readCategory();
    selectedCategory = listCategory[0];
    readProduct();
    tecTimestamp = TextEditingController();
    tecProductCode = TextEditingController();
    tecProductName = TextEditingController();
    tecProductPrice = TextEditingController();

    tecProductDescription = TextEditingController();
    fn = FocusNode();
    super.onInit();
  }

  @override
  onClose() {
    tecTimestamp.dispose();
    tecProductCode.dispose();
    tecProductName.dispose();
    tecProductPrice.dispose();
    tecProductDescription.dispose();
    fn.dispose();
    super.onClose();
  }

  showDate(BuildContext context) async {
    DatePicker.showDateTimePicker(context,
        theme: DatePickerTheme(
          headerColor: Colors.redAccent,
          doneStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        showTitleActions: true,
        minTime: DateTime(1900, 3, 5),
        maxTime: DateTime(2100, 6, 7), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      tecTimestamp.text = date.toString();
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  loadCategory(int id) {
    listCategory.forEach((element) {
      if (element.id == id) {
        selectedCategory = element;
      }
    });
  }

  loadEditForm(int keyId) async {
    keyID = keyId;
    var list = await SqfliteService.instance
        .read(tableName: 'v_list_product', id: keyId);

    // selectedCategory = CategoryModel(
    //   id: list[0]['category_id'],
    //   categoryName: list[0]['category_name'],
    // );

    loadCategory(list[0]['category_id']);

    tecProductCode.text = list[0]['product_code'];
    //set focus and select all to field code
    fn.requestFocus();
    tecProductCode.selection =
        TextSelection(baseOffset: 0, extentOffset: tecProductCode.text.length);

    tecProductName.text = list[0]['product_name'];
    tecProductPrice.text = list[0]['product_price'].toString();
    tecProductDescription.text = list[0]['product_description'];
    tecTimestamp.text = list[0]['timestamp'];
  }

  loadAddForm() {
    keyID = 0;
    tecProductCode.text = '';
    fn.requestFocus();
    tecProductName.text = '';
    tecProductPrice.text = '0';
    tecProductDescription.text = '';
    tecTimestamp.text = '';
  }

  readCategory() async {
    var list = await SqfliteService.instance.read(tableName: 'tbl_category');

    list.forEach((element) {
      listCategory.add(CategoryModel.fromMap(element));
    });
  }

  readProduct() async {
    listProduct.clear();
    var list = await SqfliteService.instance.read(tableName: 'v_list_product');

    list.forEach((element) {
      listProduct.add(ProductCategoryModel.fromMap(element));
    });
  }

  insertProduct() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      int id = 0;
      //=0
      if (keyID == 0) {
        var model = ProductModel(
          categoryId: selectedCategory.id,
          productCode: tecProductCode.text,
          productName: tecProductName.text,
          productPrice: double.parse(tecProductPrice.text),
          productPicture: '',
          productDescription: tecProductDescription.text,
          timestamp: DateTime.parse(tecTimestamp.text),
        );
        id = await SqfliteService.instance
            .create(model.toMapNoId(), 'tbl_product');

        var cm = ProductCategoryModel(
          id: id,
          categoryId: selectedCategory.id,
          categoryName: selectedCategory.categoryName,
          productCode: tecProductCode.text,
          productName: tecProductName.text,
          productPrice: double.parse(tecProductPrice.text),
          productPicture: '',
          productDescription: tecProductDescription.text,
          timestamp: DateTime.parse(tecTimestamp.text),
        );
        listProduct.add(cm);
      } else {
        var model = ProductModel(
          id: keyID,
          categoryId: selectedCategory.id,
          productCode: tecProductCode.text,
          productName: tecProductName.text,
          productPrice: double.parse(tecProductPrice.text),
          productPicture: '',
          productDescription: tecProductDescription.text,
          timestamp: DateTime.parse(tecTimestamp.text),
        );
        id = await SqfliteService.instance.update(model.toMap(), 'tbl_product');
        readProduct();
      }

      Get.back();
    }
  }

  deleteProduct(int keyId) async {
    var id = await SqfliteService.instance.delete(keyId, 'tbl_product');
    readProduct();
    Get.back();
  }
}
