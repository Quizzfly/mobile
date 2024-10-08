class PostLoginResp {
  String? status;
  String? userId;
  String? accessToken;
  String? refreshToken;
  double? tokenExpires;
  PostLoginResp(
      {this.status,
      this.userId,
      this.accessToken,
      this.refreshToken,
      this.tokenExpires});
  PostLoginResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['data']['userId'];
    accessToken = json['data']['accessToken'];
    refreshToken = json['data']['refreshToken'];
    tokenExpires = json['data']['tokenExpires'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (userId != null) {}
    data['data']['userId'] = userId;
    if (accessToken != null) {}
    data['data']['accessToken'] = accessToken;
    if (refreshToken != null) {}
    data['data']['refreshToken'] = refreshToken;
    if (tokenExpires != null) {}
    data['data']['tokenExpires'] = tokenExpires;
    return data;
  }
}
