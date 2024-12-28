class FileReq {
  String? publicId;
  String? originalFilename;
  String? format;
  String? resourceType;
  String? url;
  int? bytes;

  FileReq({
    this.publicId,
    this.originalFilename,
    this.format,
    this.resourceType,
    this.url,
    this.bytes,
  });

  FileReq.fromJson(Map<String, dynamic> json) {
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

class PostNewPostReq {
  String? type;
  String? content;
  String? quizzflyId;
  List<FileReq>? files;

  PostNewPostReq({
    this.type,
    this.content,
    this.quizzflyId,
    this.files,
  });

  PostNewPostReq.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    quizzflyId = json['quizzfly_id'];
    if (json['files'] != null) {
      files = <FileReq>[];
      json['files'].forEach((v) {
        files!.add(FileReq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (type != null) {
      data['type'] = type;
    }
    if (content != null) {
      data['content'] = content;
    }
    if (quizzflyId != null) {
      data['quizzfly_id'] = quizzflyId;
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
