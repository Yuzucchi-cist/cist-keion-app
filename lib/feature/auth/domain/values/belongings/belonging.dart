abstract class Belonging {
  Belonging({required this.id, required this.name, required this.memberIds});

  final String id;
  final String name;
  final List<String> memberIds;
}

class UnexpectedBelonging extends Belonging {
  UnexpectedBelonging(
      {required super.id, required super.name, required super.memberIds});
}
