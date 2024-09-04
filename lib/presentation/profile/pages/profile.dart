import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';

import '../bloc/favorite_songs_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          title: Text("Profile"),
          backgroundColor: Color(0xff2c2b2b),
        ),
        body: Column(
          children: [
            _profileInfo(context),
            const SizedBox(height: 30,),
            _favoriteSongs()
          ],
        ));
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileInfoCubit()..getUser(),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.isDarkMode ? Color(0xff2c2b2b) : Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
              if (state is ProfileInfoLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(state.userEntity.imageURL!))),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(state.userEntity.email!),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      state.userEntity.fullName!,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }
              if (state is ProfileInfoFailure) {
                return Center(
                  child: Text('Please Try again'),
                );
              }
              return Container();
            },
          ),
        ));
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONGS',
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: state.favoriteSongs.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${AppUrls.CoverFirestorage}${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}')
                                    )

                                ),
                                // child: Text('${AppUrls.CoverFirestorage}${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.favoriteSongs[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.favoriteSongs[index].artist,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(state.favoriteSongs[index].duration
                                  .toString()
                                  .replaceAll('.', ':')),
                              const SizedBox(
                                width: 20,
                              ),
                              FavoriteButton(
                                  songEntity: state.favoriteSongs[index],
                                  key: UniqueKey())
                            ],
                          )
                        ],
                      );
                    },
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return const Text('Please try again.');
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
