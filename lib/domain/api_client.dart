import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowInfo {
  final Show showInfo;

  ShowInfo(this.showInfo);
}

class Show {
  final String name;
  final String language;
  final Map? image;

  Show({
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
              name: e['name'] as String,
              language: e['language'] as String,
              image: e['image'],
            ),
          )
          .toList();
      return show;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class DataFetcherProvider extends InheritedNotifier {
  final DataFetcher model;
  const DataFetcherProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child);

  static DataFetcherProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataFetcherProvider>();
  }

  static DataFetcherProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<DataFetcherProvider>()
        ?.widget;
    return widget is DataFetcherProvider ? widget : null;
  }
}
