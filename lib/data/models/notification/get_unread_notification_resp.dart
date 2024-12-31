class GetUnreadNotificationResp {
  String? status;
  int? dataCount;
  GetUnreadNotificationResp({
    this.status,
    this.dataCount,
  });

  GetUnreadNotificationResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataCount = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (dataCount != null) {
      data['status'] = dataCount;
    }
    return data;
  }
}
