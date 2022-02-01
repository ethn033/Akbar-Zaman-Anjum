// ignore_for_file: non_constant_identifier_names

class ColumnModel {
  String? id, column_text, image_url;
  int? date_created, reads, likes;
  bool? is_deleted, can_copy, can_share;

  ColumnModel();
  ColumnModel.createColumn({
    this.id,
    required this.column_text,
    required this.date_created,
    this.reads,
    this.likes,
    this.can_copy,
    this.can_share,
    this.is_deleted,
    this.image_url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'column_text': column_text,
      'date_created': date_created,
      'reads': reads,
      'likes': likes,
      'is_deleted': is_deleted,
      'can_copy': can_copy,
      'can_share': can_share,
      'image_url': image_url,
    };
  }
}
