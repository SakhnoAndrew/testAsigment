import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import 'package:flutter_application_1/domain/api_client.dart';

import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';
import '../domain/main_model.dart';

class FavoriteFilterWidget extends StatefulWidget {
  const FavoriteFilterWidget({super.key});

  @override
  State<FavoriteFilterWidget> createState() => _FavoriteFilterWidgetState();
}

class _FavoriteFilterWidgetState extends State<FavoriteFilterWidget> {
  // final _nameBox = Hive.box<ShowName>('nameBox');
  // dynamic nameBoxInfo;
  // TextEditingController? controller = TextEditingController(text: '');
  // List<Show> model = [];
  // final mainModel = MainScreenModel();
  // final favorite = FirecloudeEssense();

  final favoriteResultBox = Hive.box<ShowHive>('favoriteScreenBox');
  final favoriteBox = Hive.box<ShowHive>('showBoxHive');
  final filterBox = Hive.box<ShowHive>('filterBox');
  final favoriteFilter = FirecloudeEssense();

  @override
  void initState() {
    startShowsBilding();
    super.initState();
  }

  void favoriteHiveClear() {
    //int lenght = favoriteResultBox.length;
    for (int i = 0; i < favoriteResultBox.length; i++) {
      favoriteResultBox.deleteAt(i);
    }
  }

  void startShowsBilding() async {
    //favoriteResultBox.clear();
    favoriteHiveClear();
    await favoriteResultBox.clear();
    //favoriteFilter.favoriteFilter(text);
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
      const Duration(milliseconds: 100),
      () async {
        if (text.isNotEmpty) {
          //favoriteResultBox.clear();
          //favoriteHiveClear();
          await favoriteResultBox.clear();
          //favoriteResultBox.length;
          //setState(() {});
          favoriteFilter.favoriteFilter(text);
          setState(() {});
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
          //favoriteResultBox.clear();
          //favoriteHiveClear();
          await favoriteResultBox.clear();
          //setState(() {});
          startShowsBilding();
          setState(() {});
        }
        setState(() {});
      },
    );
    // if (text.length >= 2) {
    //   Future.delayed(
    //     const Duration(milliseconds: 750),
    //     () async {
    //       model.clear();
    //       mainModel.mainScreenBoxClear();
    //       favorite.favoriteFilter(text);
    //       setState(() {});
    //       model = await DataFetcher().fetchShow(text);
    //       setState(() {});
    //       mainModel.mainScreenBoxFilling(model);
    //       mainModel.setName(text);
    //       setState(() {});
    //     },
    //   );
    // }
  }

  void onSubmitted(String text) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        // controller: controller,
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
