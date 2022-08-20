import 'package:cooking_calulator/model/model.dart';
import 'package:cooking_calulator/model/util/util.dart';
import 'package:flutter/material.dart';

class RecipeEditPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeEditPage({super.key, required this.recipe});

  @override
  State<RecipeEditPage> createState() => _RecipeEditPageState();
}

class _RecipeEditPageState extends State<RecipeEditPage> {
  late int _servings;

  @override
  void initState() {
    _servings = widget.recipe.servings;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RecipeEditPage oldWidget) {
    _servings = widget.recipe.servings;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe editor')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(recipe.name),
            const SizedBox(height: 8.0),
            Text(recipe.description),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text('servings: '),
                DropdownButton<int>(
                  value: _servings,
                  items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                      .map((servings) => DropdownMenuItem(
                            value: servings,
                            child: Text(servings.toString()),
                          ))
                      .toList(),
                  onChanged: (servings) {
                    if (servings == null) return;
                    setState(() {
                      _servings = servings;
                    });
                  },
                ),
              ],
            ),
            if (recipe.time != Duration.zero) ...[
              const SizedBox(height: 8.0),
              _TimeText(recipe.time),
            ],
            const SizedBox(height: 8.0),
            _IngredientList(
              countByIngredient: calculateAmountByIngredientServingsFor(
                amountByIngredient: recipe.countByIngredient,
                originServings: recipe.servings,
                toServings: _servings,
              ),
              massByIngredient: calculateAmountByIngredientServingsFor(
                amountByIngredient: recipe.massByIngredient,
                originServings: recipe.servings,
                toServings: _servings,
              ),
              volumeByIngredient: calculateAmountByIngredientServingsFor(
                amountByIngredient: recipe.volumeByIngredient,
                originServings: recipe.servings,
                toServings: _servings,
              ),
            ),
            const SizedBox(height: 8.0),
            ...recipe.directions.map(
              (direction) => Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _DirectionDetail(direction, recipe.servings, _servings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeText extends StatelessWidget {
  final Duration time;

  const _TimeText(this.time);

  @override
  Widget build(BuildContext context) {
    final stringBuffer = StringBuffer();
    final days = time.inDays;
    final hours = time.inHours;
    final minutes = time.inMinutes;

    if (days > 0) stringBuffer.write('$days d ');
    if (hours > 0) stringBuffer.write('${hours % Duration.hoursPerDay} h ');
    if (minutes > 0) {
      stringBuffer.write('${minutes % Duration.minutesPerHour} m');
    }

    return Text('time: ${stringBuffer.toString()}');
  }
}

class _IngredientList extends StatelessWidget {
  final Map<Ingredient, Mass> massByIngredient;
  final Map<Ingredient, Volume> volumeByIngredient;
  final Map<Ingredient, Count> countByIngredient;

  const _IngredientList({
    this.massByIngredient = const {},
    this.volumeByIngredient = const {},
    this.countByIngredient = const {},
  });

  @override
  Widget build(BuildContext context) {
    final ingredientList = <Widget>[];

    countByIngredient.forEach((ingredient, count) {
      final stringBuffer = StringBuffer(ingredient.name);
      final rounded = count.roundedAt(2);
      if (rounded.value > 0.0) {
        stringBuffer.write(': ${rounded.toStringWithSymbol()}');
      }

      ingredientList.add(Text(stringBuffer.toString()));
    });
    massByIngredient.forEach((ingredient, mass) {
      final stringBuffer = StringBuffer(ingredient.name);
      final rounded = mass.roundedAt(2);
      if (rounded.value > 0.0) {
        stringBuffer.write(': ${rounded.toStringWithSymbol()}');
      }

      ingredientList.add(Text(stringBuffer.toString()));
    });
    volumeByIngredient.forEach((ingredient, volume) {
      final stringBuffer = StringBuffer(ingredient.name);
      final rounded = volume.roundedAt(2);
      if (rounded.value > 0.0) {
        stringBuffer.write(': ${rounded.toStringWithSymbol()}');
      }

      ingredientList.add(Text(stringBuffer.toString()));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredientList,
    );
  }
}

class _DirectionDetail extends StatelessWidget {
  final Direction direction;
  final int originServings;
  final int toServings;

  const _DirectionDetail(this.direction, this.originServings, this.toServings);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IngredientList(
          countByIngredient: calculateAmountByIngredientServingsFor(
            amountByIngredient: direction.countByIngredient,
            originServings: originServings,
            toServings: toServings,
          ),
          massByIngredient: calculateAmountByIngredientServingsFor(
            amountByIngredient: direction.massByIngredient,
            originServings: originServings,
            toServings: toServings,
          ),
          volumeByIngredient: calculateAmountByIngredientServingsFor(
            amountByIngredient: direction.volumeByIngredient,
            originServings: originServings,
            toServings: toServings,
          ),
        ),
        if (direction.time != Duration.zero) ...[
          const SizedBox(height: 8.0),
          _TimeText(direction.time),
        ],
        const SizedBox(height: 8.0),
        Text(direction.description),
      ],
    );
  }
}
