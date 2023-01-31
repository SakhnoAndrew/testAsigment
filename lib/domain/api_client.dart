import 'dart:async';
import 'dart:convert';
//import 'package:flutter_application_1/pages/main_pages.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ShowInfo {
  final Show showInfo;

  ShowInfo(this.showInfo);
}

class Show {
  //final int id;
  final String name;
  final String language;
  //final String image;

  Show({
    // required this.id,
    required this.name,
    required this.language,
    // required this.image,
  });
}

class DataFetcher {
  List<Show> show = [];

  Future<List<Show>> getModels(String searchText) async {
    await fetchShow(searchText);
    return show;
  }

  Future<void> fetchShow(String searchText) async {
    // final response = await http.get('https://your-api-url.com');
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchText'));
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      var showInfo = data.map((e) => e["show"] as Map<String, dynamic>);

      show = showInfo
          .map(
            (e) => Show(
              //id: e['id'],
              name: e['name'] as String,
              language: e['language'] as String,
              //image: e['image']
            ),
          )
          .toList();

      print("123");
    } else {
      throw Exception('Failed to load album');
    }
  }
}
