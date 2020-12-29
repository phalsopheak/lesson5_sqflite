class ProductCategoryModel {
  int id;
  int categoryId;
  String categoryName;
  String productCode;
  String productName;
  double productPrice;
  String productPicture;
  String productDescription;
  DateTime timestamp;

  ProductCategoryModel(
      {this.id = 0,
      this.categoryId,
      this.categoryName,
      this.productCode,
      this.productName,
      this.productPrice,
      this.productPicture,
      this.productDescription,
      this.timestamp});

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      id: map['id'],
      categoryId: map['category_id'],
      categoryName: map['category_name'],
      productCode: map['product_code'],
      productName: map['product_name'],
      productPrice: map['product_price'],
      productPicture: map['product_picture'],
      productDescription: map['product_description'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
