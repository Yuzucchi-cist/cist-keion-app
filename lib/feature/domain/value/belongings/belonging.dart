abstract class Belonging {
  Belonging({required this.id, required this.name});

  final String id;
  final String name;
}

class UnexpectedBelonging extends Belonging {
  UnexpectedBelonging({required super.id, required super.name});
}
