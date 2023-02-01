import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

class ShowInfo {
  final Show showInfo;

  ShowInfo(this.showInfo);
}

class Show {
  final String name;
  final String language;
  final dynamic image;

  Show({
    required this.name,
    required this.language,
    required this.image,
  });
}

class DataFetcher {
  Future<List<Show>> getModels(String searchText) async {
    return await fetchShow(searchText);
  }

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
      print('object');
      return show;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
