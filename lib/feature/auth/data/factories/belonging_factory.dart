import '../../../../core/factories/data_factory.dart';
import '../../domain/values/belongings/band.dart';
import '../../domain/values/belongings/belonging.dart';
import '../models/firestore/belonging_model.dart';

abstract class BelongingFactory
    implements
        DataFactory<Belonging, BelongingModel<dynamic>,
            BelongingParams<dynamic>> {}

class BelongingFactoryImpl implements BelongingFactory {
  @override
  BelongingModel<dynamic> convertToModel(Belonging entity) {
    if (entity is Band) {
      return BelongingModel<NoAdditionalParam>(
        id: entity.id,
        type: BelongingType.band,
        name: entity.name,
        memberIds: entity.memberIds,
        additionalParams: NoAdditionalParam(),
      );
    }
    return BelongingModel<NoAdditionalParam>(
      id: entity.id,
      type: BelongingType.unexpected,
      name: entity.name,
      memberIds: entity.memberIds,
      additionalParams: NoAdditionalParam(),
    );
  }

  @override
  Belonging create(BelongingParams<dynamic> value) {
    switch (value.type) {
      case BelongingType.band:
        return Band(id: value.id, name: value.name, memberIds: value.memberIds);
      case BelongingType.unexpected:
        return UnexpectedBelonging(
            id: value.id, name: value.name, memberIds: value.memberIds);
    }
  }

  @override
  Belonging createFromModel(BelongingModel<dynamic> model) {
    switch (model.type) {
      case BelongingType.band:
        return Band(id: model.id, name: model.name, memberIds: model.memberIds);
      case BelongingType.unexpected:
        return UnexpectedBelonging(
            id: model.id, name: model.name, memberIds: model.memberIds);
    }
  }
}

class BelongingParams<AdditionalParams> {
  const BelongingParams({
    required this.id,
    required this.type,
    required this.name,
    required this.memberIds,
    required this.additionalParams,
  });

  final String id;
  final BelongingType type;
  final String name;
  final List<String> memberIds;
  final AdditionalParams additionalParams;
}
