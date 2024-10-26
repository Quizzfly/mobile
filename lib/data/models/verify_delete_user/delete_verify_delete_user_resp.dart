class DeleteVerifyDeleteUserResp {
  String? status;
  DeleteVerifyDeleteUserResp({this.status});
  DeleteVerifyDeleteUserResp.fromJson(Map<String, dynamic> json) {
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
