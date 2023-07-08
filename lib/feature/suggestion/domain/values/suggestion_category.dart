// ignore_for_file: sort_constructors_first

enum SuggestionCategory {
  live('ライブ'),
  club_room('部室'),
  equipment('機材'),
  other('その他');

  final String _value;

  const SuggestionCategory(this._value);

  String get jpString => _value;
}
