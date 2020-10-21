import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyApp.dart';

class CreatePage extends StatefulWidget{
  @override
  SignupPage createState() => SignupPage();

}

class SignupPage extends State<CreatePage> {
  static TextEditingController email = new TextEditingController();
  static TextEditingController password = new TextEditingController();
  static TextEditingController confirmpassword = new TextEditingController();
  static TextEditingController instututename = new TextEditingController();
  static TextEditingController phoneno = new TextEditingController();
  static TextEditingController name = new TextEditingController();
  static TextEditingController age = new TextEditingController();
  static TextEditingController otp=new TextEditingController();
  static TextEditingController address=new TextEditingController();
  static TextEditingController transactionid=new TextEditingController();

  bool emailcheck;
  String uidemail;
  Future<void> addData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    Map<String,dynamic> data = {"name":name.text,"phoneno":phoneno.text,"age":age.text,"institution name":instututename.text,"email":email.text};
    CollectionReference collectionReference1 = Firestore.instance.collection('user info');
    collectionReference1.doc(uidemail).set(data).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Account Successfully Created!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => MyApp()));
    });

  }
  Future<bool> Otpcheck(String phoneno,BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: phoneno,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {

      },
      verificationFailed: (FirebaseAuthException exception){
      },
      codeSent: (String verificationid, [int forceResendingToken]) async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: new Text(
                  "Enter your OTP",
                ),
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: otp,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      String vcode = otp.text.trim();
                      AuthCredential credentials = PhoneAuthProvider
                          .getCredential(
                          verificationId: verificationid, smsCode: vcode);
                      UserCredential vuser = (await auth.signInWithCredential(
                          credentials));
                      if (vuser != null) {
                        Fluttertoast.showToast(
                            msg: "Verified!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: email.text, password: password.text);
                        uidemail=FirebaseAuth.instance.currentUser.uid.toString();
                        addData();

                        if(_value==1){
                          categoryone();
                        }
                        else if(_value==2){
                          categorytwo();
                        }
                        else{
                          categorythree();
                        }
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Enter a valid OTP",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Text("Verify OTP"),
                  ),
                ],
              );
            }
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  void categoryone(){
    Map<String,dynamic> data = {"name":name.text,"phoneno":phoneno.text,"age":age.text,"institution name":instututename.text,"email":email.text,
      "transactionid":"Null"};
    CollectionReference collectionReference1 = Firestore.instance.collection('category 1');
    collectionReference1.doc(uidemail).set(data);
  }

  void categorytwo(){
    Map<String,dynamic> data = {"name":name.text,"phoneno":phoneno.text,"age":age.text,"institution name":instututename.text,"email":email.text,
      "transactionid":"Null","address":address.text};
    CollectionReference collectionReference1 = Firestore.instance.collection('category 2');
    collectionReference1.doc(uidemail).set(data);
  }

  void categorythree(){
    Map<String,dynamic> data = {"name":name.text,"phoneno":phoneno.text,"age":age.text,"institution name":instututename.text,"email":email.text,
      "transactionid":"Null","address":address.text};
    CollectionReference collectionReference1 = Firestore.instance.collection('category 3');
    collectionReference1.doc(uidemail).set(data);
  }
  var formkey= GlobalKey<FormState>();
  int _value=0;
  _openMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: new Container(


        padding: EdgeInsets.all(40.0),

        child:Form(
            key:formkey,
            child:
            new SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //shrinkWrap: true,
                children: <Widget> [
                  Text('Create\nAccount!'
                    , style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontStyle: FontStyle.normal,

                    ),),
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormField(
                    controller:name,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter your Name";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller:age,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Enter your Age';
                      }

                    },
                    decoration: InputDecoration(
                        hintText: 'Age',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Enter your Institution Name';
                      }

                    },
                    controller:instututename,
                    decoration: InputDecoration(
                        hintText: 'Institute Name/Organization Name',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.length!=10){
                        return 'Enter a valid phone number';
                      }

                    },
                    controller:phoneno,
                    decoration: InputDecoration(
                        hintText: 'Phone no',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Category',
                        style:TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                     SizedBox(
                       width: 10.0,
                     ),
                     InkWell(
                       onTap: (){
                         showDialog(
                             context:context,
                             builder: (BuildContext context) {
                               // return object of type Dialog
                               return SingleChildScrollView(
                                 child: AlertDialog(

                                   content: new Text("* It is mandatory for everyone to chose one of the above mentioned categories.\n\n* After choosing, you will be redirected to payment processing page.\n\n* Once the transaction is successful,fill the transaction ID to continue the process.",
                                     style: TextStyle(
                                       fontSize: 20.0,
                                       fontWeight: FontWeight.bold,
                                     ),),
                                   actions: <Widget>[
                                     // usually buttons at the bottom of the dialog
                                     new FlatButton(
                                       child: new Text("ok"),
                                       onPressed: () {

                                         Navigator.of(context).pop();

                                       },

                                     ),

                                   ],
                                 ),
                               );
                             }
                         );
                       },
                       child: Icon(
                         Icons.info,
                         color: Colors.black,
                       ),
                     ),

                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButton(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Select the Category"),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text("Category 1 - Rs.100/- \n  (E - Certificate)"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Category 2 - Rs.350/- \n  (E - Certificate + T-shirt)"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                            child: Text("Category 3 - Rs.500/- \n  (E - Certificate + T-shirt + Medal)"),
                            value: 3
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: address,
                    validator: (String value) {
                    if(_value!=1) {
                      if (value.isEmpty) {
                        return 'Enter Your Residential Address';
                      }
                    }
                    },
                    decoration: InputDecoration(
                        hintText: 'Residential Address',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Enter your Email Id';
                      }

                    },
                    controller:email,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    obscureText: true,

                    validator: (String value){
                      if(value.length<6){
                        return 'password should contain atleast 6 character';
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (String value){
                      if(password.text!=confirmpassword.text){
                        return 'Enter the correct password';
                      }

                    },
                    controller: confirmpassword,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  RaisedButton(onPressed:()async{

                    Fluttertoast.showToast(
                        msg: "Please wait",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.yellow,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    if(formkey.currentState.validate()) {
                      if(_value!=0) {
                        try {

                          DocumentSnapshot variable1 = await Firestore.instance
                              .collection('ridedata').doc(phoneno.text).get();
                          DocumentSnapshot variable2 = await Firestore.instance
                              .collection('rundata').doc(phoneno.text).get();
                          await FirebaseAuth.instance
                              .fetchSignInMethodsForEmail(
                              email.text).then((value) =>
                          {
                            if(value.length > 0){
                              emailcheck = false,

                            }
                            else
                              {
                                emailcheck = true,

                              }
                          });


                          if (emailcheck == true && !variable1.exists &&
                              !variable2.exists) {

                            Otpcheck("+91" + phoneno.text, context);



                          }
                          else {

                            Fluttertoast.showToast(
                                msg: "This phone number (or) email is already registered!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }
                        catch (e) {
                          Fluttertoast.showToast(
                              msg: "enter a valid email'id",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Please select a category",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }
                    },

                    color: Colors.greenAccent[200],


                    child: Text('Sign up ->'),


                  ),



                ]
              ),

            )
        )
    )
    );
  }

}