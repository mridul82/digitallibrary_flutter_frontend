class ContentDetails {
  final int id;
  final int contentId;
  final String filename;
  final String? fileUrl;
  final String? fileThumbnail;
  final String? onlineStorageName;
  final String? onlineStorageUrl;
  final String? fileWatermark;
  final bool? isWatermark;
  final bool? isPublish;
  final String publishAt;
  final String createdAt;
  final String updatedAt;

  ContentDetails({
    required this.id,
    required this.contentId,
    required this.filename,
    this.fileUrl,
    this.fileThumbnail,
    this.onlineStorageName,
    required this.onlineStorageUrl,
    this.fileWatermark,
    this.isWatermark,
    this.isPublish,
    required this.publishAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) {
    return ContentDetails(
      id: json['id'],
      contentId: json['content_id'],
      filename: json['filename'],
      fileUrl: json['file_url'],
      fileThumbnail: json['file_thumbnail'],
      onlineStorageName: json['online_storage_name'],
      onlineStorageUrl: json['online_storage_url'],
      fileWatermark: json['file_watermark'],
      isWatermark: json['isWatermark'],
      isPublish: json['isPublish'],
      publishAt: json['publishAt'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content_id': contentId,
      'filename': filename,
      'file_url': fileUrl,
      'file_thumbnail': fileThumbnail,
      'online_storage_name': onlineStorageName,
      'online_storage_url': onlineStorageUrl,
      'file_watermark': fileWatermark,
      'isWatermark': isWatermark,
      'isPublish': isPublish,
      'publishAt': publishAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
