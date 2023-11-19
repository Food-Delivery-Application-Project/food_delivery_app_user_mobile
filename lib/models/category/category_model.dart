class CategoryModel {
  String? sId;
  String? category;
  String? categoryThumbnail;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryModel(
      {this.sId,
      this.category,
      this.categoryThumbnail,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    categoryThumbnail = json['categoryThumbnail'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['categoryThumbnail'] = categoryThumbnail;
    data['categoryId'] = categoryId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
