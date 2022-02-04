class UserModel {
  String? name;
  String? email;
  String? password;
  String? address;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? facebook;
  String? instagram;
  String? tiktok;
  String? telegram;
  String? about;
  String? gender;
  String? youtube;

  UserModel();
  UserModel.create(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.address,
      this.image,
      this.cover,
      this.bio,
      this.about,
      this.facebook,
      this.telegram,
      this.tiktok,
      this.instagram,
      this.gender,
      this.youtube});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'image': image,
      'cover': cover,
      'facebook': facebook,
      'telegram': telegram,
      'tiktok': tiktok,
      'instagram': instagram,
      'bio': bio,
      'about': about,
      'gender': gender,
      'youtube': youtube,
    };
  }
}
