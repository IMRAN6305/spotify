import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_auth_req.dart';

abstract class AuthFirebaeService {
  Future<void> signin();

  Future<Either> signup(CreateUserReq createUserReq);
}

class AuthFirebaeServiceImpl extends AuthFirebaeService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email, password: createUserReq.password);
    return Right("Signup was sucessful");
    }on FirebaseAuthException catch (e){
      String  message = '';
      if(e.code == 'weak-password'){
        message = "The password provided is too weak";
      }else if (e.code == 'email-already-in-use'){
        message = "An account already exists with that email.";

      }

      return Left(message);

    }

  }
}
