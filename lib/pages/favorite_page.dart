import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final CollectionReference showsCollection =
      FirebaseFirestore.instance.collection('shows');
  Stream<QuerySnapshot>? shows;

  @override
  void initState() {
    super.initState();
    getShows();
  }

  void getShows() {
    setState(() {
      shows = showsCollection.snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 5, 59, 151),
            title: const Text("Favorite"),
          ),
          drawer: const NavigationDrawerWidget(),
          body: StreamBuilder<QuerySnapshot>(
            stream: shows,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Text('No records');
              final shows = snapshot.requireData;

              return ListView.builder(
                itemCount: shows.size,
                itemBuilder: (BuildContext context, int index) {
                  final show = shows.docs[index].data();

                  return Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                //snapshot.data!.docs[index].get('imageURL')
                                (show as Map<String, dynamic>)['imageURL']),
                            radius: 30,
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: Text(
                                  //snapshot.data!.docs[index].get('titile'),
                                  (show as Map<String, dynamic>)['title'],
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 60, 10),
                                child: Text(
                                    // snapshot.data!.docs[index].get('text')
                                    (show as Map<String, dynamic>)['text']),
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
                                // setState(() {
                                //   if (buttonFilling ==
                                //       Icons.favorite_border) {
                                //     buttonFilling = Icons.favorite;
                                //     FirebaseFirestore.instance
                                //         .collection('shows')
                                //         .add({
                                //       'title': title,
                                //       'text': text,
                                //       'imageURL': imageURL
                                //     });
                                //   } else {
                                //     buttonFilling = Icons.favorite_border;
                                //     //FirebaseFirestore.instance.collection('shows').doc(snapshot.doc.)
                                //   }
                                // });
                              },
                              style: IconButton.styleFrom(
                                  disabledForegroundColor: Colors.red),
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  //   );
                },
              );
            },
          )),
    );
  }
}
