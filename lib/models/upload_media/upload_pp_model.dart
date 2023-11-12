class UploadPPModel {
  String? filePath;
  String? contentType;
  int? fileSize;

  UploadPPModel({this.filePath, this.contentType, this.fileSize});

  UploadPPModel.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    contentType = json['contentType'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filePath'] = filePath;
    data['contentType'] = contentType;
    data['fileSize'] = fileSize;
    return data;
  }
}
