import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_db/cubit/cubit_states.dart';
import 'package:todo_cubit_db/models/notes_model.dart';

import '../database/local/db_helper.dart';

class TodoCubit extends Cubit<CubitState>{
  DbHelper? mainDb;
  TodoCubit({required this.mainDb}) : super(TodoLoadingState());

  double isComp = 0;
  //events

   void addInCubit({required NotesModel newNote})async{
     emit(TodoLoadingState());
     bool check = await mainDb!.addInDb(title: newNote.title, desc: newNote.desc, isComp: 0);
     if(check){
       var data = await mainDb!.getAllNotesFromDb();
       emit(TodoLoadedState(mTask: data));
     }else{
       emit(TodoErrorState(error: "No Task added"));
     }
   }

   void getInitialNotesCubit()async{
     emit(TodoLoadingState());
     List<NotesModel> data = await mainDb!.getAllNotesFromDb();
     emit(TodoLoadedState(mTask: data));
   }

   void updateInCubit({required NotesModel newNote,required int s_no})async{
     emit(TodoLoadingState());
     bool check = await mainDb!.updateInDb(title: newNote.title, desc: newNote.desc, s_no: s_no);
     if(check){
       var data = await mainDb!.getAllNotesFromDb();
       emit(TodoLoadedState(mTask: data));
     }else{
       emit(TodoErrorState(error: "No Task Updated"));
     }
   }

   void deleteTaskCubit({required int s_no})async{
     emit(TodoLoadingState());
     bool check = await mainDb!.deleteFromDb(s_no: s_no);
     if(check){
       var data = await mainDb!.getAllNotesFromDb();
       emit(TodoLoadedState(mTask: data));
     }else{
       emit(TodoErrorState(error: "No task deleted"));
     }
   }

   void addIsCompCubit({required int s_no,required int isCheck})async{
     emit(TodoLoadingState());
     bool check = await mainDb!.addIsCompleted(s_no: s_no, isCheck: isCheck);
     if(check){
       var data = await mainDb!.getAllNotesFromDb();
       emit(TodoLoadedState(mTask: data));
     }else{
       emit(TodoErrorState(error: "No task updated"));
     }
   }

   void getIsCompleted()async{
     emit(TodoLoadingState());
     isComp = await mainDb!.getIsCompleted();
   }

   double retIsCom(){
     return isComp;
   }

}