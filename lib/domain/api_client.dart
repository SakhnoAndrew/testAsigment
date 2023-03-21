import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/constants.dart';

class ShowInfo {
  final Show showInfo;

  ShowInfo(this.showInfo);
}

class Show {
  final int id;
  final String name;
  final String language;
  final Map? image;

  Show({
    required this.id,
    required this.name,
    required this.language,
    required this.image,
  });
}

class DataFetcher {
  List<Show> show = [];

  Future<List<Show>> fetchShow(String searchText) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchText'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      var showInfo = data.map((e) => e["show"] as Map<String, dynamic>);
      var show = showInfo
          .map(
            (e) => Show(
              id: e['id'] as int,
              name: e['name'] as String,
              language: e['language'] as String,
              image: e['image'],
            ),
          )
          .toList();
      return show;
    } else {
      throw Exception(Constants.apiExeption);
    }
  }
}
