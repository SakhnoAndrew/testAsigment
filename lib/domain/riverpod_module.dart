import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _shows = [
  ShowHive(
      id: 123,
      name: "Name1",
      language: "language1",
      image: "",
      timeNow: DateTime.utc(1989, 11, 9)),
  ShowHive(
      id: 111,
      name: "Name2",
      language: "language2",
      image: "",
      timeNow: DateTime.utc(1989, 11, 9)),
  ShowHive(
      id: 333,
      name: "Name3",
      language: "language3",
      image: "",
      timeNow: DateTime.utc(1989, 11, 9)),
];

final productsProvider = Provider<List<ShowHive>>((ref) {
  return _shows;
});
