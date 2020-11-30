import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class WebService {
  Future<List> fetchImages(int pageNumber, String orderBy) async {
    String url =
        'https://api.unsplash.com/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&page=$pageNumber&order_by=$orderBy';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body;
    } else {
      print(url);
      throw Exception("Unable to perform request!");
    }
  }

  Future<List> fetchMoreImages(int pageNumber, String orderBy) async {
    // var getdata = await http.get(
    String url =
        'https://api.unsplash.com/photos?client_id=2IdNkr2kuazZtmUzEUG4n833IOvVi6U4I4VoGbVTDiw&page=$pageNumber&order_by=$orderBy';
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
