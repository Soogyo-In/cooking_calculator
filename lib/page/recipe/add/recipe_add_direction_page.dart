import 'package:flutter/material.dart';

class RecipeAddDirectionPage extends StatefulWidget {
  const RecipeAddDirectionPage({super.key, this.stepCount = 0});

  final int stepCount;

  @override
  State<RecipeAddDirectionPage> createState() => _RecipeAddDirectionPageState();
}

class _RecipeAddDirectionPageState extends State<RecipeAddDirectionPage> {
  final _ingredientTextController = TextEditingController();
  final _ingredientTextFieldFocusNode = FocusNode();
  final _descriptionTextController = TextEditingController();
  final _ingredients = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('단계 ${widget.stepCount}')),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _ingredientTextController,
              focusNode: _ingredientTextFieldFocusNode,
              decoration: const InputDecoration(hintText: '재료'),
              autofocus: true,
              onSubmitted: (value) {
                setState(() {
                  _ingredients.add(value);
                });
                _ingredientTextController.clear();
                _ingredientTextFieldFocusNode.requestFocus();
              },
            ),
            Wrap(
              spacing: 8.0,
              children: _ingredients
                  .map(
                    (name) => Chip(label: Text(name)),
                  )
                  .toList(),
            ),
            Expanded(
              child: TextField(
                controller: _descriptionTextController,
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RecipeAddDirectionPage(
        stepCount: widget.stepCount + 1,
      ),
    ));
  }

  void _onSubmitButtonPressed() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
