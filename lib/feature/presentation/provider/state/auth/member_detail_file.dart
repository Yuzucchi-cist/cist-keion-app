import '../../../../domain/entity/member_detail/member_detail.dart';

class MemberDetailFile {
  const MemberDetailFile({required this.fileName, required this.data});
  factory MemberDetailFile.noData() =>
      const MemberDetailFile(fileName: '', data: []);

  final String fileName;
  final List<MemberDetail> data;
}
