import 'package:flutter/material.dart';
//import 'package:flutter_application_1/pages/main_pages.dart';

Widget buildSearchTextField() => Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        keyboardType: TextInputType.name,
        //style: Theme.of(context).textTheme.headline6,
        //onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Enter show',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
    );
