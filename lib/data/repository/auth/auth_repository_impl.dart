import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_auth_req.dart';
import 'package:spotify/data/sources/auth/auth_firebae_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
   return  await sl<AuthFirebaeService>().signup(createUserReq);
  }
}
