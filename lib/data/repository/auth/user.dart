import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageURL;

  UserModel({this.email, this.fullName, this.imageURL});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['fullName'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(email: email, fullName: fullName, imageURL: imageURL);
  }
}
