import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import '../domain/hive_model.dart';

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  final box = Hive.box<ShowHive>('mainScreenBox');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: box.length,
        itemBuilder: (BuildContext context, int index) {
          final showinfo = box.getAt(index);
          //int id = showinfo?.id as int;
          var linkImage = showinfo?.image ?? '';
          var showName = showinfo?.name;
          var showLanguage = showinfo?.language;
          //box.
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
                      onPressed: () {},
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
        });
  }
}
