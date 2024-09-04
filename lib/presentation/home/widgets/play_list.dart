import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify/presentation/home/bloc/play_list_state.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffc6c6c6)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _songs(state.songs)
                ],
              ),
            );
          }
          if (state is PlayListFailure) {
            return Container(
              child: Center(
                child: Text("Some thing error occerred!!"),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPlayerPage(
                          songEntity: songs[index],
                        ),
                      ));
                },
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.darkGrey
                            : Color(0xffe6e6e6),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode
                            ? Color(0xff959595)
                            : Color(0xff555555),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          songs[index].artist,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(songs[index].duration.toString().replaceAll(".", ":")),
                  SizedBox(
                    width: 20,
                  ),
                  FavoriteButton(songEntity: songs[index],)
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 20.0,
            ),
        itemCount: songs.length);
  }
}
