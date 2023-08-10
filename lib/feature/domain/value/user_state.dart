enum UserState {
  active,
  sleep,
  quited,
}

extension UserStateExt on UserState {
  static UserState fromString(String string) {
    return UserState.values.byName(string);
  }

  static String stateToString(UserState state) {
    return state.toString();
  }
}
