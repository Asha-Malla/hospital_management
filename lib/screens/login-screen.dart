import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hospital_management/homepage.dart';
import 'package:hospital_management/pallete.dart';
import 'package:hospital_management/screens/screens.dart';
import 'package:hospital_management/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  var _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/login_bg.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Flexible(
                        child: Center(
                          child: Text(
                            'HOSPITAL MANAGEMENT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Form(
                        key: _formkey,
                        child: Container(
                          margin: EdgeInsets.all(35),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.emailAddress,
                                validator: (item) {
                                  return item.contains("@")
                                      ? null
                                      : "Enter valid Email";
                                },
                                onChanged: (item) {
                                  setState(() {
                                    _email = item;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                validator: (item) {
                                  print("pasword!!!!!!!");
                                  return item.length >= 6
                                      ? null
                                      : "Password must be 6 characters";
                                },
                                onChanged: (item) {
                                  setState(() {
                                    _password = item;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  fillColor: Colors.white30,
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.indigo[500],
                                    //elevation: 7,
                                    //shadowColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "            LOGIN            ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password',
                            style: kBodyText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateNewAccount(),
                            ),
                          );
                        },
                        child: Container(
                          child: Text(
                            'Create New Account',
                            style: kBodyText,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: kWhite),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        )
      ],
    );
  }

  void login() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Homepage()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    }
  }
}
