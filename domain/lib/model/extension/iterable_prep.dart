import 'package:domain/model/model.dart';

class _AmountSet {
  _AmountSet({
    Milligram? milligram,
    Milliliter? milliliter,
    Count? count,
  })  : milligram = milligram ?? Milligram(0),
        milliliter = milliliter ?? Milliliter(0),
        count = count ?? Count(0);

  final Milligram milligram;

  final Milliliter milliliter;

  final Count count;

  _AmountSet add(Amount amount) => _AmountSet(
        milligram: amount is Mass ? milligram + amount : milligram,
        milliliter: amount is Volume ? milliliter + amount : milliliter,
        count: amount is Count ? count + amount : count,
      );
}

extension IterablePrep on Iterable<Prep> {
  Iterable<Prep> sumAmounts() => fold(
        <Ingredient, _AmountSet>{},
        (sum, prep) => sum
          ..update(
            prep.ingredient,
            (amountSet) => amountSet.add(prep.amount),
            ifAbsent: () {
              final amount = prep.amount;
              return _AmountSet(
                count: amount is Count ? amount : null,
                milligram: amount is Mass ? amount.toMilligram() : null,
                milliliter: amount is Volume ? amount.toMilliliter() : null,
              );
            },
          ),
      ).entries.expand((element) {
        final ingredient = element.key;
        final amountSet = element.value;
        final milligram = amountSet.milligram;
        final milliliter = amountSet.milliliter;
        final count = amountSet.count;
        return [
          if (milligram.value > 0)
            Prep<Mass>(ingredient: ingredient, amount: milligram),
          if (milliliter.value > 0)
            Prep<Volume>(ingredient: ingredient, amount: milliliter),
          if (count.value > 0)
            Prep<Count>(ingredient: ingredient, amount: count),
        ];
      });

  Iterable<Prep> scaleAmounts(double scale) =>
      map((prep) => prep.scaleAmount(scale));
}
