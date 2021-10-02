import 'package:flutter/material.dart';
import 'package:waddler/CareCenterList.dart';
import 'package:waddler/sign_up_parent.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final keys = GlobalKey<FormState> ();
  bool firstbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waddler"),
      ),
      body: Container(
        child: Form(
          key: keys,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Sign In Page"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        icon: Icon(Icons.person),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        icon: Icon(Icons.lock),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),


                    Container(
                      child: RaisedButton(
                        child: Text("SignIn"),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> CareCenterList()));
                        },
                      ),
                    ),
                    Text("Don't Have an Account? Sign up Now!"),
                    RaisedButton(
                      child: Text("SignUp"),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpParent()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


