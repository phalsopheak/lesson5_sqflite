class CategoryModel {
  int id;
  String categoryName;

  CategoryModel({this.id = 0, this.categoryName});

  Map<String, dynamic> toMapNoId() {
    return {
      'category_name': categoryName,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_name': categoryName,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      categoryName: map['category_name'],
    );
  }
}
