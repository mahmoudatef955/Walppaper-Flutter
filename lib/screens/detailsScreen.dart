import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class DetailsScreen extends StatefulWidget {
  final id;

  DetailsScreen(this.id);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var data;
  String _localfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImages();
  }

  Future<String> fetchImages() async {
    var getdata = await http.get(
        'https://api.unsplash.com/photos/${this.widget.id}?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw');
    //  'https://api.unsplash.com/search/photos?per_page=30&client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&query=nature');
    setState(() {
      var jsondata = json.decode(getdata.body);
      data = jsondata; //['results'];
    });
    return "Success";
  }

  static Future<bool> _checkAndGetPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      final Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions(<PermissionGroup>[PermissionGroup.storage]);
      if (permissions[PermissionGroup.storage] != PermissionStatus.granted) {
        return null;
      }
    }
    return true;
  }

  _setImage(BuildContext context, values) async {
    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    String result;
    if (await _checkAndGetPermission() != null) {
      // if (true) {
      Dio dio = Dio();
      final Directory appdirectory = await getExternalStorageDirectory();
      final Directory directory =
          await Directory(appdirectory.path + '/wallpapers')
              .create(recursive: true);
      final String dir = directory.path;
      final String localfile = '$dir/myimage.jpeg';
      try {
        await dio.download(values, localfile);

        setState(() {
          _localfile = localfile;
        });
        //Wallpaperplugin.setAutoWallpaper(localFile: _localfile);
        result =
            await WallpaperManager.setWallpaperFromFile(localfile, location);
      } on PlatformException catch (e) {
        print(e);
        Navigator.pop(context);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Container()
        : Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent.withOpacity(0),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 420,
                  child: Image.network(
                    data['urls']['regular'],
                    fit: BoxFit.fill,
                  ),
                ),
                User(data),
                Divider(
                  thickness: 0.15,
                  height: 10,
                  color: Colors.white,
                ),
                Actions(),
                Divider(
                  thickness: 0.15,
                  height: 10,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 65,
                  child: SingleChildScrollView(
                    child: Text(
                      data['description'] != null
                          ? data['description']
                          : data['alt_description'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.15,
                  height: 10,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 45,
                ),
                Information(data),
              ],
            ),
          );
  }

  Widget User(data) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
        child: Row(
          children: <Widget>[
            Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: new NetworkImage(
                            data['user']['profile_image']['medium'])))),
            SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['user']['name'],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['user']['name'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Actions() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'FAVOURITE',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () => _setImage(context, data['links']['download']),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.wallpaper,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'SET',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Information(data) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              informationRow(
                  Icons.file_download, 'DOWNLOADS: ${data['downloads']}'),
              SizedBox(
                height: 20,
              ),
              informationRow(Icons.view_day, 'VIEWS: ${data['views']}'),
            ],
          ),
          Divider(
            thickness: 50,
            height: 10,
          ),
          Column(
            children: <Widget>[
              informationRow(Icons.image_aspect_ratio,
                  '${data['width']} X ${data['height']}'),
              SizedBox(
                height: 20,
              ),
              informationRow(Icons.thumb_up, 'LIKES: ${data['likes']}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget informationRow(icon, text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
