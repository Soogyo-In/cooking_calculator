import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../recipe_provider.dart';
import '../edit.dart';

class RecipeForm extends ConsumerWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeNotifier = ref.watch(recipeProvider.notifier);
    final recipe = ref.watch(recipeProvider);
    final name = recipe.name;
    final description = recipe.description;
    final servings = recipe.servings;
    final nextButtonEnabled = recipe.name.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: '이름'),
                  autofocus: true,
                  onChanged: (text) => recipeNotifier.update(
                    (state) => state.copyWith(name: text),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (servings <= 1) return;

                        recipeNotifier.update(
                          (state) => state.copyWith(servings: servings - 1),
                        );
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$servings 인분'),
                    IconButton(
                      onPressed: () => recipeNotifier.update(
                        (state) => state.copyWith(servings: servings + 1),
                      ),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: '설명'),
                  maxLines: 3,
                  onChanged: (text) => recipeNotifier.update(
                    (state) => state.copyWith(description: text),
                  ),
                  textInputAction: TextInputAction.newline,
                ),
                ...recipe.directions.map((e) => Text('test')),
                OutlinedButton(
                  onPressed: () async {
                    final direction = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditDirectionPage(),
                        fullscreenDialog: true,
                        settings: const RouteSettings(
                          name: EditDirectionPage.routeName,
                        ),
                      ),
                    );

                    recipeNotifier.update((state) => state.copyWith(
                          directions: [...recipe.directions, direction],
                        ));
                  },
                  child: Text('단계 추가'),
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          children: [
            ElevatedButton(
              onPressed: null,
              child: const Text('미리보기'),
            ),
            ElevatedButton(
              onPressed: nextButtonEnabled
                  ? () => _onNextButtonPressed(context)
                  : null,
              child: const Text('다음'),
            ),
          ],
        ),
      ],
    );
  }

  void _onNextButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(EditDirectionPage.routeName);
  }
}
