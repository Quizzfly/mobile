class PostRegisterResp {
  String? userId;
  PostRegisterResp({this.userId});
  PostRegisterResp.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (userId != null) {
      data['userId'] = userId;
    }
    return data;
  }
}
