class IsFavoriteModel {
  bool? isFavorite;

  IsFavoriteModel({this.isFavorite});

  IsFavoriteModel.fromJson(Map<String, dynamic> json) {
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFavorite'] = isFavorite;
    return data;
  }
}
