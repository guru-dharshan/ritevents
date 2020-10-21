import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class listview extends StatefulWidget {
  @override
  _listviewState createState() => _listviewState();
}

class _listviewState extends State<listview> {
  int i=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF174273),
        title: Text('LEADERBOARD',
          style: TextStyle(
              color: Colors.white
          ),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("click");
                  showDialog(
                      context:context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(

                          content: new Text("This is not the Final Leader Board.\n\n False data will not be considered.",
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
                        );
                      }
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("ridedata").orderBy("distance",descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: Text("No Data Available"),
            );
          }
          return ListView(
            children: snapshot.data.documents.map((document){
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Color(0xFF04558F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            document["name"],

                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //SizedBox(width: 20.0,),
                                Text(

                                  'Distance: '+document["distance"].toString()+' KM',
                                  style: TextStyle(
                                      color: Colors.white,

                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 16.0,),
                                Text(
                                  'Time taken: '+document["timehour"].toString()+"H "+document["timemins"].toString()+"M "+document["timesec"].toString()+"S ",//C tryyyyyyyyyyyyyyy seri na panraaa ............... okii semma d baadu photoooo
                                  style: TextStyle(
                                      color: Colors.white,

                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 20.0,),
                                Text(
                                  'Rank: '+'${i++}',//C
                                  style: TextStyle(
                                      color: Colors.white,

                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(width: 20.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },

      ),
    );
  }
}


class leader extends StatefulWidget {
  @override
  _leaderState createState() => _leaderState();
}

class _leaderState extends State<leader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
