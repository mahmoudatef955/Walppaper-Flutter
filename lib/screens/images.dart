import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detailsScreen.dart';

class Images extends StatefulWidget {
  final String url;

  const Images(this.url);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List data;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchImages(this.widget.url);
  }

  Future<String> fetchImages(String url) async {
    var getdata = await http.get(url);
    //'https://api.unsplash.com/collections/$id/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw');
    setState(() {
      var jsondata = json.decode(getdata.body);
      data = jsondata; //['results'];
    });
    print('Success');
    _loading = false;
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: GridView.builder(
          itemCount: data == null ? 0 : data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
