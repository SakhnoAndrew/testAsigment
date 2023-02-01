import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/show_line_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controllerSearch = TextEditingController();
  var dataFetcher = DataFetcher;

  void onSubmitted(String text) {
    setState(() {
      var model = DataFetcher().getModels(text);
    });
  }

  Widget searchTextFieldWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        onSubmitted: onSubmitted,
        keyboardType: TextInputType.name,
        style: Theme.of(context).textTheme.headline6,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Enter show',
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
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          title: const Text("Main"),
        ),
        drawer: const NavigationDrawerWidget(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              searchTextFieldWidget(),
              showLineWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
