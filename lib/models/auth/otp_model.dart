class OtpModel {
  int? otp;

  OtpModel({this.otp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['Otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Otp'] = otp;
    return data;
  }
}
