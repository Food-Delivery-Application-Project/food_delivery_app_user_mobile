class LoginModel {
  String? sId;
  String? isVerified;
  String? accessToken;

  LoginModel({this.sId, this.isVerified, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isVerified = json['isVerified'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['isVerified'] = isVerified;
    data['accessToken'] = accessToken;
    return data;
  }
}
