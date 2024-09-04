import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';

import '../../../service_locator.dart';
import '../../repository/song/song.dart';

class IsFavoritySongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
