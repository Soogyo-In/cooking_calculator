import 'package:data/data.dart';
import 'package:flutter/material.dart';

import 'edit.dart';

typedef EditDirectionPageArguments = ({Direction? direction});

class EditDirectionPage extends StatelessWidget {
  static const routeName = '/editDirection';

  const EditDirectionPage({
    super.key,
    this.direction,
  });

  final Direction? direction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(direction == null ? '절차 추가' : '절차 수정')),
      body: DirectionForm(
        direction: direction,
        onSubmitted: (direction) => _onDirectionSubmitted(context, direction),
      ),
    );
  }

  void _onDirectionSubmitted(BuildContext context, Direction direction) {
    Navigator.maybeOf(context)?.maybePop(direction);
  }
}
