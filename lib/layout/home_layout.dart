import 'package:flutter/material.dart';
import 'package:structure/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:structure/shared/cubit/cubit.dart';
import 'package:structure/shared/cubit/states.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

// 1.Create Database ;
// 2. Create Tables ;
// 3. Open Database ;
// 4. Insert to Database ;
// 5. Gat from Database ;
// 6. Update in Database ;
// 7. Delete from Database ;

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

//  @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              body: state is AppGetDatabaseLoadingState
                  ? Center(child: CircularProgressIndicator())
                  : cubit.screens[cubit.currentIndex],
              appBar: AppBar(
                title: Text(cubit.title[cubit.currentIndex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
                    cubit.insertDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  } else {
                    cubit.isBottonSheetShown = true;
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Form(
                            key: formKey,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CostumTextFormFeild(
                                    label: 'Task Title',
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Title Must Not Be Empty ';
                                      }
                                      return null;
                                    },
                                    prefix: Icons.title,
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  CostumTextFormFeild(
                                    type: TextInputType.datetime,
                                    label: 'Task Time',
                                    controller: timeController,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            (value!.format(context)).toString();
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Time Must Not Be Empty ';
                                      }
                                      return null;
                                    },
                                    prefix: Icons.watch_later_outlined,
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  CostumTextFormFeild(
                                    type: TextInputType.datetime,
                                    label: 'Task Date',
                                    controller: dateController,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2022-03-15'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'Date Must Not Be Empty ';
                                      }
                                      return null;
                                    },
                                    prefix: Icons.calendar_today,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 50.0,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState0(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState0(
                        isShow: false, icon: Icons.add);
                  }
                },
                child: Icon(
                  cubit.fabIcon,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archive',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
