import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:flutter_application_1/domain/api_client.dart';

class MainScreenModel {
  final box = Hive.box<ShowHive>('mainScreenBox');
  final nameBox = Hive.box<ShowName>('nameBox');

  void mainScreenBoxFilling(List<Show> data) async {
    for (int i = 0; i < data.length; i++) {
      DateTime hiveTime = DateTime.utc(1989, 11, 9);

      String imageVariable = "";
      imageVariable = data[i].image ?? '';

      final showHive = ShowHive(
          id: data[i].id,
          name: data[i].name,
          language: data[i].language,
          image: imageVariable,
          timeNow: hiveTime);
      await box.put(i, showHive);
    }
  }

  void mainScreenBoxClear() {
    box.clear();
  }

  void setName(String text) async {
    final showName = ShowName(name: text);
    await nameBox.put(0, showName);
  }
}
