import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import 'package:flutter_application_1/domain/api_client.dart';

import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';
import '../domain/main_model.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({super.key});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final _nameBox = Hive.box<ShowName>('nameBox');
  dynamic nameBoxInfo;
  TextEditingController? controller = TextEditingController(text: '');
  List<Show> model = [];
  final mainModel = MainScreenModel();
  final favorite = FirecloudeEssense();

  @override
  void initState() {
    startShowsBilding();
    super.initState();
  }

  void startShowsBilding() {
    if (_nameBox.isNotEmpty) nameBoxInfo = _nameBox.getAt(0);

    var text = nameBoxInfo?.name ?? '';
    controller = TextEditingController(text: text);
    setState(() {});
  }

  void onChange(String text) async {
    if (text.length >= 2) {
      Future.delayed(
        const Duration(milliseconds: 750),
        () async {
          model.clear();
          mainModel.mainScreenBoxClear();
          setState(() {});
          model = await DataFetcher().fetchShow(text);
          setState(() {});
          mainModel.mainScreenBoxFilling(model);
          mainModel.setName(text);
          setState(() {});
        },
      );
    }
  }

  void onSubmitted(String text) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        controller: controller,
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
