class GetListQuestionsResp {
  String? status;
  List<ListQuestionsData>? data;

  GetListQuestionsResp({
    this.status,
    this.data,
  });

  GetListQuestionsResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ListQuestionsData>[];
      json['data'].forEach((v) {
        data!.add(ListQuestionsData.fromJson(v));
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

class ListQuestionsData {
  String? id;
  String? content;
  int? pointMultiplier;
  String? backgroundUrl;
  String? timeLimit;
  String? quizType;
  List<dynamic>? files;
  String? prevElementId;
  String? quizzflyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Answer>? answers;
  String? type;

  ListQuestionsData({
    this.id,
    this.content,
    this.pointMultiplier,
    this.backgroundUrl,
    this.timeLimit,
    this.quizType,
    this.files,
    this.prevElementId,
    this.quizzflyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.answers,
    this.type,
  });

  ListQuestionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    pointMultiplier = json['point_multiplier'];
    backgroundUrl = json['background_url'];
    timeLimit = json['time_limit']?.toString();
    quizType = json['quiz_type'];
    files = json['files'];
    prevElementId = json['prev_element_id'];
    quizzflyId = json['quizzfly_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    type = json['type'];

    if (json['answers'] != null) {
      answers = <Answer>[];
      json['answers'].forEach((v) {
        answers!.add(Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (content != null) data['content'] = content;
    if (pointMultiplier != null) data['point_multiplier'] = pointMultiplier;
    if (backgroundUrl != null) data['background_url'] = backgroundUrl;
    if (timeLimit != null) data['time_limit'] = timeLimit;
    if (quizType != null) data['quiz_type'] = quizType;
    if (files != null) data['files'] = files;
    if (prevElementId != null) data['prev_element_id'] = prevElementId;
    if (quizzflyId != null) data['quizzfly_id'] = quizzflyId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (deletedAt != null) data['deleted_at'] = deletedAt;
    if (type != null) data['type'] = type;

    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  String? id;
  String? content;
  bool? isCorrect;
  List<dynamic>? files;
  String? quizId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Answer({
    this.id,
    this.content,
    this.isCorrect,
    this.files,
    this.quizId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isCorrect = json['is_correct'];
    files = json['files'];
    quizId = json['quiz_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (content != null) data['content'] = content;
    if (isCorrect != null) data['is_correct'] = isCorrect;
    if (files != null) data['files'] = files;
    if (quizId != null) data['quiz_id'] = quizId;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (deletedAt != null) data['deleted_at'] = deletedAt;
    return data;
  }
}
