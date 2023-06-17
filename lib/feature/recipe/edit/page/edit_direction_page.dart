import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../recipe_provider.dart';
import 'page.dart';

class EditDirectionPage extends ConsumerStatefulWidget {
  static const routeName = 'editRecipeDirection';

  const EditDirectionPage({super.key, this.direction = const Direction()});

  final Direction direction;

  @override
  ConsumerState<EditDirectionPage> createState() => _AddDirectionPageState();
}

class _AddDirectionPageState extends ConsumerState<EditDirectionPage> {
  List<Prep> _preps = [];

  String _description = '';

  @override
  Widget build(BuildContext context) {
    final recipe = ref.watch(recipeProvider);
    final stepCount = recipe.directions.length + 1;
    _preps = widget.direction.preps;

    return Scaffold(
      appBar: AppBar(title: Text('단계 $stepCount')),
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: _preps
                  .map((prep) => Chip(label: Text(prep.ingredient.name)))
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
            directions: [
              ...state.directions,
              Direction(description: _description),
            ],
          ),
        );
    Navigator.of(context).pushNamed(EditDirectionPage.routeName);
  }

  void _onSubmitButtonPressed() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onAddIngredientButtonPressed() async {
    final ingredient = await Navigator.of(context).pushNamed(
      EditIngredientPage.routeName,
    );
  }
}
