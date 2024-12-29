class PostRefreshTokenReq {
  String? refreshToken;
  PostRefreshTokenReq({this.refreshToken});
  PostRefreshTokenReq.fromJson(Map<String, dynamic> json) {
    refreshToken = json['refreshToken'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (refreshToken != null) {
      data['refreshToken'] = refreshToken;
    }
    return data;
  }
}
