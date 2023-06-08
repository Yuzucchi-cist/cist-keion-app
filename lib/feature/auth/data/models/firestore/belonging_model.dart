import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/belonging_model.freezed.dart';

@freezed
class BelongingModel<Params> with _$BelongingModel<Params> {
  const factory BelongingModel({
    required String id,
    required BelongingType type,
    required String name,
    required List<String> memberIds,
    required Params additionalParams,
  }) = _BelongingModel;
}

enum BelongingType {
  band,
  unexpected,
}

class NoAdditionalParam {}
