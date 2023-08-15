import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/member_detail/member_detail_failure.dart';
import '../../../domain/entity/member_detail/member_detail.dart';
import '../../provider/notifier/auth/member_detail_list_notifier.dart';
import '../../provider/state/auth/member_detail_file.dart';
import '../../widget/auth/confirm_registerirng_button.dart';
import '../../widget/show_error_dialog.dart';

@RoutePage()
class AddMembersPage extends HookConsumerWidget {
  const AddMembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedFileName = ref.watch(memberDetailListProvider);
    final dataTable = useState<DataTable?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー追加'),
      ),
      floatingActionButton: pickedFileName != MemberDetailFile.noData()
          ? confirmRegisteringBottun(context, pickedFileName.fileName,
              (context) async {
              final addedData = await add(context, ref);
              if (addedData != null) {
                return memberDetailTable(addedData);
              }
              return null;
            })
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: pickedFileName == MemberDetailFile.noData()
              ? Column(
                  children: [
                    ElevatedButton(
                      child: const Text('ファイルを選択してください'),
                      onPressed: () {
                        pickFile(context, ref).then((memberDetailFile) {
                          if (memberDetailFile != null) {
                            dataTable.value =
                                memberDetailTable(memberDetailFile.data);
                          }
                        });
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(pickedFileName.fileName),
                        ElevatedButton(
                          child: const Text('変更'),
                          onPressed: () {
                            pickFile(context, ref).then((memberDetailFile) {
                              if (memberDetailFile != null) {
                                dataTable.value =
                                    memberDetailTable(memberDetailFile.data);
                              }
                            });
                          },
                        )
                      ],
                    ),
                    dataTable.value,
                  ].nonNulls.toList(),
                ),
        ),
      ),
    );
  }

  Future<MemberDetailFile?> pickFile(
      BuildContext context, WidgetRef ref) async {
    final result = await ref.read(memberDetailListProvider.notifier).pickFile();
    return result.fold((failure) {
      if (failure is MemberDetailFailure) {
        showErrorDialog(
          context: context,
          titleText: failure.state.name,
          contentText: failure.state.toString(),
        );
      }
      return null;
    }, (memberDetailFile) => memberDetailFile);
  }

  Future<List<MemberDetail>?> add(BuildContext context, WidgetRef ref) async {
    final result =
        await ref.read(memberDetailListProvider.notifier).addToDatabase();
    return result.fold((failure) {
      if (failure is MemberDetailFailure) {
        showErrorDialog(
          context: context,
          titleText: failure.state.name,
          contentText: failure.state.toString(),
        );
      }
      return null;
    }, (memberDetailList) {
      if (memberDetailList.isNotEmpty) {
        return memberDetailList;
      } else {
        showErrorDialog(
            context: context,
            titleText: 'エラー',
            contentText: '登録できるデータがありませんでした。');
        return null;
      }
    });
  }

  DataTable memberDetailTable(List<MemberDetail> file) {
    final sortedData = file
      ..sort((a, b) => a.instituteGrade.index - b.instituteGrade.index);
    final columnList = ['学籍番号', '名前', '学年'];
    return DataTable(
      columns:
          columnList.map((column) => DataColumn(label: Text(column))).toList(),
      rows: sortedData
          .map(
            (data) => DataRow(cells: [
              DataCell(Text(data.studentNumber)),
              DataCell(Text(data.name)),
              DataCell(Text(data.instituteGrade.jpString))
            ]),
          )
          .toList(),
    );
  }
}
