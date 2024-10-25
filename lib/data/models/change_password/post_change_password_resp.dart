class PostChangePasswordReq {
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  PostChangePasswordReq(
      {this.oldPassword, this.newPassword, this.confirmNewPassword});
  PostChangePasswordReq.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
    confirmNewPassword = json['confirm_new_password'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (oldPassword != null) {
      data['old_password'] = oldPassword;
    }
    if (newPassword != null) {
      data['new_password'] = newPassword;
    }
    if (confirmNewPassword != null) {
      data['confirm_new_password'] = confirmNewPassword;
    }
    return data;
  }
}
