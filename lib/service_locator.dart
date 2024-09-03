import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebae_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthFirebaeService>(
      AuthFirebaeServiceImpl());

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

}
