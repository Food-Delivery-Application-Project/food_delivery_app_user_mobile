class ReviewModel {
  UserId? userId;
  String? text;

  ReviewModel({this.userId, this.text});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['text'] = text;
    return data;
  }
}

class UserId {
  String? sId;
  String? profileImage;
  String? fullname;

  UserId({this.sId, this.profileImage, this.fullname});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['ProfileImage'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ProfileImage'] = profileImage;
    data['fullname'] = fullname;
    return data;
  }
}
