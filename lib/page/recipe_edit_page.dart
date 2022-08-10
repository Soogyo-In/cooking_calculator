import 'package:flutter/material.dart';

class RecipeEditPage extends StatelessWidget {
  const RecipeEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe editor')),
    );
  }
}
