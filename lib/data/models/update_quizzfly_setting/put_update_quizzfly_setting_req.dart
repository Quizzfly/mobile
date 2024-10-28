class PutUpdateQuizzflySettingsReq {
  String? title;
  String? description;
  bool? isPublic;
  String? coverImage;
  PutUpdateQuizzflySettingsReq(
      {this.title, this.description, this.isPublic, this.coverImage});
  PutUpdateQuizzflySettingsReq.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isPublic = json['is_public'];
    coverImage = json['cover_image'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title;
    }
    if (description != null) {
      data['description'] = description;
    }
    if (isPublic != null) {
      data['is_public'] = isPublic;
    }
    if (coverImage != null) {
      data['cover_image'] = coverImage;
    }
    return data;
  }
}
