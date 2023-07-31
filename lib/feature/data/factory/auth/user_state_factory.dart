import '../../../../core/factories/data_factory.dart';
import '../../../domain/value/user_state.dart';
import '../../model/auth/firestore/user_state_model.dart';

abstract class UserStateFactory
    implements DataFactory<UserState, UserStateModel, String> {}

class UserStateFactoryImpl implements UserStateFactory {
  @override
  UserStateModel convertToModel(UserState entity) {
    switch (entity) {
      case UserState.active:
        return UserStateModel.active;
      case UserState.sleep:
        return UserStateModel.sleep;
      case UserState.quited:
        return UserStateModel.quited;
    }
  }

  @override
  UserState create(String value) {
    return UserState.values.byName(value);
  }

  @override
  UserState createFromModel(UserStateModel model) {
    switch (model) {
      case UserStateModel.active:
        return UserState.active;
      case UserStateModel.sleep:
        return UserState.sleep;
      case UserStateModel.quited:
        return UserState.quited;
    }
  }
}
