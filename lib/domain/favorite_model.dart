import 'dart:core';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/domain/hive_model.dart';

// class FavoriteModel {
//   final int? id;
//   final String? name;
//   final String? language;
//   final String? image;

//   FavoriteModel({
//     required this.id,
//     required this.name,
//     required this.language,
//     required this.image,
//   });

//   factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
//     dynamic data = doc.data();
//     return FavoriteModel(
//       id: data['id'],
//       name: data['title'],
//       language: data['text'],
//       image: data['imageURL'],
//     );
//   }

//   // factory FavoriteModel.fromMap(Map<String, dynamic> data) {
//   //   final int id = data['id'];
//   //   final String name = data['name'];
//   //   final String language = data['language'];
//   //   final String? image = data['image'];
//   //   return FavoriteModel(id: id, name: name, language: language, image: image);
//   // }
// }

class FirecloudeEssense {
  final box = Hive.box<ShowHive>('showBox');

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
      final showHive = ShowHive(
          id: data[i].id,
          name: data[i].name,
          language: data[i].language,
          image: data[i].image);
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

  // int checkingForFavorite (int id){
  //       int counter = 0;

  //   for (int index = 0; index < box.length; index++) {
  //     final showinfo = box.getAt(index);
  //     var linkImage = showinfo?.image ?? '';
  //     var showName = showinfo?.name;
  //     var showLanguage = showinfo?.language;

  //     if (name == showName && language == showLanguage && image == linkImage) {
  //       counter++;
  //     }
  //   }
  //   return counter;

  // }

  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // //final CollectionReference usersCollection = firestore.collection('shows');

  // // void modelFilling() {
  // //   final CollectionReference usersCollection = firestore.collection('shows');
  // // }

  // Future<void> getUsers() async {
  //   final CollectionReference usersCollection = firestore.collection('shows');
  //   try {
  //     final QuerySnapshot querySnapshot = await usersCollection.get();

  //     final List<FavoriteModel> favoriteModel = querySnapshot.docs
  //         .map((doc) =>
  //             FavoriteModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //     this.favoriteModel = favoriteModel;
  //   } catch (e) {
  //     print(e);
  //   }
  //   // int? lenght = favoriteModel.length ?? 0;
  //   for (int index = 0;
  //       index < 5;
  //       //favoriteModel!.length;
  //       index++) {
  //     final fml = favoriteModel?[index];

  //     print('${fml?.id} + ${fml?.name} + ${fml?.language} + ${fml?.image}');
}
//   }
// }
