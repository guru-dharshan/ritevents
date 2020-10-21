
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'Home.dart';
import 'leaderboardride.dart';
import 'leaderboardrun.dart';

class ActivityPage extends StatefulWidget {

  @override
  ActivityPageState createState() => ActivityPageState();

}

class ActivityPageState extends State<ActivityPage>{
  
  static BuildContext _context;
  DateTime dateTime=DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  static String _dropDownValue;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String runname,runphone;
  String ridename,ridephone;





  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  static TextEditingController nameController = new TextEditingController();
  static TextEditingController dateController = new TextEditingController();
  static TextEditingController starttimeController = new TextEditingController();
  static TextEditingController distanceController = new TextEditingController();
  static TextEditingController timeControllerhrs = new TextEditingController();
  static TextEditingController timeControllersec = new TextEditingController();
  static TextEditingController timeControllermins = new TextEditingController();
  static TextEditingController linkController = new TextEditingController();
  static TextEditingController phoneController = new TextEditingController();
  TextEditingController controlle;
  TextEditingController ridenamecont;
  TextEditingController ridephonecont;
  TextEditingController controlevent;
  ////run
  static TextEditingController runnameController = new TextEditingController();
  static TextEditingController rundateController = new TextEditingController();
  static TextEditingController runstarttimeController = new TextEditingController();
  static TextEditingController rundistanceController = new TextEditingController();
  static TextEditingController runtimeControllerhrs = new TextEditingController();
  static TextEditingController runtimeControllermins = new TextEditingController();
  static TextEditingController runtimeControllersec = new TextEditingController();
  static TextEditingController runlinkController = new TextEditingController();
  static TextEditingController runphoneController;

  Future<Null> _selectTime(BuildContext context) async {

    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot variable1 = await Firestore.instance.collection('user info').doc(firebaseUser.uid).get();
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
    if(picked != null && picked != time){
      setState(() {
        time = picked;
      });
    }
  }


  _signOut() async {
    await _firebaseAuth.signOut();
  }


