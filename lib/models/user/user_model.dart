class UserModel {
  String? sId;
  String? email;
  String? phone;
  String? address;
  String? profileImage;
  String? fullname;

  UserModel(
      {this.sId,
      this.email,
      this.phone,
      this.address,
      this.profileImage,
      this.fullname});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phone = json['Phone'];
    address = json['address'];
    profileImage = json['ProfileImage'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['Phone'] = phone;
    data['address'] = address;
    data['ProfileImage'] = profileImage;
    data['fullname'] = fullname;
    return data;
  }
}
