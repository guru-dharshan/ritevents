import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ActivityPage.dart';

class MyApp extends StatefulWidget {
  @override
  SignPage createState() => SignPage();

}

class SignPage extends State<MyApp>{
  static bool _isLoggedIn = false;
  static TextEditingController email = new TextEditingController();
  static TextEditingController password = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
            body: new Container(
                color: Colors.white,
                // padding: EdgeInsets.fromLTRB(15.0, 90.0, 15.0, 0),
                child: _isLoggedIn
                    ?Center(
                  child: ActivityPage(),
                )


                    :new Container(padding: EdgeInsets.all(20.0),

                    child:Center( child: new ListView(
                      shrinkWrap: true,
                      children: <Widget> [
                        Image(
                          image: AssetImage(
                            'assets/images/ritblack.jpg',
                          ),
                          height: 120.0,
                          width: 300.0,
                        ),
                        SizedBox(height: 10.0,),
                        Image(
                          image: AssetImage(
                            'assets/images/vm.png',
                          ),
                          width: 300.0,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        TextFormField(
                          controller:email,
                          decoration: InputDecoration(
                              icon: Icon(Icons.account_circle,color:Colors.black87),
                              hintText: "Email id",
                              hintStyle: TextStyle(
                                color: Colors.black45,
                              )

                          ),
                        ),

                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          obscureText: true,

                          controller:password,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock,color:Colors.black87),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black45,
                              )

                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: RaisedButton(onPressed:()async{
                              try{
                                UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                                if(user!=null) {
                                  print("asdfsadfsdaf"+user.toString());
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => ActivityPage()));
                                }}catch(e){
                                Fluttertoast.showToast(
                                    msg: "please enter a valid user credentials",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                print(e.toString());
                              }
                            },
                              color: Colors.greenAccent[200],
                              child: Text('Log in'),
                            )
                        ),

                        SizedBox(
                          height: 40.0,
                        ),

                      ],

                    ),

                    )
                )
            )
        )
    );


  }

}