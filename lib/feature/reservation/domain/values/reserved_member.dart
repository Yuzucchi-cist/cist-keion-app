import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/reserved_member.freezed.dart';

@freezed
class ReservedMember with _$ReservedMember {
  const factory ReservedMember({
    required String id,
    required String name,
  }) = _ReservedMember;
}
