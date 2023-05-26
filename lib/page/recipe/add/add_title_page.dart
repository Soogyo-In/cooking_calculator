import 'package:cooking_calulator/page/recipe/add/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTitlePage extends ConsumerStatefulWidget {
  static const routeName = 'addRecipeTitle';

  const AddTitlePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTitlePageState();
}

class _AddTitlePageState extends ConsumerState<AddTitlePage> {
  String _name = '';
  String _description = '';
  int _servings = 1;

  bool get _nextButtonEnabled => _name.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('레시피 추가')),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: '이름'),
              autofocus: true,
              onChanged: (text) => setState(() => _name = text),
              textInputAction: TextInputAction.next,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_servings > 1) {
                      setState(() => _servings--);
                      return;
                    }

                    setState(() => _servings = 1);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text('$_servings 인분'),
                IconButton(
                  onPressed: () => setState(() => _servings++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(hintText: '설명'),
                maxLines: null,
                expands: true,
                onChanged: (text) => setState(() => _description = text),
                textInputAction: TextInputAction.done,
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
    ref.read(recipeProvider.notifier).update((state) => state.copyWith(
          name: _name,
          description: _description,
          servings: _servings,
        ));
    Navigator.of(context).pushNamed(AddDirectionPage.routeName);
  }
}
