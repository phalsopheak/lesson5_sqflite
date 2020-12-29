import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/controller/product_controller.dart';
import 'package:lesson_5_sqflite/model/category_model.dart';

class ProductAddView extends StatelessWidget {
  final ProductController pc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<ProductController>(
          builder: (pc) =>
              pc.keyID == 0 ? Text('Add Product') : Text('Update Product'),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (pc) => SingleChildScrollView(
          child: Container(
            child: Form(
              key: pc.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: DropdownButtonFormField<CategoryModel>(
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.redAccent,
                      ),
                      validator: (value) =>
                          value.categoryName == 'Select Category'
                              ? 'Select category'
                              : null,
                      value: pc.selectedCategory,
                      items: pc.listCategory.map((CategoryModel cm) {
                        return DropdownMenuItem<CategoryModel>(
                          value: cm,
                          child: Text(cm.categoryName),
                        );
                      }).toList(),
                      onChanged: (CategoryModel value) {
                        pc.selectedCategory = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      autofocus: true,
                      focusNode: pc.fn,
                      controller: pc.tecProductCode,
                      decoration: InputDecoration(
                        labelText: 'Product Code',
                      ),
                      validator: pc.nameValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: pc.tecProductName,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                      ),
                      validator: pc.nameValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: pc.tecProductPrice,
                      decoration: InputDecoration(
                        labelText: 'Product Price',
                      ),
                      validator: pc.nameValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      controller: pc.tecProductDescription,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                      ),
                      validator: pc.nameValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: TextFormField(
                      onTap: () => pc.showDate(context),
                      controller: pc.tecTimestamp,
                      decoration: InputDecoration(
                        labelText: 'Date Create',
                      ),
                      validator: pc.nameValidator,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      onPressed: () => pc.insertProduct(),
                      child: Text(
                        pc.keyID == 0 ? 'Save' : 'Update',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
