class Contents {
  int? id;
  String? cntClass;
  String? cntSubject;
  String? cntTitle;
  String? cntChapter;
  String? cntTopic;
  String? cntDesc;
  int? cntType;
  String? cntCreator;
  int? cntPublish;
  String? cntPublishAt;
  String? createdAt;
  String? updatedAt;

  Contents({
    this.id,
    this.cntClass,
    this.cntSubject,
    this.cntTitle,
    this.cntChapter,
    this.cntTopic,
    this.cntDesc,
    this.cntType,
    this.cntCreator,
    this.cntPublish,
    this.cntPublishAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Contents.fromJson(Map<String, dynamic> json) {
    return Contents(
      id: json['id'],
      cntClass: json['cnt_class'],
      cntSubject: json['cnt_subject'],
      cntTitle: json['cnt_title'],
      cntChapter: json['cnt_chapter'],
      cntTopic: json['cnt_topic'],
      cntDesc: json['cnt_desc'],
      cntType: json['cnt_type'],
      cntCreator: json['cnt_creator'],
      cntPublish: json['cnt_publish'],
      cntPublishAt: json['cnt_publishAt'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
