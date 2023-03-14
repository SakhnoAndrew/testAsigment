import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_1/domain/api_client.dart';

class SearchTextWidget extends StatefulWidget {
  const SearchTextWidget({super.key});

  @override
  State<SearchTextWidget> createState() => _SearchTextWidgetState();
}

class _SearchTextWidgetState extends State<SearchTextWidget> {
  List<Show>? model;
  static const textKey = 'text';

  @override
  void initState() {
    startShowsBilding();
    super.initState();
  }

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
      model?.clear();
      setState(() {});
      model = await DataFetcher().fetchShow(text);
      setText(text);
      setState(() {});
    }
  }

  void onSubmitted(String text) async {
    model?.clear();
    setState(() {});
    model = await DataFetcher().fetchShow(text);
    setText(text);
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
        style: Theme.of(context).textTheme.titleLarge,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Enter show',
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
