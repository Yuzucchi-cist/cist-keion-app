import '../../../../core/factories/data_factory.dart';
import '../../../domain/value/belongings/band.dart';
import '../../../domain/value/belongings/belonging.dart';
import '../../model/auth/firestore/belonging_model.dart';

abstract class BelongingFactory
    implements DataFactory<Belonging, BelongingModel, BelongingParams> {}

class BelongingFactoryImpl implements BelongingFactory {
  @override
  BelongingModel convertToModel(Belonging entity) {
    if (entity is Band) {
      return BelongingModel(
        id: entity.id,
        type: BelongingType.band,
        name: entity.name,
      );
    }
    return BelongingModel(
      id: entity.id,
      type: BelongingType.unexpected,
      name: entity.name,
    );
  }

  @override
  Belonging create(BelongingParams value) {
    switch (value.type) {
      case BelongingType.band:
        return Band(id: value.id, name: value.name);
      case BelongingType.unexpected:
        return UnexpectedBelonging(id: value.id, name: value.name);
    }
  }

  @override
  Belonging createFromModel(BelongingModel model) {
    switch (model.type) {
      case BelongingType.band:
        return Band(id: model.id, name: model.name);
      case BelongingType.unexpected:
        return UnexpectedBelonging(id: model.id, name: model.name);
    }
  }
}

class BelongingParams {
  const BelongingParams({
    required this.id,
    required this.type,
    required this.name,
  });

  final String id;
  final BelongingType type;
  final String name;
}
