class ProductModel {
  int id;
  int categoryId;
  String productCode;
  String productName;
  double productPrice;
  String productPicture;
  String productDescription;
  DateTime timestamp;

  ProductModel(
      {this.id = 0,
      this.categoryId,
      this.productCode,
      this.productName,
      this.productPrice,
      this.productPicture,
      this.productDescription,
      this.timestamp});

  Map<String, dynamic> toMapNoId() {
    return {
      'category_id': categoryId,
      'product_code': productCode,
      'product_name': productName,
      'product_price': productPrice,
      'product_picture': productPicture,
      'product_description': productDescription,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'product_code': productCode,
      'product_name': productName,
      'product_price': productPrice,
      'product_picture': productPicture,
      'product_description': productDescription,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      productCode: map['product_code'],
      productName: map['product_name'],
      productPrice: map['product_price'],
      productPicture: map['product_picture'],
      productDescription: map['product_description'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
