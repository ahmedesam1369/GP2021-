class UserModel {
  late String name;
  late String email;
  late String phone;
  late String emergency_email;
  late String height;
  late String weight;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerfied;
  UserModel({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.emergency_email = '',
    this.height = '',
    this.weight = '',
    this.uId = '',
    this.image = '',
    this.cover = '',
    this.bio = '',
    this.isEmailVerfied = false,
  });
  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    emergency_email = json['emergency_email'];
    height = json['height'];
    weight = json['weight'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerfied = json['isEmailVerfied'];
  }

  Object? get length => null;
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'emergency_email': emergency_email,
      'height': height,
      'weight': weight,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerfied': isEmailVerfied,
    };
  }
}
