import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class WebService {
  Future<List> fetchImages(int pageNumber) async {
    // var getdata = await http.get(
    String url =
        'https://api.unsplash.com/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&page=$pageNumber&order_by=popular';
    //  'https://api.unsplash.com/search/photos?per_page=30&client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&query=nature');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    } else {
      print(url);
      throw Exception("Unable to perform request!");
    }
  }

  Future<List> fetchMoreImages(int pageNumber) async {
    // var getdata = await http.get(
    String url =
        'https://api.unsplash.com/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&page=$pageNumber&order_by=popular';
    //  'https://api.unsplash.com/search/photos?per_page=30&client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&query=nature');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    } else {
      print(url);
      throw Exception("Unable to perform request!");
    }
  }
}
