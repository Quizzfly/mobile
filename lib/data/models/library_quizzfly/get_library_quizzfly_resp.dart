class GetLibraryQuizzflyResp {
  String? status;
  List<QuizzflyData>? data;

  GetLibraryQuizzflyResp({
    this.status,
    this.data,
  });

  GetLibraryQuizzflyResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <QuizzflyData>[];
      json['data'].forEach((v) {
        data!.add(QuizzflyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizzflyData {
  String? id;
  String? title;
  String? coverImage;
  String? quizzflyStatus;
  String? createdAt;
  bool? isPublic;
  String? userId;
  String? username;
  String? avatar;

  QuizzflyData({
    this.id,
    this.title,
    this.coverImage,
    this.quizzflyStatus,
    this.createdAt,
    this.isPublic,
    this.userId,
    this.username,
    this.avatar,
  });

  QuizzflyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImage = json['cover_image'];
    quizzflyStatus = json['quizzfly_status'];
    createdAt = json['created_at'];
    isPublic = json['is_public'];
    userId = json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (title != null) data['title'] = title;
    if (coverImage != null) data['cover_image'] = coverImage;
    if (quizzflyStatus != null) data['quizzfly_status'] = quizzflyStatus;
    if (createdAt != null) data['created_at'] = createdAt;
    if (isPublic != null) data['is_public'] = isPublic;
    if (userId != null) data['user_id'] = userId;
    if (username != null) data['username'] = username;
    if (avatar != null) data['avatar'] = avatar;
    return data;
  }
}