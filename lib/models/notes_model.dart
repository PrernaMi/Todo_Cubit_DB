import '../database/local/db_helper.dart';

class NotesModel {
  String title;
  String desc;
  int? s_no;
  int? isComp;

  NotesModel({required this.title, required this.desc, this.s_no, this.isComp});

  factory NotesModel.fromMap({required Map<String, dynamic> map}) {
    return NotesModel(
        title: map[DbHelper.table_col_title],
        desc: map[DbHelper.table_col_desc],
        isComp: map[DbHelper.table_col_isCompleted],
        s_no: map[DbHelper.table_col_s_no]);
  }

  Map<String, dynamic> toMap() {
    return {DbHelper.table_col_title: title,
      DbHelper.table_col_desc: desc,
      DbHelper.table_col_isCompleted : isComp,
      DbHelper.table_col_s_no : s_no
    };
  }
}
