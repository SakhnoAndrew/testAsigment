import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FavoriteModel {
  final int? id;
  final String? name;
  final String? language;
  final String? image;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.language,
    required this.image,
  });

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    dynamic data = doc.data();
    return FavoriteModel(
      id: data['id'],
      name: data['title'],
      language: data['text'],
      image: data['imageURL'],
    );
  }

  // factory FavoriteModel.fromMap(Map<String, dynamic> data) {
  //   final int id = data['id'];
  //   final String name = data['name'];
  //   final String language = data['language'];
  //   final String? image = data['image'];
  //   return FavoriteModel(id: id, name: name, language: language, image: image);
  // }
}

class FirecloudeEssense {
  //List<FavoriteModel>? favoriteModel;

  Future<List<FavoriteModel>> getDataFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shows').get();

    List<FavoriteModel> data = snapshot.docs.map((doc) {
      return FavoriteModel.fromFirestore(doc);
    }).toList();

    // for (int i = 0; i < data.length; i++) {
    //   print(data[i].id);
    //   print(data[i].name);
    //   print(data[i].language);
    //   print(data[i].image);
    // }
    return data;
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
