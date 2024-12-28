class PostReactPostResp {
  String? status;

  PostReactPostResp({
    this.status,
  });

  PostReactPostResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    return data;
  }
}
