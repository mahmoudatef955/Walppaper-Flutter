import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/screens/detailsScreen.dart';
//import 'package:loading_animations/loading_animations.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  List data;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImages();
  }

  Future<String> fetchImages() async {
    var getdata = await http.get(
        'https://api.unsplash.com/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&page=1&order_by=popular');
    //  'https://api.unsplash.com/search/photos?per_page=30&client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&query=nature');
    setState(() {
      var jsondata = json.decode(getdata.body);
      data = jsondata; //['results'];
    });
    setState(() {
      _loading = false;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: _loading == true
            ? Center(
                // child: LoadingBouncingLine.circle(
                //   size: 60,
                //   backgroundColor: Colors.blue,
                // ),
                )
            : GridView.builder(
                itemCount: data == null ? 0 : data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return gridCard(context, index);
                },
              ));
  }

  Widget gridCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(data[index]['id'])),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              data[index]['urls']['small'],
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
