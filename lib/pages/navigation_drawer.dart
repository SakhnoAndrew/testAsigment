import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:flutter_application_1/constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Constants.appbarBackgroungColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );
}

Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
    );

Widget buildMenuItem(BuildContext context) => Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: const Text(
            'Main',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => const MainPage()),
            ));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          title: const Text(
            'Favorite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => const FavoritePage()),
            ));
          },
        )
      ],
    );
