import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_pages.dart';

Widget searchTextFieldWidget() => const Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextField(
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Enter show',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
      ),
    );
