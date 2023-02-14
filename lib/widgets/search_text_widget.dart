import 'package:flutter/material.dart';

Widget searchTextFieldWidget() => const Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        keyboardType: TextInputType.name,
        // ignore: unnecessary_const
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Enter show',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
    );
