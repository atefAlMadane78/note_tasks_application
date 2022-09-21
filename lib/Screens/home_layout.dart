import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mtask/Screens/arcTasks_screen.dart';
import 'package:mtask/Screens/doneTask_screen.dart';
import 'package:mtask/Screens/newTask_screen.dart';
import 'package:mtask/cubit/cubit.dart';
import 'package:mtask/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../constant.dart';

class home_layout extends StatelessWidget
//{
//   const home_layout({Key? key}) : super(key: key);

//   @override
//   State<home_layout> createState() => _home_layoutState();
// }

//class _home_layoutState extends State<home_layout>
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState states) {
          if(states is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState states) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppCubit.get(context)
                  .titles[AppCubit.get(context).currentIndex]),
            ),
            body: states is! AppGetDatabaseLoasdingState?
            
            AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex] :
               const Center(child: CircularProgressIndicator(),)
                ,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   titleController.clear();
                    //     //   timeController.clear();
                    //     //   dateController.clear();
                    //     //   isBottomSheetShown = false;

                    //     //   tasks = value;
                    //     //   print(tasks);
                    //     // });
                    //   });

                    //   // setState(() {
                    //   //   fabIcon = Icons.edit;
                    //   // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  key: const ValueKey('Task Title'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Title must not be empty";
                                    }
                                    return null;
                                  },
                                  // onSaved: (val) => _password = val!,
                                  decoration: const InputDecoration(
                                    // border: OutlineInputBorder(),
                                    //   prefix:const Icon(Icons.lock),
                                    labelText: 'Task Title',
                                    prefix: Icon(Icons.title),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  key: const ValueKey('Task Time'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Time must not be empty";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  // onSaved: (val) => _password = val!,
                                  decoration: const InputDecoration(
                                    // border: OutlineInputBorder(),
                                    //   prefix:const Icon(Icons.lock),
                                    labelText: 'Task Time',
                                    prefix: Icon(Icons.watch_later_outlined),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  //   keyboardType: TextInputType.datetime,
                                  key: const ValueKey('Task Date'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Date must not be empty";
                                    }
                                    return null;
                                  },
                                  // onSaved: (val) => _password = val!,
                                  decoration: const InputDecoration(
                                    // border: OutlineInputBorder(),
                                    //   prefix:const Icon(Icons.lock),
                                    labelText: 'Task Date',
                                    prefix: Icon(Icons.calendar_month_outlined),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse("2022-12-12"))
                                        .then((value) {
                                      dateController.text = DateFormat.yMMMd()
                                          .format(value!)
                                          .toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 15.0,
                      )
                      .closed
                      .then((value) {
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();

                    AppCubit.get(context).changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context)
                      .changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(AppCubit.get(context).fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.check), label: 'Done'),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.archive_outlined), label: 'archive'),
              ],
            ),
          );
        },
      ),
    );
  }
}
