import 'package:flutter/material.dart';
import 'package:waddler/Chatbot.dart';
import 'package:waddler/sign_in.dart';


class SignUpChild extends StatefulWidget {
  @override
  _SignUpChildState createState() => _SignUpChildState();
}


class _SignUpChildState extends State<SignUpChild> {
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
                    Text("Sign Up Page"),
                    Text("Child's Information"),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter child's Name:",
                        labelText: "Child's Name",
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
                      decoration: InputDecoration(
                        hintText: "Enter child's Age:",
                        labelText: "Child's Age",
                        icon: Icon(Icons.child_care),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Child's gender",
                        labelText: "Child's gender",
                        icon: Icon(Icons.star),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter child's date of birth",
                        labelText: "Date of Birth",
                        icon: Icon(Icons.date_range),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Child's Blood Group",
                        labelText: "Blood Group",
                        icon: Icon(Icons.medical_services),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter the details';
                        }
                        return null;
                      },
                    ),

                    Container(
                      child: Column(
                        children: [
                          Checkbox(
                            value: this.firstbox,
                            onChanged: (bool? value){
                            },
                          ),
                          Text("I accept the terms and conditions of the application"),
                        ],
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text("SignUp"),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> CareCenterList()));
                        },
                      ),
                    ),
                    Text("Already Have an Account?"),
                    RaisedButton(
                      child: Text("Sign In"),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> SignIn()));
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


