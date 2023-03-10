import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveWidgetModel {
  final box = Hive.box<ShowHive>('showBox');

  void saveShow(String name, String language, String image) async {
    final box = await Hive.openBox<ShowHive>('showBox');

    final showHive = ShowHive(name: name, language: language, image: image);
    await box.add(showHive);
  }

  int checkingForFavorite(String name, String language, String image) {
    int counter = 0;
    for (int index = 0; index < box.length; index++) {
      final showinfo = box.getAt(index);
      var linkImage = showinfo?.image ?? '';
      var showName = showinfo?.name;
      var showLanguage = showinfo?.language;

      if (name == showName && language == showLanguage && image == linkImage) {
        counter++;
      }
    }
    return counter;
  }

  void deleteShow(String name, String language, String image) {
    for (int index = 0; index < box.length; index++) {
      final showinfo = box.getAt(index);
      var linkImage = showinfo?.image ?? '';
      var showName = showinfo?.name;
      var showLanguage = showinfo?.language;

      if (name == showName && language == showLanguage && image == linkImage) {
        box.deleteAt(index);
      }
    }
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
    return ShowHive(name: name, language: language, image: image);
  }

  @override
  void write(BinaryWriter writer, ShowHive obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.language);
    writer.writeString(obj.image);
  }
}

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
