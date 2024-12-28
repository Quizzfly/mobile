// get_list_comment_resp.dart

class GetListCommentResp {
  String? status;
  List<CommentData>? data;

  GetListCommentResp({
    this.status,
    this.data,
  });

  GetListCommentResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CommentData>[];
      // Fix: Explicitly cast the list to List<dynamic> before mapping
      (json['data'] as List<dynamic>).forEach((v) {
        data!.add(CommentData.fromJson(v as Map<String, dynamic>));
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

class CommentData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? content;
  List<FileData>? files;
  MemberData? member;
  int? countReplies;
  String? parentCommentId;

  CommentData(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.files,
      this.member,
      this.countReplies,
      this.parentCommentId});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    content = json['content']?.toString();

    if (json['files'] != null) {
      files = <FileData>[];
      (json['files'] as List<dynamic>).forEach((v) {
        files!.add(FileData.fromJson(v as Map<String, dynamic>));
      });
    }

    member = json['member'] != null
        ? MemberData.fromJson(json['member'] as Map<String, dynamic>)
        : null;
    countReplies = json['count_replies'] as int?;
    parentCommentId = json['parent_comment_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (content != null) data['content'] = content;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (countReplies != null) data['count_replies'] = countReplies;
    if (parentCommentId != null) data['parent_comment_id'] = parentCommentId;
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
