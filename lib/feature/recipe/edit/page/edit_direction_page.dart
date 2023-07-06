import 'package:data/data.dart';
import 'package:flutter/material.dart';

import 'page.dart';

class EditDirectionPage extends StatefulWidget {
  static const routeName = 'editRecipeDirection';

  const EditDirectionPage({
    super.key,
    required this.stepCount,
    this.direction = const Direction(),
  });

  final int stepCount;

  final Direction direction;

  @override
  State<EditDirectionPage> createState() => _AddDirectionPageState();
}

class _AddDirectionPageState extends State<EditDirectionPage> {
  List<Prep> _preps = [];

  String _description = '';

  Temperature? _temperature;

  Duration _time = Duration.zero;

  @override
  void initState() {
    _preps = widget.direction.preps.toList();
    _description = widget.direction.description;
    _temperature = widget.direction.temperature;
    _time = widget.direction.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('단계 ${widget.stepCount}'),
        actions: [
          IconButton(
            onPressed: _onSubmitButtonPressed,
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: _preps
                  .map((prep) => Chip(
                        label: InkWell(
                          onTap: () => Navigator.maybeOf(context)?.pushNamed(
                            EditPrepPage.routeName,
                            arguments: (prep: prep),
                          ),
                          child: Text(prep.ingredient.name),
                        ),
                        onDeleted: () {
                          setState(() {
                            _preps.remove(prep);
                          });
                        },
                      ))
                  .toList(),
            ),
            OutlinedButton(
              onPressed: _onAddPrepButtonPressed,
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
          ],
        ),
      ),
    );
  }

  void _onSubmitButtonPressed() {
    Navigator.of(context).pop(Direction(
      description: _description,
      preps: _preps,
      temperature: _temperature,
      time: _time,
    ));
  }

  void _onAddPrepButtonPressed() async {
    final prep = await Navigator.of(context).pushNamed<Prep>(
      EditPrepPage.routeName,
      arguments: (prep: null),
    );

    if (prep == null) return;

    setState(() {
      _preps.add(prep);
    });
  }
}
