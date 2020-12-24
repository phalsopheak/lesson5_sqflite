import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryRow extends StatelessWidget {
  final int keyId;
  final String categoryName;

  const CategoryRow({Key key, this.keyId, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/add_category');
      },
      child: Card(
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                child: Text(categoryName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
