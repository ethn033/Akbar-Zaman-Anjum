// ignore_for_file: non_constant_identifier_names

class BookModel {
  String? id;
  String? name;
  String? thumbnail;
  String? url;
  int? date_created;
  int? reads;
  bool? is_deleted;

  BookModel();
  BookModel.Create({
    this.id,
    this.name,
    this.thumbnail,
    this.url,
    this.reads,
    this.date_created,
    this.is_deleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'reads': reads,
      'url': url,
      'thumbnail': thumbnail,
      'date_created': date_created,
      'is_deleted': is_deleted,
    };
  }
}
