import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel {
   String? title;
   String? artist;
   String ? duration;
   Timestamp? releaseData;
   bool ? isFavorite;
   String ? songId;

  SongModel({required this.songId, required this.title,required this.artist,required this.duration,required this.releaseData,required this.isFavorite});

  SongModel.fromJson(Map<String,dynamic> data){
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseData = data['releaseData'];

  }

}


extension SongModelX on SongModel {
  SongEntity toEntity(){
    return SongEntity(
        title :title!,
        artist:artist!,
        duration: duration!,
        relaseDate :releaseData!,
        isFavorite : isFavorite!,
        songId: songId!
    );
  }
}