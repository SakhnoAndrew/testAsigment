import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:flutter_application_1/domain/api_client.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/show_liset_widget.dart';
import 'package:flutter_application_1/domain/favorite_model.dart';
import 'package:flutter_application_1/domain/main_model.dart';
import 'package:flutter_application_1/constants.dart';
import '../domain/hive_model.dart';
import '../widgets/main_show_list.dart';
import '../widgets/search_text_field_widget.dart';
import '../widgets/show_list.dart';
//import '../widgets/show_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final controllerSearch = TextEditingController();
  List<Show> model = [];
  // static const textKey = 'text';
  final _box = Hive.box<ShowHive>('mainScreenBox');
  final _nameBox = Hive.box<ShowName>('nameBox');
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();
  final mainModel = MainScreenModel();
  dynamic nameBoxInfo;
  TextEditingController? controller = TextEditingController(text: '');

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

  // void onChange(String text) async {
  //   if (text.length >= 2) {
  //     Future.delayed(
  //       const Duration(milliseconds: 750),
  //       () async {
  //         model.clear();
  //         mainModel.mainScreenBoxClear();
  //         setState(() {});
  //         model = await DataFetcher().fetchShow(text);
  //         setState(() {});
  //         mainModel.mainScreenBoxFilling(model);
  //         mainModel.setName(text);
  //         setState(() {});
  //       },
  //     );
  //   }
  // }

  // void onSubmitted(String text) async {
  //   setState(() {});
  // }

  // List<Widget> resultWidget(Box<ShowHive> box) {
  //   List<Widget> widgets = [];
  //   for (int i = 0; i < box.length; i++) {
  //     final model = _box.getAt(i);

  //     widgets.add(
  //       ShowLisetWidget(
  //         id: model?.id ?? 0,
  //         title: model?.name ?? '',
  //         text: model?.language ?? '',
  //         imageURL: model?.image ?? '',
  //       ),
  //     );
  //   }
  //   setState(() {});
  //   return widgets;
  // }

  // Widget searchTextFieldWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
  //     child: TextField(
  //       controller: controller,
  //       onChanged: onChange,
  //       onSubmitted: onSubmitted,
  //       keyboardType: TextInputType.name,
  //       style: Theme.of(context).textTheme.headline6,
  //       decoration: const InputDecoration(
  //         prefixIcon: Icon(Icons.search),
  //         labelText: Constants.enterShow,
  //         filled: true,
  //         fillColor: Colors.white,
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(40.0)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.appbarBackgroungColor,
          title: const Text(Constants.mainTitle),
        ),
        drawer: const NavigationDrawerWidget(),
        body: Stack(children: const [
          MainShowList(),
          // ListView(
          //   padding: const EdgeInsets.only(top: 80),
          //   children:
          //       //ShowList(),
          //       resultWidget(_box),
          // ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchTextFieldWidget(),
            //searchTextFieldWidget(),
          )
        ]),
      ),
    );
  }
}
