import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/constants.dart';
import '../widgets/main_show_list.dart';
import '../widgets/provider_list.dart';
import '../widgets/search_text_field_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
          //MainShowListWidget()
          ProviderList(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchTextFieldWidget(),
          )
        ]),
      ),
    );
  }
}
