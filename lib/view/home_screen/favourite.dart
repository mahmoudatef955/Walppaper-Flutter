import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wallpaperapp/services/webService.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';
import 'package:provider/provider.dart';
import 'detailsScreen.dart';

class Favourite extends StatelessWidget {
  Box<String> favoriteImageBox = Hive.box('favBox');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoriteImageBox.listenable(),
        builder: (context, box, _) {
          int count = box.length;

          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            child: count == 0
                ? Center(child: Text('No  Wallpapers'))
                : ImageGridView(data: box.toMap()),
          );
        });
  }
}

class ImageGridView extends StatefulWidget {
  const ImageGridView({this.data});

  final Map data;

  @override
  _ImageGridViewState createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  int currentPageNumber = 1;
  WebService webService = WebService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keys = widget.data.keys.toList();

    return GridView.builder(
      itemCount: widget.data.keys.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return BuildGridCard(
          imageid: keys[index],
          imageurl: widget.data[keys[index]],
        );
      },
    );
  }
}

class BuildGridCard extends StatelessWidget {
  final String imageid;
  final String imageurl;

  const BuildGridCard({Key key, this.imageid, this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeScreenProvider = context.watch<HomePageViewModel>();

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(imageid)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              imageurl,
              fit: BoxFit.fill,
              height: 600,
              width: 200,
            ),
          ),
          Positioned(
            right: 6,
            bottom: 6,
            child: GestureDetector(
              onTap: () =>
                  _homeScreenProvider.onFavoritePress(imageid, imageurl),
              child: getIcon(imageid, _homeScreenProvider),
            ),
          ),
        ]),
      ),
    );
  }

  Widget getIcon(String index, _homeScreenProvider) {
    if (_homeScreenProvider.favoriteImageBox.containsKey(index)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}
