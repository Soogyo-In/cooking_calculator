import 'package:cooking_calulator/feature/feature.dart';
import 'package:data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class StateListener extends Mock {
  void call(EditRecipeFormState? previous, EditRecipeFormState next);
}

void main() {
  late ProviderContainer container;
  late StateListener listener;

  const direction1 = Direction(description: 'description1');
  const direction2 = Direction(description: 'description2');
  const direction3 = Direction(description: 'description3');
  const recipe = Recipe(
    name: 'name',
    description: 'description',
    directions: [
      direction1,
      direction2,
    ],
    servings: 1,
  );

  setUp(() {
    container = ProviderContainer();
    listener = StateListener();
  });

  group(
    '초기화 시',
    () {
      test(
        '레시피가 주어지지 않으면 기본값으로 초기화한다.',
        () {
          container.listen(
            editRecipeFormIntentProvider(null),
            listener.call,
            fireImmediately: true,
          );

          verify(
            listener(
              null,
              const EditRecipeFormState(),
            ),
          ).called(1);
        },
      );

      test(
        '레시피가 주어지면 레시피로로 기본값을 초기화한다.',
        () {
          container.listen(
            editRecipeFormIntentProvider(recipe),
            listener.call,
            fireImmediately: true,
          );

          verify(
            listener(
              null,
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );
    },
  );

  test(
    '이름을 변경한다.',
    () {
      final provider = editRecipeFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );
      const name = 'name';

      container.read(provider.notifier).setName(name);

      verify(
        listener(
          const EditRecipeFormState(),
          const EditRecipeFormState(name: name),
        ),
      ).called(1);
    },
  );

  test(
    '상세 설명을 변경한다.',
    () {
      final provider = editRecipeFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );
      const description = 'description';

      container.read(provider.notifier).setDescription(description);

      verify(
        listener(
          const EditRecipeFormState(),
          const EditRecipeFormState(description: description),
        ),
      ).called(1);
    },
  );

  test(
    '선택한 과정을 변경한다.',
    () {
      final provider = editRecipeFormIntentProvider(recipe);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).changeDirection(
            previous: recipe.directions.first,
            next: direction3,
          );

      verify(
        listener(
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: recipe.directions,
            servings: recipe.servings,
          ),
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: [
              direction3,
              direction2,
            ],
            servings: recipe.servings,
          ),
        ),
      ).called(1);
    },
  );

  test(
    '과정을 추가한다.',
    () {
      final provider = editRecipeFormIntentProvider(recipe);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).addDirection(direction3);

      verify(
        listener(
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: recipe.directions,
            servings: recipe.servings,
          ),
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: [
              direction1,
              direction2,
              direction3,
            ],
            servings: recipe.servings,
          ),
        ),
      ).called(1);
    },
  );

  test(
    '과정을 삽입한다.',
    () {
      final provider = editRecipeFormIntentProvider(recipe);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).insertDirection(1, direction3);

      verify(
        listener(
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: recipe.directions,
            servings: recipe.servings,
          ),
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: [
              direction1,
              direction3,
              direction2,
            ],
            servings: recipe.servings,
          ),
        ),
      ).called(1);
    },
  );

  test(
    '과정을 제거한다.',
    () {
      final provider = editRecipeFormIntentProvider(recipe);
      container.listen(
        provider,
        listener.call,
      );

      container
          .read(provider.notifier)
          .removeDirection(recipe.directions.first);

      verify(
        listener(
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: recipe.directions,
            servings: recipe.servings,
          ),
          EditRecipeFormState(
            name: recipe.name,
            description: recipe.description,
            directions: [direction2],
            servings: recipe.servings,
          ),
        ),
      ).called(1);
    },
  );

  group(
    '과정의 순서 변경 시',
    () {
      test(
        '뒤 순서와 변경한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(0, 1);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '앞 순서와 변경한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(1, 0);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '전 순서와 후 순서가 같으면 변경하지 않는다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(0, 0);

          verifyNever(listener.call(
            EditRecipeFormState(
              name: recipe.name,
              description: recipe.description,
              directions: recipe.directions,
              servings: recipe.servings,
            ),
            EditRecipeFormState(
              name: recipe.name,
              description: recipe.description,
              directions: recipe.directions,
              servings: recipe.servings,
            ),
          ));
        },
      );

      test(
        '전 순서가 0 미만 이라면 0 으로 처리한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(-1, 1);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '후 순서가 0 보다 작으면 0 으로 처리한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(1, -1);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '전 순서가 최대 길이를 초과한다면 최대 길이로 처리한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(0, 2);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '후 순서가 최대 길이를 초과한다면 최대 길이로 처리한다.',
        () {
          final provider = editRecipeFormIntentProvider(recipe);
          container.listen(
            provider,
            listener.call,
          );

          container.read(provider.notifier).reorderDirection(2, 0);

          verify(
            listener(
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: recipe.directions,
                servings: recipe.servings,
              ),
              EditRecipeFormState(
                name: recipe.name,
                description: recipe.description,
                directions: [
                  direction2,
                  direction1,
                ],
                servings: recipe.servings,
              ),
            ),
          ).called(1);
        },
      );
    },
  );

  test(
    '제조량을 설정한다.',
    () {
      final provider = editRecipeFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );

      const servings = 4;
      container.read(provider.notifier).setServings(servings);

      verify(
        listener(
          const EditRecipeFormState(),
          const EditRecipeFormState(servings: servings),
        ),
      ).called(1);
    },
  );

  test(
    '제조량이 1 보다 작다면 1 로 설정된다.',
    () {
      final provider = editRecipeFormIntentProvider(null);
      container.listen(
        provider,
        listener.call,
      );

      container.read(provider.notifier).setServings(0);

      verify(
        listener(
          const EditRecipeFormState(),
          const EditRecipeFormState(servings: 1),
        ),
      ).called(1);
    },
  );
}
