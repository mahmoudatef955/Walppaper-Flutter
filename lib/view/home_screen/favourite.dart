import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wallpaperapp/services/webService.dart';
import 'package:wallpaperapp/viewmodel/home_modelView.dart';
import 'package:provider/provider.dart';
import 'detailsScreen.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Box<String> favoriteImageBox = Hive.box('favBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!Provider.of<HomePageViewModel>(context, listen: false).isLogged()) {
      Future.delayed(Duration(seconds: 0)).then((_) {
        showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            builder: (builder) {
              return Container(
                color: Colors.grey[900],
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                child: Text(
                              'Upload your favourite wallpapers to our serverss and sync them with other devices.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                color: Colors.black,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {}),
                            GestureDetector(
                              onTap: ()=>Navigator.pop(context),
                              child: Text(
                                'DISMISS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      });
    }
  }

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
