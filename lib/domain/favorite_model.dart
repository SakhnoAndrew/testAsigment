import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/domain/hive_model.dart';

class FirecloudeEssense {
  final favoriteLocalBox = Hive.box<ShowHive>('favoriteLocalBox');
  final filterBox = Hive.box<ShowHive>('filterBox');

  Future<List<ShowHive>> getDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> firestoreData = snapshot.docs.map((doc) {
      return ShowHive.fromFirestore(doc);
    }).toList();
    return firestoreData;
  }

  //filling favoriteLocalBox with information received from the Firecloud
  void favoriteLocalBoxFilling(List<ShowHive> firestoreData) async {
    for (int i = 0; i < firestoreData.length; i++) {
      Timestamp timeFireTemp = firestoreData[i].timeNow;
      DateTime timeFireDate = timeFireTemp.toDate();

      final showHive = ShowHive(
          id: firestoreData[i].id,
          name: firestoreData[i].name,
          language: firestoreData[i].language,
          image: firestoreData[i].image,
          timeNow: timeFireDate);
      await favoriteLocalBox.add(showHive);
    }
  }

  void favoriteLocalBoxClear() async {
    await favoriteLocalBox.clear();
  }

  //filtering by show name and fiilin information in filterBox
  void favoriteFilter(String text) async {
    await filterBox.clear();
    for (int i = 0; i < favoriteLocalBox.length; i++) {
      final favoriteBox = favoriteLocalBox.getAt(i);
      String favoriteName = favoriteBox!.name.toLowerCase();
      if (favoriteName.contains(text.toLowerCase())) {
        final showHive = ShowHive(
            id: favoriteBox.id,
            name: favoriteBox.name,
            language: favoriteBox.language,
            image: favoriteBox.image,
            timeNow: favoriteBox.timeNow);
        filterBox.add(showHive);
      }
    }
  }

  //deleting a record from the Firecloud by index
  void deleteFirestoreShow(int id) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> firestoreData = await getDataFromFirestore();

    for (int i = 0; i < firestoreData.length; i++) {
      if (id == firestoreData[i].id) {
        var documentId = snapshot.docs[i].id;
        FirebaseFirestore.instance.collection('shows').doc(documentId).delete();
      }
    }
  }

  //filling favoriteLocalBox or Firebase
  void timeCompare() async {
    List favoriteShowsData = favoriteLocalBox.values.toList();
    DateTime favoriteLocalBoxTime = DateTime.utc(1989, 11, 9);
    DateTime firebaseDataTime = DateTime.utc(1989, 11, 9);
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();
    List<ShowHive> firestoreData = await getDataFromFirestore();

    //search for the last entry in favoriteShowsData
    for (int i = 0; i < favoriteShowsData.length; i++) {
      final hiveBoxInfo = favoriteLocalBox.getAt(i);
      if (hiveBoxInfo!.timeNow.isAfter(favoriteLocalBoxTime)) {
        favoriteLocalBoxTime = hiveBoxInfo.timeNow;
      }
    }
    //search for the last entry in Firestore
    for (int i = 0; i < firestoreData.length; i++) {
      Timestamp timeFireTemp = firestoreData[i].timeNow;
      DateTime timeFireDate = timeFireTemp.toDate();

      if (timeFireDate.isAfter(firebaseDataTime)) {
        firebaseDataTime = timeFireDate;
      }
    }

    if (firebaseDataTime.isAfter(favoriteLocalBoxTime)) {
      favoriteLocalBoxClear();
      favoriteLocalBoxFilling(firestoreData);
    }
    if (favoriteLocalBoxTime.isAfter(firebaseDataTime)) {
      for (int i = 0; i < firestoreData.length; i++) {
        var documentId = snapshot.docs[i].id;
        FirebaseFirestore.instance.collection('shows').doc(documentId).delete();
      }

      for (int i = 0; i < favoriteShowsData.length; i++) {
        final hiveBoxInfo = favoriteLocalBox.getAt(i);
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
