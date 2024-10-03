class PostLoginResp {
  String? userId;
  String? accessToken;
  String? refreshToken;
  double? tokenExpires;
  PostLoginResp(
      {this.userId, this.accessToken, this.refreshToken, this.tokenExpires});
  PostLoginResp.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    tokenExpires = json['tokenExpires'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (userId != null) {}
    data['userId'] = userId;
    if (accessToken != null) {}
    data['accessToken'] = accessToken;
    if (refreshToken != null) {}
    data['refreshToken'] = refreshToken;
    if (tokenExpires != null) {}
    data['tokenExpires'] = tokenExpires;
    return data;
  }
}
