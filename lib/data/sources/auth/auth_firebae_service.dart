import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/create_auth_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/repository/auth/user.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebaeService {
  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> getUser();
}

class AuthFirebaeServiceImpl extends AuthFirebaeService {
  @override
  Future<Either> signin(SigninUserReq signinuserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinuserReq.email, password: signinuserReq.password);
      return Right("Signin was sucessful");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = "Not user found for that email";
      } else if (e.code == 'invalid-credential') {
        message = "Wrong password provided for that user ";
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(data.user?.uid)
          .set({"fullName": createUserReq.fullName, "email": data.user?.email});
      return Right("Signup was sucessful");
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists with that email.";
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);

      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left("An error occurred!!");
    }
  }
}
