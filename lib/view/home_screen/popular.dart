import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/services/webService.dart';
import 'package:wallpaperapp/view/home_screen/detailsScreen.dart';

enum MovieLoadMoreStatus { LOADING, STABLE }

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  List data;
  bool _loading = true;
  int currentPageNumber;
  WebService webService = WebService();
  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;

  @override
  void initState() {
    super.initState();
    currentPageNumber = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: FutureBuilder(
            future: webService.fetchImages(currentPageNumber),
            builder: (context, snapshots) {
              if (snapshots.hasError) return Text("Error Occurred");
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  print('-----------------done-----------------');
                  data = snapshots.data;
                  return ImageGridView(data: data);
              }
            }));
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  int currentPageNumber = 1;
  WebService webService = WebService();
  final ScrollController scrollController = new ScrollController();

  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: GridView.builder(
        controller: scrollController,
        itemCount: widget.data.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return BuildGridCard(
            imageData: widget.data[index],
          );
        },
      ),
    );
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == MovieLoadMoreStatus.STABLE) {
          loadMoreStatus = MovieLoadMoreStatus.LOADING;
          currentPageNumber = currentPageNumber + 1;
          print('-----------Load more 1111-----------------');
          webService.fetchMoreImages(currentPageNumber).then((value) {
            print('-----------Load more 22222-----------------');
            loadMoreStatus = MovieLoadMoreStatus.STABLE;
            setState(() {
              widget.data.addAll(value);
            });
          });
          loadMoreStatus = MovieLoadMoreStatus.STABLE;
        }
      }
    }
    return true;
  }
}

class BuildGridCard extends StatelessWidget {
  const BuildGridCard({
    Key key,
    @required this.imageData,
  }) : super(key: key);

  final imageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(imageData['id'])),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              imageData['urls']['small'],
              fit: BoxFit.fill,
              height: 600,
              width: 200,
            ),
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: GestureDetector(
              onTap: () {
                print('favourite');
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
