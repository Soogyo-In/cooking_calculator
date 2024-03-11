part of 'mapper.dart';

extension DataServingUnitMapper on ServingUnit {
  domain.ServingUnit toDomainModel() => switch (this) {
        ServingUnit.portion => domain.ServingUnit.portion,
        ServingUnit.count => domain.ServingUnit.count,
      };
}

extension DomainServingUnitMapper on domain.ServingUnit {
  ServingUnit toDataModel() => switch (this) {
        domain.ServingUnit.portion => ServingUnit.portion,
        domain.ServingUnit.count => ServingUnit.count,
      };
}
