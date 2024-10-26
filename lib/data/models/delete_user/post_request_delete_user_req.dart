class PostRequestDeleteUserResp {
  String? status;
  PostRequestDeleteUserResp({this.status});
  PostRequestDeleteUserResp.fromJson(Map<String, dynamic> json) {
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
