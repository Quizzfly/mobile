class PostChangePasswordResp {
  String? status;
  PostChangePasswordResp({this.status});
  PostChangePasswordResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    return data;
  }
}
