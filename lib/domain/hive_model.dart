import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveWidgetModel {
  void test(String name, String language, String image) async {
    final box = await Hive.openBox<ShowHive>('showBox');
    final showHive = ShowHive(name: name, language: language, image: image);
    await box.add(showHive);
    //box.clear();
    //print(box.values);
    await box.clear();
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
    //   var imagee = showinfo!.name;
    //   print(imagee);
    // }
    box.close();
  }
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
  String toString() => 'Name: $name, language: $language, image: ';
}

class ShowHiveAdapter extends TypeAdapter<ShowHive> {
  @override
  final typeId = 0;

  @override
  ShowHive read(BinaryReader reader) {
    final name = reader.readString();
    final language = reader.readString();
    final image = reader.readString;
    return ShowHive(name: '$name', language: '$language', image: '$image');
  }

  @override
  void write(BinaryWriter writer, ShowHive obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.language);
    // writer.writeString(obj.image);
  }
}
