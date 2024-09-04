import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/domain/entities/song/song.dart';

import '../../../core/configs/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key,required this.songEntity});
  final SongEntity songEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Now Playing',
          style: TextStyle(fontSize: 18),
        ),
        action:
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Column(
          children: [
            _songCover(context)
          ],
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrls.firestorage}${songEntity.title}.jpg?${AppUrls.mediaAlt}',

          )
        )
      ),
    );
  }
}
