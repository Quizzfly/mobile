class PostInviteMemberReq {
  List<String>? emails;

  PostInviteMemberReq({this.emails});

  PostInviteMemberReq.fromJson(Map<String, dynamic> json) {
    emails = json['emails']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (emails != null) {
      data['emails'] = emails;
    }
    return data;
  }
}
