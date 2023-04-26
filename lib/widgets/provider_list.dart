import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../domain/riverpod_module.dart';

class ProviderList extends ConsumerWidget {
  const ProviderList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          //  final showinfo = box.getAt(index);
          var product = products[index];
          return Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(product.image ?? ''),
                    radius: 30,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Text(
                          (product?.name as String),
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
                        child:
                            Text("${Constants.language} ${product?.language}"),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 65,
                  height: 50,
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                          disabledForegroundColor:
                              Constants.favoriteButtonColor),
                      icon: const Icon(
                        Icons.abc,
                        color: Constants.favoriteButtonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
