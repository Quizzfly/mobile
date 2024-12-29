class PostCommentReq {
  String? parentCommentId;
  String? content;
  List<CommentFile>? files;

  PostCommentReq({
    this.parentCommentId,
    this.content,
    this.files,
  });

  PostCommentReq.fromJson(Map<String, dynamic> json) {
    parentCommentId = json['parent_comment_id'];
    content = json['content'];
    if (json['files'] != null) {
      files = <CommentFile>[];
      json['files'].forEach((v) {
        files!.add(CommentFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (parentCommentId != null) {
      data['parent_comment_id'] = parentCommentId;
    }
    if (content != null) {
      data['content'] = content;
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentFile {
  String? publicId;
  String? originalFilename;
  String? format;
  String? resourceType;
  String? url;
  int? bytes;

  CommentFile({
    this.publicId,
    this.originalFilename,
    this.format,
    this.resourceType,
    this.url,
    this.bytes,
  });

  CommentFile.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    originalFilename = json['original_filename'];
    format = json['format'];
    resourceType = json['resource_type'];
    url = json['url'];
    bytes = json['bytes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (publicId != null) {
      data['public_id'] = publicId;
    }
    if (originalFilename != null) {
      data['original_filename'] = originalFilename;
    }
    if (format != null) {
      data['format'] = format;
    }
    if (resourceType != null) {
      data['resource_type'] = resourceType;
    }
    if (url != null) {
      data['url'] = url;
    }
    if (bytes != null) {
      data['bytes'] = bytes;
    }
    return data;
  }
}