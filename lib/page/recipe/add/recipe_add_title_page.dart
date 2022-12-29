import 'package:cooking_calulator/page/recipe/add/recipe_add_direction_page.dart';
import 'package:flutter/material.dart';

class RecipeAddTitlePage extends StatefulWidget {
  const RecipeAddTitlePage({super.key});

  @override
  State<RecipeAddTitlePage> createState() => _RecipeAddTitlePageState();
}

class _RecipeAddTitlePageState extends State<RecipeAddTitlePage> {
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _descriptionTextFieldFocusNode = FocusNode();

  bool get _nextButtonEnabled => _titleTextController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('레시피 추가')),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _titleTextController,
              decoration: const InputDecoration(hintText: '이름'),
              autofocus: true,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _descriptionTextFieldFocusNode.requestFocus(),
            ),
            Expanded(
              child: TextField(
                controller: _descriptionTextController,
                focusNode: _descriptionTextFieldFocusNode,
                decoration: const InputDecoration(hintText: '설명'),
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: _nextButtonEnabled ? _onNextButtonPressed : null,
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  void _onNextButtonPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RecipeAddDirectionPage(),
    ));
  }
}
