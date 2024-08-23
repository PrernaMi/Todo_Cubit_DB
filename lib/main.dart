import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_db/cubit/todo_cubit.dart';
import 'package:todo_cubit_db/database/local/db_helper.dart';
import 'package:todo_cubit_db/screens/splash_screen.dart';

void main() {
  runApp(BlocProvider(create: (context){
    return TodoCubit(mainDb: DbHelper.getInstances);
  },child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
