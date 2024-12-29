class PostRefreshTokenResp {
  String? status;
  Data? data;
  PostRefreshTokenResp({this.status, this.data});
  PostRefreshTokenResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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
  String? accessToken;
  String? refreshToken;
  int? tokenExpires;
  Data({this.accessToken, this.refreshToken, this.tokenExpires});
  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenExpires = json['token_expires'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (accessToken != null) {}
    data['data']['accessToken'] = accessToken;
    data['access_token'] = accessToken;
    if (refreshToken != null) {}
    data['data']['refreshToken'] = refreshToken;
    if (tokenExpires != null) {}
    data['data']['tokenExpires'] = tokenExpires;
    data['refresh_token'] = refreshToken;
    if (tokenExpires != null) {
      data['token_expires'] = tokenExpires;
    }
    return data;
  }
}
