import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'images.dart';

class Collections extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  List data;
  List imagesData;

  //get http => null;
  Future<String> fetchCollections() async {
    var getdata = await http.get(
        'https://api.unsplash.com/collections/featured?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw');
    setState(() {
      var jsondata = json.decode(getdata.body);
      data = jsondata; //['results'];
    });
    return "Success";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return gridCard(context, index); //User(data[index]);
        },
      ),
    );
  }

  Widget User(data) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${data['total_photos']} Photos',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            Text(
              data['title'],
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
      ),
    );
  }

  Widget gridCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        String _url =
            'https://api.unsplash.com/collections/${data[index]['id'].toString()}/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw';
        //fetchCollectionImages(data[index]['id'].toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Images(_url)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              data[index]['cover_photo']['urls']['regular'],
              fit: BoxFit.fill,
              height: 200,
              width: 500,
            ),
          ),
          User(data[index])
          // Positioned(
          //   right: 6,
          //   bottom: 6,
          //   child: User(data[index]),
          // ),
        ]),
      ),
    );
  }

  Future<String> fetchCollectionImages(String id) async {
    var getdata = await http.get(
        'https://api.unsplash.com/collections/$id/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw');
    setState(() {
      var jsondata = json.decode(getdata.body);
      imagesData = jsondata; //['results'];
    });
    print('Success');
    return "Success";
  }
}
