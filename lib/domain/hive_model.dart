//import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';

class ShowHive {
  final String name;
  final String language;
  final Map? image;

  ShowHive({
    required this.name,
    required this.language,
    required this.image,
  });

  void test() async {
    // var box = await Hive.openBox<dynamic>('showBox');
  }
}
