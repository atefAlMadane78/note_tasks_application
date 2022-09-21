import 'dart:ffi';

import 'package:flutter/material.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool ispswrd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 8,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: userController,
                  autocorrect: true,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.words,
                  key: const ValueKey('username'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 4) {
                      return "Please enter at least 4 character";
                    }
                    return null;
                  },
                  // onSaved: (val) => _username = val!,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextFormField(
                  controller: passwordController,
                  key: const ValueKey('password'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  // onSaved: (val) => _password = val!,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                 //   prefix:const Icon(Icons.lock),
                    labelText: 'Enter password',
                    suffixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                ispswrd =!ispswrd;
                              });
                            },
                            icon: ispswrd ?const  Icon(Icons.visibility) :const Icon(Icons.visibility_off))),
                  ),
                  obscureText:ispswrd ? true : false,
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child:const Text('Register'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print(userController);
                      print(passwordController);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
