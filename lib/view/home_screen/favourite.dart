import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wallpaperapp/model/favWallpaper.dart';

class Favourite extends StatelessWidget {
  Box favBox = Hive.box('favBox');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favBox.listenable(),
        builder: (context, box, _) {
          FavWallpapers favWallpapers = box.get('favWallpapers');
          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            child:  favWallpapers==null?Center(child: Text('No  Wallpapers'))
            :Center(child: Text('fav wall')),
          );
        });
  }
}
