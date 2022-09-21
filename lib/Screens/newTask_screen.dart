import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtask/cubit/states.dart';
import 'package:mtask/sharedcompnents/list.dart';

import '../constant.dart';
import '../cubit/cubit.dart';

class newTasks_screen extends StatelessWidget {
  const newTasks_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).newtasks;
         return tasks.length >0 ?
         ListView.separated(
        itemBuilder: (context, index) => list(model: tasks[index], inDone: true,),
        separatorBuilder: (context, index) => Container(
          width: double.maxFinite,
          height: 1.0,
          color: Colors.grey[200],
        ),
        itemCount: tasks.length)
        :
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:const  [
              Icon(Icons.menu ,
              color: Colors.grey,
              size: 100.0,),
              Text("No Tasks Yet , Please Add Some Tasks", 
              style:TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),)
            ],
          ),
        )
        ;
      },  
    );

   
  }
}
