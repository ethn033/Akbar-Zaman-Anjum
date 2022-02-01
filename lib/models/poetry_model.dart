// ignore_for_file: non_constant_identifier_names

class PoetryModel {
  String? id, cat_id, poetry_text, image_url;
  int? date_created, reads, likes;
  bool? is_deleted, can_copy, can_share;
  List<dynamic>? tags = [];

  PoetryModel();
  PoetryModel.createPoetry({
    this.id,
    this.cat_id,
    required this.poetry_text,
    required this.date_created,
    this.reads,
    this.likes,
    this.can_copy,
    this.can_share,
    this.is_deleted,
    this.image_url,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cat_id': cat_id,
      'poetry_text': poetry_text,
      'date_created': date_created,
      'reads': reads,
      'likes': likes,
      'is_deleted': is_deleted,
      'can_copy': can_copy,
      'can_share': can_share,
      'image_url': image_url,
      'tags': tags,
    };
  }
}
