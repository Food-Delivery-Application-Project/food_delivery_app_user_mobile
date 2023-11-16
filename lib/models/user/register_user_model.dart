import 'dart:io';

class RegisterUserModel {
  String? userId;
  String? name;
  String? phone;
  String? pushToken;
  File? profilePic;

  RegisterUserModel({
    this.userId,
    this.name,
    this.phone,
    this.profilePic,
    this.pushToken,
  });
}
