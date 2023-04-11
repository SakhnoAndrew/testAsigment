import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/domain/hive_model.dart';

class FirecloudeEssense {
  final box = Hive.box<ShowHive>('showBoxHive');

  Future<List<ShowHive>> getDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> data = snapshot.docs.map((doc) {
      return ShowHive.fromFirestore(doc);
    }).toList();
    return data;
  }

  void hiveBoxFilling(List<ShowHive> data) async {
    for (int i = 0; i < data.length; i++) {
      Timestamp timeFireTemp = data[i].timeNow;
      DateTime timeFireDate = timeFireTemp.toDate();

      final showHive = ShowHive(
          id: data[i].id,
          name: data[i].name,
          language: data[i].language,
          image: data[i].image,
          timeNow: timeFireDate);
      await box.put(i, showHive);
    }
  }

  void hiveBoxClear() async {
    await box.clear();
  }

  bool checkingForChange(List<ShowHive> data) {
    bool flag = true;
    int count = 0;

    if (data.length == box.length) {
      int countLenght = data.length;
      for (int i = 0; i < data.length; i++) {
        final boxInfo = box.getAt(i);
        if (data[i].id == boxInfo?.id) {
          count++;
        }
      }
      if (count == countLenght) {
        flag = false;
      }
    }
    return flag;
  }

  Future<bool> compareData() async {
    bool compare = true;
    Box hiveBox = Hive.box<ShowHive>('showBoxHive');
    List hiveData = hiveBox.values.toList();
    int counter = 0;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();

    List<ShowHive> data = snapshot.docs.map((doc) {
      return ShowHive.fromFirestore(doc);
    }).toList();

    if (hiveData.length != data.length) {
      compare = false;
    } else {
      for (int i = 0; i < hiveData.length; i++) {
        final hiveBoxInfo = box.getAt(i);

        for (int j = 0; j < data.length; j++) {
          if (hiveBoxInfo?.id == data[j].id) {
            counter++;
          }
        }
      }
      if (counter != hiveData.length) {
        compare = false;
      }
    }
    return compare;
  }

  void deleteFirestoreShow(int id) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> data = snapshot.docs.map((doc) {
      return ShowHive.fromFirestore(doc);
    }).toList();

    for (int i = 0; i < data.length; i++) {
      if (id == data[i].id) {
        var documentId = snapshot.docs[i].id;
        FirebaseFirestore.instance.collection('shows').doc(documentId).delete();
      }
    }
  }

  void timeCompare() async {
    Box hiveBox = Hive.box<ShowHive>('showBoxHive');
    List hiveData = hiveBox.values.toList();

    DateTime hiveTime = DateTime.utc(1989, 11, 9);
    DateTime fireTime = DateTime.utc(1989, 11, 9);

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> data = snapshot.docs.map((doc) {
      return ShowHive.fromFirestore(doc);
    }).toList();

    for (int i = 0; i < hiveData.length; i++) {
      final hiveBoxInfo = box.getAt(i);
      if (hiveBoxInfo!.timeNow.isAfter(hiveTime)) {
        hiveTime = hiveBoxInfo.timeNow;
      }
    }

    for (int i = 0; i < data.length; i++) {
      Timestamp timeFireTemp = data[i].timeNow;
      DateTime timeFireDate = timeFireTemp.toDate();

      if (timeFireDate.isAfter(fireTime)) {
        fireTime = timeFireDate;
      }
    }

    if (fireTime.isAfter(hiveTime)) {
      hiveBoxClear();
      hiveBoxFilling(data);
    }
    if (hiveTime.isAfter(fireTime)) {
      for (int i = 0; i < data.length; i++) {
        var documentId = snapshot.docs[i].id;
        FirebaseFirestore.instance.collection('shows').doc(documentId).delete();
      }

      for (int i = 0; i < hiveData.length; i++) {
        final hiveBoxInfo = box.getAt(i);
        FirebaseFirestore.instance.collection('shows').add({
          'id': hiveBoxInfo!.id,
          'title': hiveBoxInfo.name,
          'text': hiveBoxInfo.language,
          'imageURL': hiveBoxInfo.image,
          'time': hiveBoxInfo.timeNow,
        });
      }
    }
  }
}
