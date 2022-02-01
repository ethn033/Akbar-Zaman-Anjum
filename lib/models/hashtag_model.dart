// ignore_for_file: non_constant_identifier_names

class HashtagModel {
  String? id, tag;
  bool? disabled;
  int? date_created;

  HashtagModel();
  HashtagModel.createTag({
    this.id,
    this.tag,
    this.disabled,
    this.date_created,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag,
      'disabled': disabled,
      'date_created': date_created,
    };
  }
}
