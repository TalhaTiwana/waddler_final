import 'package:flutter/material.dart';
import 'package:waddler/sign_in.dart';
import 'package:waddler/sign_up_child.dart';


class SignUpParent extends StatefulWidget {
  @override
  _SignUpParentState createState() => _SignUpParentState();
}

class _SignUpParentState extends State<SignUpParent> {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Sign Up Page"),
                Text("Parent's Information"),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter father's Name:",
                    labelText: "Father's Name",
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
                    hintText: "Enter mother's Name:",
                    labelText: "Mother's Name",
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
                    hintText: "Enter phone number",
                    labelText: "Phone number",
                    icon: Icon(Icons.phone),
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
                    hintText: "Enter father's CNIC:",
                    labelText: "Father's CNIC",
                    icon: Icon(Icons.credit_card_sharp),
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
                    hintText: "Enter mother's CNIC",
                    labelText: "Mother's CNIC",
                    icon: Icon(Icons.credit_card_sharp),
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
                    hintText: "Enter Home Address",
                    labelText: "Home Address",
                    icon: Icon(Icons.location_on_outlined),
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
                    hintText: "Enter Official Address",
                    labelText: "Official Address",
                    icon: Icon(Icons.location_on_outlined),
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
                    hintText: "Enter Email",
                    labelText: "Email",
                    icon: Icon(Icons.email_sharp),
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
                    hintText: "Enter Password:",
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
                    child: Text("Continue"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpChild()));
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
        ),
      ),

    );
  }
}

