class GetListNotificationResp {
  String? status;
  List<NotificationData>? data;

  GetListNotificationResp({
    this.status,
    this.data,
  });

  GetListNotificationResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      (json['data'] as List<dynamic>).forEach((v) {
        data!.add(NotificationData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? targetId;
  String? targetType;
  String? content;
  String? description;
  String? notificationType;
  bool? isRead;
  AgentData? agent;
  ObjectData? object;

  NotificationData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.targetId,
    this.targetType,
    this.content,
    this.description,
    this.notificationType,
    this.isRead,
    this.agent,
    this.object,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    targetId = json['target_id']?.toString();
    targetType = json['target_type']?.toString();
    content = json['content']?.toString();
    description = json['description']?.toString();
    notificationType = json['notification_type']?.toString();
    isRead = json['is_read'] as bool?;
    agent = json['agent'] != null
        ? AgentData.fromJson(json['agent'] as Map<String, dynamic>)
        : null;
    object = json['object'] != null
        ? ObjectData.fromJson(json['object'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (deletedAt != null) data['deleted_at'] = deletedAt;
    if (targetId != null) data['target_id'] = targetId;
    if (targetType != null) data['target_type'] = targetType;
    if (content != null) data['content'] = content;
    if (description != null) data['description'] = description;
    if (notificationType != null) data['notification_type'] = notificationType;
    if (isRead != null) data['is_read'] = isRead;
    if (agent != null) data['agent'] = agent!.toJson();
    if (object != null) data['object'] = object!.toJson();
    return data;
  }
}

class AgentData {
  String? id;
  String? username;
  String? avatar;
  String? name;

  AgentData({
    this.id,
    this.username,
    this.avatar,
    this.name,
  });

  AgentData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    username = json['username']?.toString();
    avatar = json['avatar']?.toString();
    name = json['name']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (username != null) data['username'] = username;
    if (avatar != null) data['avatar'] = avatar;
    if (name != null) data['name'] = name;
    return data;
  }
}

class ObjectData {
  String? id;
  String? postId;

  ObjectData({
    this.id,
    this.postId,
  });

  ObjectData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    postId = json['post_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (postId != null) data['post_id'] = postId;
    return data;
  }
}
