part of 'localization.dart';

extension ServingUnitLocalilzation on ServingUnit {
  String get translated => switch (this) {
        ServingUnit.portion => '인분',
        ServingUnit.count => '개',
      };
}
