import 'package:cooking_calulator/recipe_resource.dart';
import 'package:cooking_calulator/page/recipe/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page/unit_converting_page.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooking Calculator',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Menu'),
            ),
            body: Column(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UnitConvertingPage(),
                  )),
                  child: const Text('Unit converter'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipePage(
                      recipe: slowRoasetedPorkBellyRecipe,
                    ),
                  )),
                  child: const Text('Recipe editor'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
