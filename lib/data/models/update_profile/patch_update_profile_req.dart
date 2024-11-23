class PatchUpdateProfileReq {
  String? name;
  String? avatar;

  PatchUpdateProfileReq({this.name, this.avatar});

  PatchUpdateProfileReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name;
    }
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    return data;
  }
}
