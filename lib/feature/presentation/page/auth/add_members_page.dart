import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entity/member_detail/member_detail.dart';
import '../../provider/notifier/auth/member_detail_list_notifier.dart';
import '../../provider/state/auth/member_detail_file.dart';
import '../../widget/auth/confirm_registerirng_button.dart';

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
          ? confirmRegisteringBottun(
              context, pickedFileName.fileName, () => add(ref))
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: pickedFileName == MemberDetailFile.noData()
              ? Column(
                  children: [
                    ElevatedButton(
                      child: const Text('ファイルを選択してください'),
                      onPressed: () {
                        pickFile(ref).then((memberDetailFile) {
                          dataTable.value =
                              memberDetailTable(memberDetailFile.data);
                        });
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(pickedFileName.fileName),
                    dataTable.value,
                  ].nonNulls.toList(),
                ),
        ),
      ),
    );
  }

  Future<MemberDetailFile> pickFile(WidgetRef ref) async {
    return ref.read(memberDetailListProvider.notifier).pickFile();
  }

  Future<void> add(WidgetRef ref) async {
    ref.read(memberDetailListProvider.notifier).addToDatabase();
  }

  DataTable memberDetailTable(List<MemberDetail> file) {
    final sortedData = file
      ..sort((a, b) => a.studentNumber.compareTo(b.studentNumber));
    final columnList = ['学籍番号', '名前', '学年'];
    return DataTable(
      columns:
          columnList.map((column) => DataColumn(label: Text(column))).toList(),
      rows: sortedData
          .map((data) => DataRow(cells: [
                DataCell(Text(data.studentNumber)),
                DataCell(Text(data.name)),
                DataCell(Text(data.instituteGrade.jpString))
              ]))
          .toList(),
    );
  }
}
