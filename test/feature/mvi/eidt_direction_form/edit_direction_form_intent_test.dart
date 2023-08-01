import 'package:cooking_calulator/feature/mvi/edit_direction_form/edit_direction_form_mvi.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class StateListener extends Mock {
  void call(EditDirectionFormState? previous, EditDirectionFormState next);
}

void main() {
  late ProviderContainer container;
  late StateListener listener;

  final direction = Direction(
    description: 'description',
    preps: [
      Prep(
        amount: Gram(1),
        ingredient: const Ingredient(
          description: 'description1',
          name: 'name1',
        ),
      ),
      Prep(
        amount: Gram(1),
        ingredient: const Ingredient(
          description: 'description2',
          name: 'name2',
        ),
      ),
    ],
    temperature: Temperature.celsius(0),
  );
  final newPrep = Prep(
    amount: Kilogram(1.0),
    ingredient: const Ingredient(
      name: 'newIngredient',
      description: 'newDescription',
    ),
  );

  setUp(() {
    container = ProviderContainer();
    listener = StateListener();
  });

  group(
    '초기화 시',
    () {
      test(
        'Direction 이 주어지지 않으면 기본값으로 초기화한다.',
        () {
          container.listen(
            editDirectionFormIntentProvider(null),
            listener.call,
            fireImmediately: true,
          );

          verify(
            listener(
              null,
              const EditDirectionFormState(),
            ),
          ).called(1);
        },
      );

      test(
        'Direction 이 주어지면 Direction 으로 기본값을 초기화한다.',
        () {
          container.listen(
            editDirectionFormIntentProvider(direction),
            listener.call,
            fireImmediately: true,
          );

          verify(
            listener(
              null,
              EditDirectionFormState(
                description: direction.description,
                preps: direction.preps,
                temperature: direction.temperature,
                time: direction.time,
              ),
            ),
          ).called(1);
        },
      );
    },
  );

  test(
    '상세 설명을 변경한다.',
    () {
      final provider = editDirectionFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );
      const description = 'description';

      container.read(provider.notifier).setDescription(description);

      verify(
        listener(
          const EditDirectionFormState(),
          const EditDirectionFormState(description: description),
        ),
      ).called(1);
    },
  );

  test(
    '선택한 Prep 을 변경한다.',
    () {
      final provider = editDirectionFormIntentProvider(direction);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).changePrep(
            previous: direction.preps.first,
            changed: newPrep,
          );

      verify(
        listener(
          EditDirectionFormState(
            description: direction.description,
            preps: direction.preps,
            temperature: direction.temperature,
            time: direction.time,
          ),
          EditDirectionFormState(
            description: direction.description,
            preps: [
              newPrep,
              direction.preps.last,
            ],
            temperature: direction.temperature,
            time: direction.time,
          ),
        ),
      ).called(1);
    },
  );

  test(
    'Prep 을 추가한다.',
    () {
      final provider = editDirectionFormIntentProvider(direction);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).addPrep(newPrep);

      verify(
        listener(
          EditDirectionFormState(
            description: direction.description,
            preps: direction.preps,
            temperature: direction.temperature,
            time: direction.time,
          ),
          EditDirectionFormState(
            description: direction.description,
            preps: [
              ...direction.preps,
              newPrep,
            ],
            temperature: direction.temperature,
            time: direction.time,
          ),
        ),
      ).called(1);
    },
  );

  test(
    'Prep 을 제거한다.',
    () {
      final provider = editDirectionFormIntentProvider(direction);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).removePrep(direction.preps.first);

      verify(
        listener(
          EditDirectionFormState(
            description: direction.description,
            preps: direction.preps,
            temperature: direction.temperature,
            time: direction.time,
          ),
          EditDirectionFormState(
            description: direction.description,
            preps: [direction.preps.last],
            temperature: direction.temperature,
            time: direction.time,
          ),
        ),
      ).called(1);
    },
  );

  test(
    '조리 온도를 설정한다.',
    () {
      final provider = editDirectionFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );

      final temperature = Temperature.celsius(0.0);
      container.read(provider.notifier).setTemperature(temperature);

      verify(
        listener(
          const EditDirectionFormState(),
          EditDirectionFormState(temperature: temperature),
        ),
      ).called(1);
    },
  );

  test(
    '조리 온도를 제거한다.',
    () {
      final provider = editDirectionFormIntentProvider(direction);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).clearTemperature();

      verify(
        listener(
          EditDirectionFormState(
            description: direction.description,
            preps: direction.preps,
            temperature: direction.temperature,
            time: direction.time,
          ),
          EditDirectionFormState(
            description: direction.description,
            preps: direction.preps,
            time: direction.time,
          ),
        ),
      ).called(1);
    },
  );

  test(
    '조리 시간을 설정한다.',
    () {
      final provider = editDirectionFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );

      const time = Duration(hours: 1);
      container.read(provider.notifier).setTime(time);

      verify(
        listener(
          const EditDirectionFormState(),
          const EditDirectionFormState(time: time),
        ),
      ).called(1);
    },
  );
}
