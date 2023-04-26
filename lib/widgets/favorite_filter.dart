import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';

class FavoriteFilterWidget extends StatefulWidget {
  const FavoriteFilterWidget({super.key});

  @override
  State<FavoriteFilterWidget> createState() => _FavoriteFilterWidgetState();
}

class _FavoriteFilterWidgetState extends State<FavoriteFilterWidget> {
  final favoriteResultBox = Hive.box<ShowHive>('favoriteScreenBox');
  final favoriteBox = Hive.box<ShowHive>('favoriteLocalBox');
  final filterBox = Hive.box<ShowHive>('filterBox');

  final getIt = GetIt.instance;

  @override
  void initState() {
    startShowsBilding();
    super.initState();
  }

  void startShowsBilding() async {
    await favoriteResultBox.clear();
    for (int i = 0; i < favoriteBox.length; i++) {
      final filling = favoriteBox.getAt(i);
      final showHive = ShowHive(
          id: filling!.id,
          name: filling.name,
          language: filling.language,
          image: filling.image,
          timeNow: filling.timeNow);
      favoriteResultBox.put(i, showHive);
    }
    setState(() {});
  }

  void onChange(String text) async {
    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        if (text.isNotEmpty) {
          await favoriteResultBox.clear();
          getIt<FirecloudeModel>().favoriteFilter(text);
          for (int i = 0; i < filterBox.length; i++) {
            final filling = filterBox.getAt(i);
            final showHive = ShowHive(
                id: filling!.id,
                name: filling.name,
                language: filling.language,
                image: filling.image,
                timeNow: filling.timeNow);
            favoriteResultBox.add(showHive);
            favoriteResultBox.length;
            setState(() {});
          }
          favoriteResultBox.length;
        }
        if (text.isEmpty) {
          await favoriteResultBox.clear();
          startShowsBilding();
        }
        setState(() {});
      },
    );
  }

  void onSubmitted(String text) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        onChanged: onChange,
        onSubmitted: onSubmitted,
        keyboardType: TextInputType.name,
        style: Theme.of(context).textTheme.headline6,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: Constants.enterShow,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
    );
  }
}
