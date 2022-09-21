import 'package:flutter/material.dart';
import 'package:mtask/cubit/cubit.dart';

class list extends StatelessWidget {
  final Map model;
  final bool inDone;
  const list({Key? key, required this.model,required this.inDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      
      background:inDone? Container(
        padding:const  EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
        color: Colors.green[400],
        child:const Text("Done",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold
        ),),
      ):Container(
        padding:const  EdgeInsets.only(top: 50.0, left: 25.0),
        color: Colors.red[400],
        child:const Text("Delete",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold
        ),),
      ), 
      secondaryBackground: Container(
        padding:const  EdgeInsets.only(top: 50.0, left: 320.0),
        color: Colors.red[400],
        child:const Text("Delete",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold
        ),),
      ), 
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
                icon: const Icon(
                  Icons.archive_outlined,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        if(direction == DismissDirection.startToEnd && inDone ){
          AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
        }else{
          AppCubit.get(context).deleteData(id: model['id']);
        }
        
      },
    );
  }
}
