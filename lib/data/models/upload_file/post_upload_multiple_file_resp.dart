class UploadMultipleFileResp {
  String? status;
  List<Data>? data;

  UploadMultipleFileResp({this.status, this.data});

  UploadMultipleFileResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? publicId;
  String? originalFilename;
  String? format;
  String? resourceType;
  String? url;
  int? bytes;

  Data({
    this.publicId,
    this.originalFilename,
    this.format,
    this.resourceType,
    this.url,
    this.bytes,
  });

  Data.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    originalFilename = json['original_filename'];
    format = json['format'];
    resourceType = json['resource_type'];
    url = json['url'];
    bytes = json['bytes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
