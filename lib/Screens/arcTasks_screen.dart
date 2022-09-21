import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../sharedcompnents/list.dart';

class arcTasks_screen extends StatelessWidget {
  const arcTasks_screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivetasks;
         return tasks.length > 0 ?
         ListView.separated(
        itemBuilder: (context, index) => list(  model: tasks[index], inDone: true,),
        separatorBuilder: (context, index) => Container(
          width: double.maxFinite,
          height: 1.0,
          color: Colors.grey[200],
        ),
        itemCount: tasks.length):
         Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 100.0,
                    ),
                    Text(
                      "No Tasks Yet , Please Add Some Tasks",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              );
      },  
    );
  }
}