class RegisterUserModel {
  String? userId;
  String? name;
  String? birthdate;
  String? gender;
  String? pushToken;
  String? profilePicB64;

  RegisterUserModel(
      {this.userId,
      this.name,
      this.birthdate,
      this.gender,
      this.pushToken,
      this.profilePicB64});

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    pushToken = json['pushToken'];
    profilePicB64 = json['profilePicB64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['birthdate'] = birthdate;
    data['gender'] = gender;
    data['pushToken'] = pushToken;
    data['profilePicB64'] = profilePicB64;
    return data;
  }
}
