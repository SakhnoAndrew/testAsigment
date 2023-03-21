import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/domain/api_client.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/show_liset_widget.dart';
import 'package:flutter_application_1/domain/favorite_model.dart';
import 'package:flutter_application_1/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controllerSearch = TextEditingController();
  List<Show> model = [];
  static const textKey = 'text';
  final fireModel = FirecloudeEssense();
  //List<FavoriteModel>? data;

  @override
  void initState() {
    //   getData();
    startShowsBilding();
    super.initState();
  }

  // void getData() async {
  //   data = await fireModel.getDataFromFirestore();
  //   print("object");
  // }

  // int checkingForFavorite(int id) {
  //   int counter = 0;

  //   for (int index = 0; index < data!.length; index++) {
  //     var showId = data?[index].id ?? 0;
  //     if (id == showId) {
  //       counter++;
  //     }
  //   }
  //   return counter;
  // }

  void startShowsBilding() async {
    var text = await getText();
    model = await DataFetcher().fetchShow(text);
    setState(() {});
  }

  Future setText(String text) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(textKey, text);
  }

  Future<String> getText() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(textKey) ?? "";
  }

  void onChange(String text) async {
    if (text.length >= 2) {
      Future.delayed(const Duration(milliseconds: 750), () async {
        model.clear();
        setState(() {});
        model = await DataFetcher().fetchShow(text);
        setText(text);
        setState(() {});
      });
    }
  }

  void onSubmitted(String text) async {
    model.clear();
    setState(() {});
    model = await DataFetcher().fetchShow(text);
    setText(text);
    setState(() {});
  }

  List<Widget> resultWidget(List<Show> model) {
    List<Widget> widgets = [];

    for (int i = 0; i < model.length - 1; i++) {
      String imageVariable = "";
      if (model[i].image != null) imageVariable = model[i].image?["medium"];

      widgets.add(
        ShowLisetWidget(
          id: model[i].id,
          title: model[i].name,
          text: model[i].language,
          imageURL: imageVariable,
        ),
      );
    }
    return widgets;
  }

  Widget searchTextFieldWidget() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.appbarBackgroungColor,
          title: const Text(Constants.mainTitle),
        ),
        drawer: const NavigationDrawerWidget(),
        body: Stack(children: [
          ListView(
            padding: const EdgeInsets.only(top: 80),
            children: resultWidget(model),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchTextFieldWidget(),
          )
        ]),
      ),
    );
  }
}
