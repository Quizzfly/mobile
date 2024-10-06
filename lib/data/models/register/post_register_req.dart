class PostRegisterReq {
  String? name;
  String? email;

  String? confirmPassword;
  String? password;
  PostRegisterReq({this.name, this.email, this.password, this.confirmPassword});
  PostRegisterReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (name != null) {
      data['name'] = email;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (password != null) {
      data['password'] = password;
    }
    
    if (confirmPassword != null) {
      data['confirm_password'] = confirmPassword;
    }
    return data;
  }
}
