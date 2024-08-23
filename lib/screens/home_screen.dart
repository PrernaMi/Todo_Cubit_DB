import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_db/cubit/cubit_states.dart';
import 'package:todo_cubit_db/cubit/todo_cubit.dart';
import 'add_update_task.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<TodoCubit>().getInitialNotesCubit();
    context.read<TodoCubit>().getIsCompleted();
    super.initState();
  }

  Icon icon = Icon(
    Icons.circle_outlined,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    progress = context.watch<TodoCubit>().retIsCom();
    double pro = progress==0 ? 0 : progress;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page")),
      ),
      body: BlocBuilder<TodoCubit,CubitState>(
        builder: (_, state) {
          if(state is TodoLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is TodoErrorState){
            return Center(
              child: Text('${state.error}'),
            );
          }

          if(state is TodoLoadedState){
            pro = pro/state.mTask.length;
            pro = (pro*100).roundToDouble();
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's task",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                      ),
                    ],
                  ),
                  Expanded(
                    child: state.mTask.isNotEmpty
                        ? ListView.builder(
                        itemCount: state.mTask.length,
                        itemBuilder: (_, Index) {
                          return ListTile(
                            leading: SizedBox(
                              width: 65,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (state.mTask[Index].isComp == 0) {
                                          context.read<TodoCubit>().addIsCompCubit(
                                              s_no: state.mTask[Index].s_no!,
                                              isCheck: 1);
                                          context.read<TodoCubit>().getIsCompleted();
                                          setState(() {

                                          });
                                        } else {
                                          context
                                              .read<TodoCubit>()
                                              .addIsCompCubit(
                                              s_no: state.mTask[Index].s_no!,
                                              isCheck: 0);
                                          context.read<TodoCubit>().getIsCompleted();
                                          setState(() {

                                          });
                                        }
                                      },
                                      child: state.mTask[Index].isComp == 0
                                          ? Icon(
                                        Icons.circle_outlined,
                                        size: 30,
                                      )
                                          : Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                          child: Text(
                                            '${Index + 1}',
                                            style: TextStyle(fontSize: 15),
                                          )))
                                ],
                              ),
                            ),
                            title: state.mTask[Index].isComp == 1
                                ? Text(
                              state.mTask[Index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough),
                            )
                                : Text(
                              state.mTask[Index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(state.mTask[Index].desc),
                            trailing: SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return AddUpdateScreen(
                                                flag: false,
                                                s_no: state.mTask[Index].s_no,
                                                mTitle: state.mTask[Index].title,
                                                mDesc: state.mTask[Index].desc,
                                              );
                                            }));
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 30,
                                      )),
                                  InkWell(
                                    onTap: (){
                                      context.read<TodoCubit>().deleteTaskCubit(s_no: state.mTask[Index].s_no!);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                        : Center(
                        child: Text(
                          "No Notes yet..",
                          style: TextStyle(fontSize: 25),
                        )),
                  )
                ],
              ),
            );
          }
          return Container();
        },),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add task",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddUpdateScreen(
              flag: true,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
