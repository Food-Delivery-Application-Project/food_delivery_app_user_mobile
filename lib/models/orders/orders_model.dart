class OrdersModel {
  User? user;
  String? orderId;
  int? totalPrice;
  String? address;

  OrdersModel({this.user, this.orderId, this.totalPrice, this.address});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    orderId = json['orderId'];
    totalPrice = json['totalPrice'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['orderId'] = orderId;
    data['totalPrice'] = totalPrice;
    data['address'] = address;
    return data;
  }
}

class User {
  int? phone;
  String? profileImage;
  String? fullname;

  User({this.phone, this.profileImage, this.fullname});

  User.fromJson(Map<String, dynamic> json) {
    phone = json['Phone'];
    profileImage = json['ProfileImage'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Phone'] = phone;
    data['ProfileImage'] = profileImage;
    data['fullname'] = fullname;
    return data;
  }
}
