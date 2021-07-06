import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure/layout/todo_app/cubit/states.dart';
import 'package:structure/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:structure/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:structure/modules/todo_app/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  List<String> title = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Table created');
        }).catchError((e) {
          print('Error When Creating Table ${e.toString()}');
        });
      },
      onOpen: (database) {
        getDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")')
          .then((value) {
        print('$value Table insered seccesfuly');
        emit(AppInsertDatabaseState());
        getDatabase(database);
      }).catchError((e) {
        print(' Error When Inserting Table ${e.toString()}');
      });
    });
  }

  void getDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];

    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else
          archivedtasks.add(element);
      });

      print(value);

      emit(AppGetDatabaseState());
    });
  }

  IconData fabIcon = Icons.edit;
  bool isBottonSheetShown = false;

  void changeBottomSheetState0({
    required bool isShow,
    required IconData icon,
  }) {
    isBottonSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database!.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
      getDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
