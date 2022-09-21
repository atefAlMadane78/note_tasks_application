import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mtask/Screens/Login_screen.dart';
import 'package:mtask/Screens/home_layout.dart';

import 'cubit/bloc_observer.dart';

void main() {
    Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
/*@override
  void didChangeDependencies() {
    Provider.of<themeprovider>(context, listen:false ).getThemeMode();
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PRo 5",
      theme: ThemeData(
        dialogBackgroundColor: Colors.white70,
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 194, 86, 204)),
        primaryColor: const Color(0xFF32ccbc),
        accentColor: const Color.fromARGB(255, 191, 250, 244),
        canvasColor: Colors
            .white, // Color(0xFF90f7ec), //const Color.fromRGBO(255, 254, 229, 1),
        buttonColor: const Color(0xFFce9ffc),
        cardColor: Colors.white, //const Color(0xFF32ccbc),
        shadowColor: Colors.white60,
        //iconTheme:IconThemeData(color: Color.fromARGB(255, 148, 71, 155)) ,
        textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
              color: Color.fromARGB(255, 47, 78, 94),
            )),
        // scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* @override
  void initState() {
    
  }*/

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     /* appBar: AppBar(
        backgroundColor: const Color(0xFFD902EE),
      ),*/
      body: home_layout(),
    );
  }
}
