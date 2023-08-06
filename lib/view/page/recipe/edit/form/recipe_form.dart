import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/view/view.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecipeForm extends ConsumerStatefulWidget {
  const RecipeForm({
    super.key,
    this.recipe,
    this.onSubmitted,
  });

  final Recipe? recipe;

  final ValueChanged<Recipe>? onSubmitted;

  @override
  ConsumerState<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends ConsumerState<RecipeForm> {
  late final AutoDisposeFamilyNotifierProvider<
      EditRecipeFormIntent,
      EditRecipeFormState,
      Recipe?> _intentProvider = editRecipeFormIntentProvider(
    widget.recipe,
  );

  @override
  Widget build(BuildContext context) {
    final intent = ref.read(_intentProvider.notifier);
    final state = ref.watch(_intentProvider);

    return Column(
      children: [
        TextFormField(
          initialValue: widget.recipe?.name,
          decoration: const InputDecoration(labelText: '이름'),
          autofocus: true,
          onChanged: intent.setName,
          textInputAction: TextInputAction.next,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => intent.setServings(state.servings - 1),
              icon: const Icon(Icons.remove),
            ),
            Text('${state.servings} 인분'),
            IconButton(
              onPressed: () => intent.setServings(state.servings + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        TextFormField(
          initialValue: widget.recipe?.description,
          decoration: const InputDecoration(labelText: '설명'),
          maxLines: 3,
          onChanged: intent.setDescription,
          textInputAction: TextInputAction.newline,
        ),
        ReorderableListView(
          onReorder: intent.reorderDirection,
          shrinkWrap: true,
          children: state.directions
              .map((direction) => Row(
                    key: ValueKey(direction),
                    children: [
                      Text(
                        direction.description,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _onEditDirectionButtonPressed(
                          direction,
                        ),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => intent.removeDirection(direction),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ))
              .toList(),
        ),
        OutlinedButton(
          onPressed: _onAddDirectionButtonPressed,
          child: const Text('절차 추가'),
        ),
        if (state.isValid)
          ElevatedButton(
            onPressed: _onSubmitButtonPressed,
            child: const Text('저장하기'),
          ),
      ],
    );
  }

  void _onEditDirectionButtonPressed(Direction direction) async {
    final editedDirection =
        await Navigator.maybeOf(context)?.pushNamed<Direction>(
      EditDirectionPage.routeName,
      arguments: (direction: direction),
    );

    if (editedDirection == null) return;

    ref.read(_intentProvider.notifier).changeDirection(
          previous: direction,
          next: editedDirection,
        );
  }

  void _onAddDirectionButtonPressed() async {
    final direction = await Navigator.of(context).push<Direction>(
      MaterialPageRoute(
        builder: (context) => const EditDirectionPage(),
        fullscreenDialog: true,
        settings: const RouteSettings(
          name: EditDirectionPage.routeName,
        ),
      ),
    );

    if (direction == null) return;

    ref.read(_intentProvider.notifier).addDirection(direction);
  }

  void _onSubmitButtonPressed() {
    widget.onSubmitted?.call(ref.read(_intentProvider).recipe);
  }
}
