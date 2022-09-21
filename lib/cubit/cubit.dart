import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtask/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../Screens/arcTasks_screen.dart';
import '../Screens/doneTask_screen.dart';
import '../Screens/newTask_screen.dart';
import '../constant.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    newTasks_screen(),
    doneTasks_screen(),
    arcTasks_screen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Arc Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  late Database database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        print("Database crerated ");
        await database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)');
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print("Databae Opended");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title , date , time , status ) VALUES("$title ", "$date" , "$time" , "new" )')
          .then((value) {
        print('$value inserted Successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetDatabaseLoasdingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
    //print(tasks);
  }

  void updateData({required String status, required int id}) {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
        [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }
}
