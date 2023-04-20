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
  //Getting, parsing json and return List<Show>
  Future<List<Show>> fetchShow(String searchText) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchText'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      var showInfo = data.map((e) => e["show"] as Map<String, dynamic>);
      var imageInfo = showInfo.map((e) => e["image"] as Map<String, dynamic>?);
      // var imageMap = showInfo.map((e) => e['image'] as Map<String, dynamic>);

      // var imageInfoMedium = imageInfo as Map<String, dynamic>;
      var image =
          imageInfo.map((e) => Image(medium: e?["medium"] as String?)).toList();
      // var imageOne =
      // imageInfo.map((e) => Image(medium: e?["medium"] as String?)).toString();
      var show = showInfo
          .map(
            (e) => Show(
              id: e['id'] as int,
              name: e['name'] as String,
              language: e['language'] as String,
              image: ''

              //imageMap.map((e) => e['medium'] as String?);
              //imageInfoMedium['medium'] as String ?? ''
              //  imageInfo
              //     .map((e) => Image(medium: e?["medium"] as String?))
              //     .toString()
              ,

              //e['medium'] as String? ?? '',
            ),
          )
          .toList();
      for (int i = 0; i < show.length; i++) {
        if (image[i].medium == null) {
          show[i].image = "";
        } else {
          show[i].image = image[i].medium;
        }
      } //--
      return show;
    } else {
      throw Exception(Constants.apiExeption);
    }
  }
}
