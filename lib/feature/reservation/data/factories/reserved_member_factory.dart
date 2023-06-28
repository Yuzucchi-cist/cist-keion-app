import '../../../../core/factories/data_factory.dart';
import '../../domain/values/reserved_member.dart';
import '../models/reserved_member_model.dart';

class ReservedMemberFactory
    implements
        DataFactory<ReservedMember, ReservedMemberModel, ReservedMemberParams> {
  @override
  ReservedMemberModel convertToModel(ReservedMember entity) {
    return ReservedMemberModel(id: entity.id, name: entity.name);
  }

  @override
  ReservedMember create(ReservedMemberParams params) {
    return ReservedMember(id: params.id, name: params.name);
  }

  @override
  ReservedMember createFromModel(ReservedMemberModel model) {
    return ReservedMember(id: model.id, name: model.name);
  }
}

class ReservedMemberParams {
  ReservedMemberParams({required this.id, required this.name});

  final String id;
  final String name;
}
