import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api_client.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controllerSearch = TextEditingController();
  static String searchText = '';
  var dataFetcher = DataFetcher;

  void _onSubmitted(String text) {
    setState(() {
      searchText = text;
      //dataFetcher.toString();
      DataFetcher().getModels(searchText);
    });
  }

  Widget _buildSearchTextField() {
    //widget for search text field
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        controller: controllerSearch,
        onSubmitted: _onSubmitted,
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

  Widget _buildShowLine() {
    //widget for result search
    return Card(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg"),
              radius: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              searchText,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 60, 10),
            child: Text('Genre: Comedy'),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.heart_broken_outlined,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/navigation');
              },
              icon: const Icon(Icons.dehaze_outlined)),
          title: const Text("Main"),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildSearchTextField(),
              _buildShowLine(),
              _buildShowLine(),
              _buildShowLine(),
              _buildShowLine(),
              _buildShowLine(),
              _buildShowLine(),
            ],
          ),
        ),
      ),
    );
  }
}
