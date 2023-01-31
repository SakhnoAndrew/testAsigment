import 'package:flutter/material.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 59, 151),
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushReplacementNamed(context, '/');
          //     },
          //    icon: const Icon(Icons.dehaze_outlined)),
          title: Text("Search"),
        ),
        body: SafeArea(
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Main')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/favorite');
                  },
                  child: Text('Favorite')),
            ],
          ),
        ),
      ),
    );
  }
}
