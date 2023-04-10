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
  String? image;

  Show({
    required this.id,
    required this.name,
    required this.language,
    required this.image,
  });
}

class ImageInfo {
  final Image image;

  ImageInfo({required this.image});
}

class Image {
  final String? medium;

  Image({required this.medium});
}

class DataFetcher {
  List<Show> show = [];
  //List<Image> image = [];

  Future<List<Show>> fetchShow(String searchText) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchText'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      var showInfo = data.map((e) => e["show"] as Map<String, dynamic>);
      var imageInfo = showInfo.map((e) => e["image"] as Map<String, dynamic>?);
      var image =
          imageInfo.map((e) => Image(medium: e?["medium"] as String?)).toList();
      //e["image"] as Map<String, dynamic>);
      //if(image == null) image = '' ;
      var show = showInfo
          .map(
            (e) => Show(
              id: e['id'] as int,
              name: e['name'] as String,
              language: e['language'] as String,
              image: '',
              // image.map((e) => e['medium'] as String),
              //image.map((e) => e['medium'] as String),
              // Image.map(e) => Image(image: e['medium'])
              // e['image'] => Image ( image: e['medium']),
            ),
          )
          .toList();
      for (int i = 0; i < show.length; i++) {
        if (image[i].medium == null) {
          show[i].image = "";
        } else {
          show[i].image = image[i].medium;
        }
      }
      return show;
    } else {
      throw Exception(Constants.apiExeption);
    }
  }
}
