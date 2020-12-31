import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_5_sqflite/controller/product_controller.dart';
import 'package:lesson_5_sqflite/model/view_model/product_category_model.dart';

class ProductView extends StatelessWidget {
  final ProductController pc = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          pc.loadAddForm();
          Get.toNamed('/add_product');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Obx(
          () => ListTile(
            title: Text(
              'Product List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              ' ${pc.listProduct.length} record',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: pc.listProduct.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildCategoryRow(pc.listProduct[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryRow(ProductCategoryModel pcModel) {
    return GestureDetector(
      onTap: () {
        pc.loadEditForm(pcModel.id);
        Get.toNamed('/add_product');
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(9),
          child: Row(
            children: [
              Container(
                child: pcModel.productPicture == null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 3,
                        ),
                        child: CircleAvatar(
                          child: Text(pcModel.productName[0]),
                          backgroundColor: Colors.redAccent,
                        ),
                      )
                    : Image.file(
                        File(pcModel.productPicture),
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pcModel.productName +
                          ' - ' +
                          pcModel.productPrice.toString() +
                          '\$',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      pcModel.categoryName,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Product',
                    content: Text('Do you want to delete this record?'),
                    confirm: RaisedButton(
                      color: Colors.redAccent,
                      onPressed: () => pc.deleteProduct(pcModel.id),
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
