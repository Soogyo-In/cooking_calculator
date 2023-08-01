import 'package:cooking_calulator/feature/feature.dart';
import 'package:cooking_calulator/view/page/recipe/edit/edit_prep_page.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectionForm extends ConsumerStatefulWidget {
  const DirectionForm({
    super.key,
    this.direction,
    this.onSubmitted,
  });

  final Direction? direction;

  final ValueChanged<Direction>? onSubmitted;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DirectionFormState();
}

class _DirectionFormState extends ConsumerState<DirectionForm> {
  late final AutoDisposeFamilyNotifierProvider<
      EditDirectionFormIntent,
      EditDirectionFormState,
      Direction?> _intentProvider = editDirectionFormIntentProvider(
    widget.direction,
  );

  final _descriptionFormFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    final intent = ref.read(_intentProvider.notifier);
    final state = ref.watch(_intentProvider);
    final preps = state.preps;

    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          children: preps
              .map((prep) => PrepChip(
                    prep: prep,
                    onDeleted: intent.removePrep,
                    onTap: _onPrepTapped,
                  ))
              .toList(),
        ),
        OutlinedButton(
          onPressed: _onAddPrepButtonPressed,
          child: const Text('재료 추가'),
        ),
        Expanded(
          child: TextFormField(
            key: _descriptionFormFieldKey,
            onEditingComplete: _onDescriptionEditingComplete,
            decoration: const InputDecoration(hintText: '설명'),
            maxLines: null,
            expands: true,
          ),
        ),
      ],
    );
  }

  void _onPrepTapped(Prep prep) async {
    final editedPrep = await Navigator.maybeOf(context)?.pushNamed<Prep?>(
      EditPrepPage.routeName,
      arguments: (prep: prep),
    );

    if (editedPrep == null) return;

    ref.read(_intentProvider.notifier).changePrep(
          previous: prep,
          changed: editedPrep,
        );
  }

  void _onAddPrepButtonPressed() async {
    final prep = await Navigator.maybeOf(context)?.pushNamed<Prep?>(
      EditPrepPage.routeName,
    );

    if (prep == null) return;

    ref.read(_intentProvider.notifier).addPrep(prep);
  }

  void _onDescriptionEditingComplete() {
    final description = _descriptionFormFieldKey.currentState?.value ?? '';
    ref.read(_intentProvider.notifier).setDescription(description);
  }

  void _onPrepDeleted(Prep prep) {
    ref.read(_intentProvider.notifier).removePrep(prep);
  }
}

class PrepChip extends StatelessWidget {
  const PrepChip({
    super.key,
    required this.prep,
    this.onTap,
    this.onDeleted,
  });

  final Prep prep;

  final void Function(Prep prep)? onTap;

  final void Function(Prep prep)? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: InkWell(
        onTap: () => onTap?.call(prep),
        child: Text(prep.ingredient.name),
      ),
      onDeleted: () => onDeleted?.call(prep),
    );
  }
}
