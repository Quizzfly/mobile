class PutUpdateQuizzflySettingsResp {
  String? status;
  Data? data;
  PutUpdateQuizzflySettingsResp({this.status, this.data});
  PutUpdateQuizzflySettingsResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? description;
  String? coverImage;
  dynamic theme;
  bool? isPublic;
  String? quizzflyStatus;
  String? createdAt;
  Data(
      {this.id,
      this.title,
      this.description,
      this.coverImage,
      this.theme,
      this.isPublic,
      this.quizzflyStatus,
      this.createdAt});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImage = json['cover_image'];
    theme = json['theme'];
    isPublic = json['is_public'];
    quizzflyStatus = json['quizzfly_status'];
    createdAt = json['created_at'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (coverImage != null) {
      data['cover_image'] = coverImage;
    }
    if (theme != null) {
      data['theme'] = theme;
    }
    if (isPublic != null) {
      data['is_public'] = isPublic;
    }
    if (quizzflyStatus != null) {
      data['quizzfly_status'] = quizzflyStatus;
    }
    if (createdAt != null) {
      data['created_at'] = createdAt;
    }
    return data;
  }
}
