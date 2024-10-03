class PostLoginReq {
  String? email;
  String? password;
  PostLoginReq({this.email, this.password});
  PostLoginReq.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (email != null) {
      data['email'] = email;
    }
    if (password != null) {
      data['password'] = password;
    }
    return data;
  }
}
