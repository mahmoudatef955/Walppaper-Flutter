// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favWallpaper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavWallpapersAdapter extends TypeAdapter<FavWallpapers> {
  @override
  final int typeId = 0;

  @override
  FavWallpapers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavWallpapers()..wallpaperIDs = (fields[0] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, FavWallpapers obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.wallpaperIDs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavWallpapersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