    addrideData() async{
    Map<String,dynamic> data = {"name":ridenamecont.text,"date":"${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')}","startime":time.toString(),"distance":double.parse(distanceController.text)
      ,"timehour":int.parse(timeControllerhrs.text),"timemins":int.parse(timeControllermins.text),"timesec":int.parse(timeControllersec.text),"link":linkController.text,"phoneno":ridephonecont.text,"user id":FirebaseAuth.instance.currentUser.uid};
    CollectionReference collectionReference = Firestore.instance.collection('ridedata');
    DocumentSnapshot variable = await Firestore.instance.collection('ridedata').doc(ridephonecont.text).get();
    if(controlevent.text=="on") {
      if (variable.exists) {
        double dis = variable['distance'];
        int utimehour,utimesec,utimemin;
        String link = variable['link'];
        int timehour = variable['timehour'];
        int timemin = variable['timemins'];
        int timesec = variable['timesec'];
        utimehour=timehour+int.parse(timeControllerhrs.text);
        utimemin=timemin+int.parse(timeControllermins.text);
        utimesec=timesec+int.parse(timeControllersec.text);
        dis=dis+double.parse(distanceController.text);
        link=link+"--//--"+linkController.text;
        Map<String,dynamic> updatedata={
          "link":link,"distance":dis,"timehour":utimehour,"timemins":utimemin,"timesec":utimesec,
        };
        collectionReference.doc(ridephonecont.text).update(updatedata);
        Fluttertoast.showToast(
            msg: "your data is updated!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Fluttertoast.showToast(
            msg: "Thanks for your Participation",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );


      }
      else {
        collectionReference.doc(ridephonecont.text
        ).set(data);
        Fluttertoast.showToast(
            msg: "Your data is successfully submitted!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Fluttertoast.showToast(
            msg: "Thanks for your Participation",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    else if(controlevent.text=="soon"){
      Fluttertoast.showToast(
          msg: "Event will start soon",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Event Over",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  addrunData() async{
    Map<String,dynamic> data = {"name":controlle.text,"date":"${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')}","startime":time.toString(),"distance":double.parse(rundistanceController.text)
      ,"timehour":int.parse(runtimeControllerhrs.text),"timemins":int.parse(runtimeControllermins.text),"timesec":int.parse(runtimeControllersec.text),"link":runlinkController.text,"phoneno":runphoneController.text,"user id":FirebaseAuth.instance.currentUser.uid};
    CollectionReference collectionReference1 = Firestore.instance.collection('rundata');
    DocumentSnapshot variable1 = await Firestore.instance.collection('rundata').doc(runphoneController.text).get();
    if(controlevent.text=="on") {
      if (variable1.exists) {
        double dis = variable1['distance'];
        int utimehour,utimesec,utimemin;
        String link = variable1['link'];
        int timehour = variable1['timehour'];
        int timemin = variable1['timemins'];
        int timesec = variable1['timesec'];
        utimehour=timehour+int.parse(runtimeControllerhrs.text);
        utimemin=timemin+int.parse(runtimeControllermins.text);
        utimesec=timesec+int.parse(runtimeControllersec.text);
        dis=dis+double.parse(rundistanceController.text);
        link=link+"--//--"+runlinkController.text;
        Map<String,dynamic> updatedata={
           "link":link,"distance":dis,"timehour":utimehour,"timemins":utimemin,"timesec":utimesec,
        };
        collectionReference1.doc(runphoneController.text).update(updatedata);
        Fluttertoast.showToast(
            msg: "your data is updated!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Fluttertoast.showToast(
            msg: "Thanks for your Participation",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else {
        collectionReference1.doc(runphoneController.text
        ).set(data);
        Fluttertoast.showToast(
            msg: "Your Data is successfully submitted!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Fluttertoast.showToast(
            msg: "Thanks for your Participation",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    else if(controlevent.text=="soon"){
      Fluttertoast.showToast(
          msg: "Event will start soon",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      Fluttertoast.showToast(
          msg: "Event Over",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  static var firebaseUser = FirebaseAuth.instance.currentUser;
  var formkey= GlobalKey<FormState>();
  var formkeyride= GlobalKey<FormState>();
  var document =  Firestore.instance.collection('user info').document(firebaseUser.uid);

  void showdialog(){
    showDialog(
        context: ActivityPageState._context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Instructions for participants"),
            content: new Text("* Create your account in strava app.\n\n* Make sure you track your run /ride using strava app. \n\n* Upload the link each day in this app. \n\n Track your positions in the leader board.",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();

                },

              ),

            ],
          );
        }
    );
  }
  int i=0;
  @override
  Widget build(BuildContext context) {
    if(i==0) {
      Future.delayed(Duration.zero, () => showdialog());
      i=i+1;
    }
    _context=context;

    var myFormat = DateFormat('d-MM-yyyy');
    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(

          title: Text(
            'RIT CHALLENGE 2020',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              print("click");
              showDialog(
              context: ActivityPageState._context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Are you sure"),
                  content: new Text("You want to Logout?",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Logout"),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) => Home()));


                      },

                    ),
                    new FlatButton(
                      child: new Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
              );
            },
            child: Icon(
              Icons.subdirectory_arrow_left,
              color: Colors.black,
              size: 26.0,
            ),
          )
      ),
          ],
          backgroundColor: Colors.white,
          bottom: TabBar(tabs: [
            Text(
              'RUN/WALK',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            Text(
              'RIDE',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
          ),
        ),

      body: TabBarView(

        children: [

          Form(
            key:formkey,
            //padding: EdgeInsets.fromLTRB(15.0, 90.0, 15.0, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                    showdialog();
                    },
                    child: new Text(
                      'How to participate?',
                      style: TextStyle(
                        color: Colors.redAccent,

                      ),),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text('Name',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection('controlevent').document("controlevent").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }

                        var userDocument = snapshot.data;
                        controlevent=TextEditingController(text: userDocument["check"]);
                        return new Text("");
                      }
                  ),



               StreamBuilder(
                  stream: Firestore.instance.collection('user info').document(FirebaseAuth.instance.currentUser.uid).snapshots(),
                  builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                  return new Text("Loading");
                  }

                  var userDocument = snapshot.data;
                  controlle=TextEditingController(text:userDocument["name"]);
                  return new Text(userDocument["name"],
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                  );
                  }
                  ),




                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[

                      InkWell(
                        onTap: () {
                          showDatePicker(
                              context: ActivityPageState._context,
                              initialDate: dateTime == null ? DateTime.now() : dateTime,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2021)
                          ).then((date) {
                            setState(() {
                              dateTime = date;
                            });
                          });
                        },
                        child: new Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                          ),),
                      ),

                      InkWell(
                        onTap: () {
//
                          _selectTime(ActivityPageState._context);
                        },

                        child: new Text("Start Time",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,

                          ),),
                      ),


                    ],

                  ),
                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Text(dateTime == null ? 'Select a Date' : myFormat.format(dateTime),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),),

                      Text(time == null ? 'Select Time' : '${time.format(context)}',style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),),

                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Distance(km)',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter the Distance Covered";
                      }
                    },
                    controller:rundistanceController,
                    style:
                    TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "Eg:2",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        )

                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Time Taken',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          validator: (String value){
                            if(value.isEmpty){
                              return "Enter 0 if time taken is less than a hour";

                            }
                          },
                          controller: runtimeControllerhrs,
                          keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Hours",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      new Flexible(
                        child: new TextFormField(
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Minutes";
                              }
                            },
                            controller: runtimeControllermins,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Minutes",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      new Flexible(
                        child: new TextFormField(
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Seconds";
                              }
                            },
                            controller: runtimeControllersec,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Seconds",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                    ],
                  ),





                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Activity Link',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter Starva Link";
                      }
                    },
                    controller:runlinkController,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "Strava link",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        )

                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Phone no',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection('user info').document(FirebaseAuth.instance.currentUser.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        runphoneController=TextEditingController(text:userDocument["phoneno"]);

                        return new Text(userDocument["phoneno"],
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        );
                      }
                  ),

                  SizedBox(
                    height: 50.0,
                  ),
                  RaisedButton(onPressed: (

                      ){
                    showDialog(
                      context: ActivityPageState._context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Are You Sure?"),

                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Submit"),
                              onPressed: () {
                            if(formkey.currentState.validate()) {
                              addrunData();
                            }
                                Navigator.of(context).pop();
                              },

                            ),
                            new FlatButton(
                              child:new Text("Cancel"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                    child: Text('Submit',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,

                    ),
                    ),
                    color: Colors.blue,
                  ),
                  RaisedButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => listviewrun()
                      ));



                  },
                    child: Text('Leader Board',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,

                    ),
                    ),
                    color: Colors.deepOrangeAccent,
                  ),



                ],
              ),
            ),
          ),
          Form(
            key:formkeyride,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                     showdialog();
                    },
                    child: new Text(
                      'How to participate?',
                      style: TextStyle(
                        color: Colors.redAccent,

                      ),),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text('Name',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection('user info').document(FirebaseAuth.instance.currentUser.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        ridenamecont=new TextEditingController(text: userDocument["name"]);
                        return new Text(userDocument["name"],
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,


                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          showDatePicker(
                              context: ActivityPageState._context,
                              initialDate: dateTime == null ? DateTime.now() : dateTime,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2021)
                          ).then((date) {
                            setState(() {
                              dateTime = date;
                            });
                          });
                        },
                        child: new Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                          ),),
                      ),
                      InkWell(
                        onTap: () {
                          Future<TimeOfDay> _selectedTime = showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: ActivityPageState._context,
                          );
                          _selectTime(ActivityPageState._context);
                        },

                        child: new Text("Start Time",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,

                          ),),
                      ),


                    ],

                  ),
                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(dateTime == null ? 'Select a Date' : myFormat.format(dateTime),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),),

                      Text(time == null ? 'Select Time' : '${time.format(context)}',style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),),

                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Distance(km)',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter the Distance Covered";
                      }
                    },
                    controller:distanceController,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "Eg:2",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        )

                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Time Taken',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter 0 if time taken is less than a hour";

                              }
                            },
                            controller: timeControllerhrs,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Hours",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      new Flexible(
                        child: new TextFormField(
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Minutes";
                              }
                            },
                            controller: timeControllermins,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Minutes",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      new Flexible(
                        child: new TextFormField(
                            validator: (String value){
                              if(value.isEmpty){
                                return "Enter Seconds";
                              }
                            },
                            controller: timeControllersec,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Seconds",
                                contentPadding: EdgeInsets.all(10)
                            )
                        ),
                      ),
                    ],
                  ),



                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Activity Link',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return "Enter Starva Link";
                      }
                    },
                    controller:linkController,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        hintText: "Strava link",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        )

                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Phone no',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,

                    ),
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection('user info').document(FirebaseAuth.instance.currentUser.uid).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        ridephonecont=new TextEditingController(text: userDocument["phoneno"]);

                        return new Text(userDocument["phoneno"],
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                          ),
                        );
                      }

                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  RaisedButton(onPressed: (){
                    showDialog(
                      context: ActivityPageState._context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Are You Sure?"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Submit"),
                              onPressed: () {
                                if(formkeyride.currentState.validate()) {
                                  addrideData();
                                }


                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child:new Text("Cancel"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                    child: Text('Submit',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,

                    ),
                    ),
                    color: Colors.blue,
                  ),
                  RaisedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=> listview()));
                  },
                    child: Text('Leader Board',style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,

                    ),
                    ),
                    color: Colors.deepOrangeAccent,
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }


}