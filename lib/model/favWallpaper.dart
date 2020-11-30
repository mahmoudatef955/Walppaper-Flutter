import 'package:hive/hive.dart';

part 'favWallpaper.g.dart';

@HiveType(typeId: 0)
class FavWallpapers {
  @HiveField(0)
  List<String> wallpaperIDs;

  FavWallpapers();
  void addWallpaper(String id) {
    wallpaperIDs.add(id);
  }

  void removeWallpaper(id) {
    wallpaperIDs.remove(id);
  }

  bool hasWallpaper(id) {
    return wallpaperIDs.contains(id);
  }
}
