import '../../../../core/factories/data_factory.dart';
import '../../../domain/value/institute_time.dart';

class InstituteTimeFactory
    implements DataFactory<InstituteTime, String, String> {
  @override
  String convertToModel(InstituteTime entity) {
    return entity.name;
  }

  @override
  InstituteTime create(String param) {
    return InstituteTime.values.byName(param);
  }

  @override
  InstituteTime createFromModel(String model) {
    return InstituteTime.values.byName(model);
  }
}
