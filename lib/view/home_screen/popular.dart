import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';
import 'image_gridView.dart';

enum MovieLoadMoreStatus { LOADING, STABLE }

class PopularScreen extends StatelessWidget {
  List data;
  int currentPageNumber = 1;
  String _orderBy = 'popular';
  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;

  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = context.watch<HomePageViewModel>();
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: FutureBuilder(
            future:
                _homeScreenProvider.fetchImages(currentPageNumber, _orderBy),
            builder: (context, snapshots) {
              if (snapshots.hasError) return Text("Error Occurred");
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  print('-----------------done-----------------');
                  data = snapshots.data;
                  return ImageGridView(
                    data: data,
                    orderBy: _orderBy,
                  );
              }
            }));
  }
}
