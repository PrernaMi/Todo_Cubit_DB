import '../models/notes_model.dart';

abstract class CubitState{}

class TodoInitialState extends CubitState{}

class TodoLoadingState extends CubitState{}

class TodoLoadedState extends CubitState{
  List<NotesModel> mTask =[];
  TodoLoadedState({required this.mTask});
}

class TodoErrorState extends CubitState{
  String error;
  TodoErrorState({required this.error});
}