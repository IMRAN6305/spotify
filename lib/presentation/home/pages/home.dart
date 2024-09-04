import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widgets/news_songs.dart';
import 'package:spotify/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40.0,
          width: 40.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeArtistCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                  children: [
                NewsSongs(),
                Container(),
                Container(),
                Container(),
              ]),
            ),
            PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
        height: 140.0,
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(AppVectors.homeTopCard),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Image.asset(AppImages.homeArtist),
              ))
        ]),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        indicatorColor: AppColors.primary,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
        tabs: [
          Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            'Videos',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            'Artist',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            'Podcasts',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ]);
  }
}
