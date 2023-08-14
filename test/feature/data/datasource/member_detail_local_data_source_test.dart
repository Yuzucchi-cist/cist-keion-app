import 'dart:convert';

import 'package:cist_keion_app/core/error/exception/picking_file_exception.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_local_data_source.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/member_detail_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
import 'member_detail_local_data_source_test.mocks.dart';

@GenerateMocks([FilePicker])
void main() {
  late MemberDetailLocalDataSourceImpl dataSource;
  late MockFilePicker mockFilePicker;

  setUp(() {
    mockFilePicker = MockFilePicker();
    dataSource = MemberDetailLocalDataSourceImpl(filePicker: mockFilePicker);
  });

  final tCorrectResult = getFilePickerResult(excelMemberDetailPath);
  final tIllegalFileTypeResult =
      getFilePickerResult(txtillegalFileTypeMemberDetailPath);
  final tIllegalTableFormatResult =
      getFilePickerResult(excelIllegalTableFormatMemberDetailPath);

  final tFileName = tCorrectResult.files.first.name;
  final tMemberDetailJson =
      json.decode(fixtureReader(jsonMemberDetailData)) as List;
  final tMemberDetailModelList = tMemberDetailJson
      .map((json) => MemberDetailModel.fromJson(json as Map<String, dynamic>));

  group('pickFromLocalFile', () {
    test('should call the pick files', () async {
      // arrange
      when(mockFilePicker.pickFiles())
          .thenAnswer((realInvocation) async => tCorrectResult);
      // act
      await dataSource.pickFromLocalFile();
      // assert
      verify(mockFilePicker.pickFiles());
    });

    test('should return model when picking file is successful', () async {
      // arrange
      when(mockFilePicker.pickFiles())
          .thenAnswer((realInvocation) async => tCorrectResult);
      // act
      final result = await dataSource.pickFromLocalFile();
      // assert
      expect(result.$1, tFileName);
      expect(result.$2, unorderedEquals(tMemberDetailModelList));
    });

    test('should throw picking file exception when result is null', () async {
      // arrange
      when(mockFilePicker.pickFiles())
          .thenAnswer((realInvocation) async => null);
      try {
        // act
        await dataSource.pickFromLocalFile();
        fail('');
        // assert
      } on PickingFileException catch (e) {
        expect(e.code, 'no-file');
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });

    test('should throw picking file exception when fyle type is not xlsx',
        () async {
      // arrange
      when(mockFilePicker.pickFiles())
          .thenAnswer((realInvocation) async => tIllegalFileTypeResult);
      try {
        // act
        await dataSource.pickFromLocalFile();
        fail('');
        // assert
      } on PickingFileException catch (e) {
        expect(e.code, 'illegal-file-type');
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });

    test('should throw picking file exception when table format is illegal',
        () async {
      // arrange
      when(mockFilePicker.pickFiles())
          .thenAnswer((realInvocation) async => tIllegalTableFormatResult);
      try {
        // act
        await dataSource.pickFromLocalFile();
        fail('');
        // assert
      } on PickingFileException catch (e) {
        expect(e.code, 'illegal-table-format');
      } catch (e) {
        fail('Not-expect object was thrown ( $e )');
      }
    });
  });
}

FilePickerResult getFilePickerResult(String path) {
  final fileBytes = bytesReader(path);
  final fileName = path.split('/').last;
  return FilePickerResult([
    PlatformFile(
        path: path,
        name: fileName,
        size: fileBytes.lengthInBytes,
        bytes: fileBytes)
  ]);
}
