import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

import 'package:http/http.dart';

class HiveWidgetModel {
  void openBox() async {
    await Hive.openBox<ShowHive>('showBox');
    //final box = Hive.box<ShowHive>('showBox');
  }

  //var boxLengtn;
  //Hive.openBox<ShowHive>('showBox');
  //final box =  Hive.openBox<ShowHive>('showBox');
  final box = Hive.box<ShowHive>('showBox');

  //final box = await Hive.openBox<ShowHive>('showBox');

  Stream<List<ShowHive>> get showsStream =>
      box.watch().map((event) => event.value.toList());

  void saveShow(String name, String language, String image) async {
    final box = await Hive.openBox<ShowHive>('showBox');

    final showHive = ShowHive(name: name, language: language, image: image);
    await box.add(showHive);
    //boxLengtn = box.length;
    //box.close();
    //box.clear();
    //print(box.values);
    //await box.clear();
    //print('------------------------------------');

    // var showinfo = box.getAt(0);
    // print(showinfo);
    //   print(showinfo);
    //await box.add(showHive);
    //---------------------
    // print('------------------------------------');
    // print(box.values);
    // print('------------------------------------');

    // for (int i = 0; i < box.length; i++) {
    //   final showinfo = box.getAt(i);
    //   var imagee = showinfo?.image;
    //   var namee = showinfo?.name;
    //   var lang = showinfo?.language;
    //   print('$i. Name: $namee, Language: $lang, Image: $imagee');
    // }
  }

  // Future<int> favotiteLength() async {
  //   final box = await Hive.openBox<ShowHive>('showBox');
  //   return box.length;
  // }

//   Future<String> nameReturn(int index) async {
//     final box = await Hive.openBox<ShowHive>('showBox');
//     final showInBox = box.getAt(index);
//     //box.close();
//     return showInBox!.name;
//   }
}

class ShowHive {
  final String name;
  final String language;
  final String image;

  ShowHive({
    required this.name,
    required this.language,
    required this.image,
  });
  @override
  String toString() => 'Name: $name, language: $language, image: $image';
}

class ShowHiveAdapter extends TypeAdapter<ShowHive> {
  @override
  final typeId = 0;

  @override
  ShowHive read(BinaryReader reader) {
    final name = reader.readString();
    final language = reader.readString();
    final image = reader.readString();
    return ShowHive(name: '$name', language: '$language', image: '$image');
  }

  @override
  void write(BinaryWriter writer, ShowHive obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.language);
    writer.writeString(obj.image);
  }
}

//////////////////////////
class ShowProvider extends InheritedNotifier {
  final HiveWidgetModel model;
  const ShowProvider({Key? key, required Widget child, required this.model})
      : super(key: key, child: child);

  static ShowProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShowProvider>();
  }

  static ShowProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<ShowProvider>()?.widget;
    return widget is ShowProvider ? widget : null;
  }
}
