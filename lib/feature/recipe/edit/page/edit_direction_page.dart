import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';
import 'page.dart';

class EditDirectionPage extends ConsumerStatefulWidget {
  static const routeName = 'editRecipeDirection';

  const EditDirectionPage({super.key});

  @override
  ConsumerState<EditDirectionPage> createState() => _AddDirectionPageState();
}

class _AddDirectionPageState extends ConsumerState<EditDirectionPage> {
  String _description = '';
  final _ingredients = <Ingredient>[];

  @override
  Widget build(BuildContext context) {
    final stepCount =
        ref.read(recipeProvider.notifier).state.directions.length + 1;

    return Scaffold(
      appBar: AppBar(title: Text('단계 $stepCount')),
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: _ingredients
                  .map((ingredient) => Chip(label: Text(ingredient.name)))
                  .toList(),
            ),
            OutlinedButton(
              onPressed: _onAddIngredientButtonPressed,
              child: const Text('재료 추가'),
            ),
            Expanded(
              child: TextField(
                onChanged: (text) => setState(() => _description = text),
                decoration: const InputDecoration(hintText: '설명'),
                maxLines: null,
                expands: true,
              ),
            ),
            ButtonBar(
              children: [
                OutlinedButton(
                  onPressed: _onNextButtonPressed,
                  child: const Text('단계 추가'),
                ),
                ElevatedButton(
                  onPressed: _onSubmitButtonPressed,
                  child: const Text('완료'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onNextButtonPressed() {
    ref.read(recipeProvider.notifier).update(
          (state) => state.copyWith(
            directions: state.directions
              ..add(Direction(
                description: _description,
              )),
          ),
        );
    Navigator.of(context).pushNamed(EditDirectionPage.routeName);
  }

  void _onSubmitButtonPressed() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onAddIngredientButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const EditIngredientPage(),
    ));
  }
}
