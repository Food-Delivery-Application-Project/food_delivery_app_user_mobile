class AuthModel {
  String? apiVersion;
  String? organizationName;
  String? message;
  int? responseCode;
  Data? data;

  AuthModel(
      {this.apiVersion,
      this.organizationName,
      this.message,
      this.responseCode,
      this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    organizationName = json['organizationName'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apiVersion'] = apiVersion;
    data['organizationName'] = organizationName;
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? accessToken;
  String? userName;
  String? userProfilePicLink;
  String? userEmail;
  bool? newUser;
  int? tokenExpirationMS;
  String? tokenExpiresAt;

  Data(
      {this.userId,
      this.accessToken,
      this.userName,
      this.userProfilePicLink,
      this.userEmail,
      this.newUser,
      this.tokenExpirationMS,
      this.tokenExpiresAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    userName = json['userName'];
    userProfilePicLink = json['userProfilePicLink'];
    userEmail = json['userEmail'];
    newUser = json['newUser'];
    tokenExpirationMS = json['tokenExpirationMS'];
    tokenExpiresAt = json['tokenExpiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['accessToken'] = accessToken;
    data['userName'] = userName;
    data['userProfilePicLink'] = userProfilePicLink;
    data['userEmail'] = userEmail;
    data['newUser'] = newUser;
    data['tokenExpirationMS'] = tokenExpirationMS;
    data['tokenExpiresAt'] = tokenExpiresAt;
    return data;
  }
}
