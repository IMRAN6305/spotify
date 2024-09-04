import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.songEntity});
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
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
            '${AppUrls.songFirestorage}${songEntity.title}.mp3?${AppUrls.mediaAlt}',
          ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _songCover(context),
              SizedBox(
                height: 20,
              ),
              _songDetail(),
              SizedBox(
                height: 30,
              ),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                '${AppUrls.CoverFirestorage}${songEntity.title}.jpg?${AppUrls.mediaAlt}',
              ))),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              songEntity.artist,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
        FavoriteButton(
          songEntity: songEntity,
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songPosition)),
                  Text(formatDuration(
                      context.read<SongPlayerCubit>().songDuration))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playorPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}
