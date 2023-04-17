import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveWidgetModel {
  final box = Hive.box<ShowHive>('favoriteLocalBox');
  final timeNow = DateTime.now;

  void saveShow(int id, String name, String language, String image,
      dynamic timeNow) async {
    final box = await Hive.openBox<ShowHive>('favoriteLocalBox');
    final showHive = ShowHive(
        id: id, name: name, language: language, image: image, timeNow: timeNow);
    await box.add(showHive);
  }

  int checkingForFavorite(int id) {
    int counter = 0;
    for (int index = 0; index < box.length; index++) {
      final showinfo = box.getAt(index);
      var showId = showinfo?.id;
      if (id == showId) {
        counter++;
      }
    }

    return counter;
  }

  void deleteShow(int id) {
    for (int index = 0; index < box.length; index++) {
      final showinfo = box.getAt(index);
      var showId = showinfo?.id;
      if (id == showId) {
        box.deleteAt(index);
      }
    }
  }
}

class ShowHive {
  final int id;
  final String name;
  final String language;
  final String image;
  final dynamic timeNow;

  ShowHive({
    required this.id,
    required this.name,
    required this.language,
    required this.image,
    required this.timeNow,
  });

  factory ShowHive.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return ShowHive(
      id: data['id'],
      name: data['title'],
      language: data['text'],
      image: data['imageURL'],
      timeNow: data['time'],
    );
  }

  @override
  String toString() => 'Name: $name, language: $language, image: $image';
}

class ShowHiveAdapter extends TypeAdapter<ShowHive> {
  @override
  final typeId = 0;

  @override
  ShowHive read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final language = reader.readString();
    final image = reader.readString();
    final time = reader.read();
    return ShowHive(
        id: id, name: name, language: language, image: image, timeNow: time);
  }

  @override
  void write(BinaryWriter writer, ShowHive obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.language);
    writer.writeString(obj.image);
    writer.write(obj.timeNow);
  }
}

class ShowName {
  final String name;

  ShowName({
    required this.name,
  });
}

class ShowNameAdapter extends TypeAdapter<ShowName> {
  @override
  final typeId = 1;

  @override
  ShowName read(BinaryReader reader) {
    final name = reader.readString();

    return ShowName(
      name: name,
    );
  }

  @override
  void write(BinaryWriter writer, ShowName obj) {
    writer.writeString(obj.name);
  }
}
