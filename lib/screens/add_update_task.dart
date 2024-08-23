
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_db/cubit/todo_cubit.dart';

import '../models/notes_model.dart';

class AddUpdateScreen extends StatelessWidget {
  bool flag;
  int? s_no;
  String? mTitle;
  String? mDesc;
  TextEditingController titleContoller = TextEditingController();
  TextEditingController descController = TextEditingController();

  AddUpdateScreen({required this.flag, this.s_no,this.mTitle,this.mDesc});

  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      titleContoller.text = mTitle!;
      descController.text = mDesc!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: flag == true
                ? Text("Add your task")
                : Text("Update your task")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          flag == true
              ? Text(
                  "Add your task",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )
              : Text(
                  "Update your task",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: titleContoller,
              decoration: InputDecoration(
                  hintText: "Enter Your title",
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: "Enter Your description",
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                flag == true
                    ? context.read<TodoCubit>().addInCubit(
                        newNote: NotesModel(
                          title: titleContoller.text.toString(),
                          desc: descController.text.toString(),
                        ),)
                    : context.read<TodoCubit>().updateInCubit(
                        newNote: NotesModel(
                            title: titleContoller.text.toString(),
                            desc: descController.text.toString()),
                        s_no: s_no!);
                Navigator.pop(context);
              },
              child: flag == true ? Text("Add") : Text("Update"))
        ],
      ),
    );
  }
}
