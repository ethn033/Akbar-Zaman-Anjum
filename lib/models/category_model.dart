// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  String? id;
  String? name;
  String? thumbnail;
  int? date_created;
  bool? is_deleted;

  CategoryModel();
  CategoryModel.Create(
      {this.id, this.name, this.thumbnail, this.date_created, this.is_deleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'date_created': date_created,
      'is_deleted': is_deleted,
    };
  }
}
