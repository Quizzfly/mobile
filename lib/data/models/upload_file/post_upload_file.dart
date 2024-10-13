class UploadFileResp {
  String? status;
  Data? data;

  UploadFileResp({this.status, this.data});

  UploadFileResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? originalFilename;
  String? format;
  String? resourceType;
  String? url;
  int? bytes;

  Data({
    this.originalFilename,
    this.format,
    this.resourceType,
    this.url,
    this.bytes,
  });

  Data.fromJson(Map<String, dynamic> json) {
    originalFilename = json['original_filename'];
    format = json['format'];
    resourceType = json['resource_type'];
    url = json['url'];
    bytes = json['bytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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