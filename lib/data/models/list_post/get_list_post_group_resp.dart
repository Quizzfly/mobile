class GetListPostGroupResp {
  String? status;
  List<PostData>? data;

  GetListPostGroupResp({
    this.status,
    this.data,
  });

  GetListPostGroupResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(PostData.fromJson(v));
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

class PostData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? content;
  List<FileData>? files;
  QuizzflyData? quizzfly;
  MemberData? member;
  int? reactCount;
  int? commentCount;
  bool? isLiked;

  PostData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.content,
    this.files,
    this.quizzfly,
    this.member,
    this.reactCount,
    this.commentCount,
    this.isLiked,
  });

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    content = json['content'];

    if (json['files'] != null) {
      files = <FileData>[];
      json['files'].forEach((v) {
        files!.add(FileData.fromJson(v));
      });
    }

    quizzfly = json['quizzfly'] != null
        ? QuizzflyData.fromJson(json['quizzfly'])
        : null;

    member =
        json['member'] != null ? MemberData.fromJson(json['member']) : null;

    reactCount = json['react_count'];
    commentCount = json['comment_count'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (type != null) data['type'] = type;
    if (content != null) data['content'] = content;

    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }

    if (quizzfly != null) {
      data['quizzfly'] = quizzfly!.toJson();
    }

    if (member != null) {
      data['member'] = member!.toJson();
    }

    if (reactCount != null) data['react_count'] = reactCount;
    if (commentCount != null) data['comment_count'] = commentCount;
    if (isLiked != null) data['is_liked'] = isLiked;

    return data;
  }
}

class FileData {
  String? publicId;
  String? originalFilename;
  String? format;
  String? resourceType;
  String? url;
  int? bytes;

  FileData({
    this.publicId,
    this.originalFilename,
    this.format,
    this.resourceType,
    this.url,
    this.bytes,
  });

  FileData.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    originalFilename = json['original_filename'];
    format = json['format'];
    resourceType = json['resource_type'];
    url = json['url'];
    bytes = json['bytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (publicId != null) data['public_id'] = publicId;
    if (originalFilename != null) data['original_filename'] = originalFilename;
    if (format != null) data['format'] = format;
    if (resourceType != null) data['resource_type'] = resourceType;
    if (url != null) data['url'] = url;
    if (bytes != null) data['bytes'] = bytes;
    return data;
  }
}

class QuizzflyData {
  String? id;
  String? title;
  String? description;
  String? coverImage;
  String? theme;
  bool? isPublic;
  String? quizzflyStatus;

  QuizzflyData({
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.theme,
    this.isPublic,
    this.quizzflyStatus,
  });

  QuizzflyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImage = json['cover_image'];
    theme = json['theme'];
    isPublic = json['is_public'];
    quizzflyStatus = json['quizzfly_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (coverImage != null) data['cover_image'] = coverImage;
    if (theme != null) data['theme'] = theme;
    if (isPublic != null) data['is_public'] = isPublic;
    if (quizzflyStatus != null) data['quizzfly_status'] = quizzflyStatus;
    return data;
  }
}

class MemberData {
  String? id;
  String? username;
  String? avatar;
  String? name;

  MemberData({
    this.id,
    this.username,
    this.avatar,
    this.name,
  });

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (username != null) data['username'] = username;
    if (avatar != null) data['avatar'] = avatar;
    if (name != null) data['name'] = name;
    return data;
  }
}
