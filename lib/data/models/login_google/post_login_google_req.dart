class PostLoginGoogleReq {
  String? accessToken;
  PostLoginGoogleReq({this.accessToken});
  PostLoginGoogleReq.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (accessToken != null) {
      data['access_token'] = accessToken;
    }

    return data;
  }
}
