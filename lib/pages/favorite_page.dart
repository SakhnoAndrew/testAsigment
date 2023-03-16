import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/domain/hive_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _box = Hive.box<ShowHive>('showBox');
  int? length;
  dynamic model;

  @override
  void initState() {
    super.initState();
    length = _box.length;
  }

  final HiveWidgetModel hiveWidgetModel = HiveWidgetModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          title: const Text(Constants.favoriteTitie),
        ),
        drawer: const NavigationDrawerWidget(),
        body: ListView.builder(
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            final showinfo = _box.getAt(index);
            var linkImage = showinfo?.image ?? '';
            var showName = showinfo?.name;
            var showLanguage = showinfo?.language;
            return Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(linkImage),
                      radius: 30,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Text(
                            ('$showName'),
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
                          child: Text("${Constants.language} $showLanguage"),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 65,
                    height: 50,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          _box.deleteAt(index);
                          setState(() {
                            length = _box.length;
                          });
                        },
                        style: IconButton.styleFrom(
                            disabledForegroundColor:
                                Constants.favoriteButtonColor),
                        icon: const Icon(
                          Icons.favorite,
                          color: Constants.favoriteButtonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}




// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 5, 59, 151),
//           title: const Text("Favorite"),
//         ),
//         drawer: const NavigationDrawerWidget(),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('shows').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) return const Text(Constants.loading);

//             return ListView.builder(
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final document = snapshot.data?.docs[index];
//                 String language = document!['text'];

//                 return Card(
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(document['imageURL']),
//                           radius: 30,
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           SizedBox(
//                             width: 200,
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
//                               child: Text(
//                                 (document['title']),
//                                 textDirection: TextDirection.ltr,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
//                               child: Text('${Constants.language} $language'),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         width: 65,
//                         height: 50,
//                         child: Center(
//                           child: IconButton(
//                             onPressed: () {
//                               FirebaseFirestore.instance
//                                   .collection('shows')
//                                   .doc(document.id)
//                                   .delete();
//                             },
//                             style: IconButton.styleFrom(
//                                 disabledForegroundColor:
//                                     Constants.favoriteButtonColor),
//                             icon: const Icon(
//                               Icons.favorite,
//                               color: Constants.favoriteButtonColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
