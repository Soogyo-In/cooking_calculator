import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const recipe = Recipe();

  test(
    '레시피 목록을 pageable 하게 조회한다.',
    () {},
  );

  group(
    '실패 케이스',
    () {
      test(
        '레시피 목록을 조회하는데 실패하면 스낵바가 노출된다.',
        () {},
      );
    },
  );
}
