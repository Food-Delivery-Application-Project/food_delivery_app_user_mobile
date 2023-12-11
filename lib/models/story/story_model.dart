class StoryModel {
  String? sId;
  FoodId? foodId;
  String? caption;
  int? status;
  int? expireIn;
  String? createdAt;
  String? updatedAt;
  int? iV;

  StoryModel({
    this.sId,
    this.foodId,
    this.caption,
    this.status,
    this.expireIn,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    foodId = json['foodId'] != null ? FoodId.fromJson(json['foodId']) : null;
    caption = json['caption'];
    status = json['status'];
    expireIn = json['expireIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (foodId != null) {
      data['foodId'] = foodId!.toJson();
    }
    data['caption'] = caption;
    data['status'] = status;
    data['expireIn'] = expireIn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class FoodId {
  String? sId;
  String? foodName;
  int? price;
  String? image;

  FoodId({this.sId, this.foodName, this.price, this.image});

  FoodId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    foodName = json['foodName'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['foodName'] = foodName;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
