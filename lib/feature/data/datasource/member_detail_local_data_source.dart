import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/error/exception/picking_file_exception.dart';
import '../model/member_detail/institute_grade_model.dart';
import '../model/member_detail/member_detail_model.dart';

abstract class MemberDetailLocalDataSource {
  Future<(String fileName, List<MemberDetailModel> data)> pickFromLocalFile();
}

class MemberDetailLocalDataSourceImpl implements MemberDetailLocalDataSource {
  MemberDetailLocalDataSourceImpl({required this.filePicker});

  final FilePicker filePicker;

  @override
  Future<(String, List<MemberDetailModel>)> pickFromLocalFile() async {
    final result = await filePicker.pickFiles();
    if (result == null) {
      throw PickingFileException(code: 'no-file', message: 'nothing is picked');
    }
    final pickedFile = result.files.first;
    if (pickedFile.name.split('.').last != 'xlsx') {
      throw PickingFileException(
          code: 'illegal-file-type', message: 'ERROR: File type must be xlsx');
    }
    final rows = convertExcel(pickedFile.bytes!);

    final keys = rows.first;
    final values = rows..removeAt(0);

    final studentNumberIndex = keys.indexOf('学籍番号');
    final nameIndex = keys.indexOf('名前');
    final instituteGradeIndex = keys.indexOf('学年');

    if (studentNumberIndex < 0 || nameIndex < 0 || instituteGradeIndex < 0) {
      throw PickingFileException(
          code: 'illegal-table-format',
          message: 'ERROR: column name must have "学籍番号", "名前" and "学年"');
    }

    final memberDetailModelList = values.map((row) {
      final studentNumber = row.elementAt(studentNumberIndex) as String;
      final name = row.elementAt(nameIndex) as String;
      final instituteGrade = InstituteGradeModel.values
          .elementAt((row.elementAt(instituteGradeIndex) as int) - 1);

      return MemberDetailModel(
        studentNumber: studentNumber,
        name: name,
        instituteGrade: instituteGrade,
      );
    }).toList();

    return (pickedFile.name, memberDetailModelList);
  }

  List<List<dynamic>> convertExcel(Uint8List bytes) {
    final excel = Excel.decodeBytes(bytes);
    final reg = RegExp(r'<t>(.+?)</t>');
    final excelRows = excel.sheets.values.first.rows;
    final rows = excelRows
        .map((e) => e.map((e) {
              if (e == null) {
                return '';
              }
              final value = e.value;
              if (value.runtimeType == SharedString) {
                return reg
                    .firstMatch((value as SharedString).node.toXmlString())
                    ?.group(1);
              }
              return value;
            }).toList())
        .toList();
    return rows;
  }
}
