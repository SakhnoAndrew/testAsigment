import 'package:flutter/material.dart';

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
