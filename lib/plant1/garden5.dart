
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloworld/plant1/addplant.dart';

import 'package:helloworld/plant1/calendar2.dart';

import 'package:helloworld/plant1/menu.dart';


class Garden5 extends StatefulWidget {
  @override
  _Garden5State createState() => _Garden5State();
}

class _Garden5State extends State<Garden5> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("planticon").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> querysnapshot) {
          if (querysnapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.greenAccent,
            ));
          } else {
           
            return Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/backgarden.jpg'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: IconButton(
                  color: Color(0xff424C47),
                  icon: Icon(Icons.arrow_back),
                  iconSize: 50,
                  onPressed: () {
                    _backtomenu();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 70, 0, 0),
                child: Text(
                  "Plan Your",
                  style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 45.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 120, 0, 0),
                child: Text(
                  "Garden!!",
                  style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 45.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,180,0,0),
                child: Container(
                  height: 410,
                  
                  width: MediaQuery.of(context).size.width,
                  
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: querysnapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                         var _counter = querysnapshot.data.docs[index].data()['day'];   
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 55),
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    iconSize: 20,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('ต้องการที่จะลบต้นไม้?',style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 20.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),),
                                              content: Text('โปรดยืนยัน',style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 17.0,
                    fontFamily: "Roboto",
                   
                  ),),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () {
                                                    querysnapshot.data.docs[index]
                                                        .reference
                                                        .delete()
                                                        .then((value) {
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  child: Text(
                                                    "ลบ",
                                                    style: TextStyle(
                                                        color: Color(0xffFD7778), fontSize: 15.0,
                    fontFamily: "Roboto",),
                                                        
                                                        
                                                        
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "ไม่ลบ",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffFD7778), fontSize: 15.0,
                    fontFamily: "Roboto",),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    })
                              ],
                            ),
                            Container(
                              height: 49,
                              width: 49,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(querysnapshot
                                        .data.docs[index]
                                        .data()['image'])),
                              ),
                            ),
                            Text(
                                "${querysnapshot.data.docs[index].data()['name']}",
                                style: TextStyle(
                                    color: Color(0xff623B28),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0)),

                                    
                                    
                          ],
                        );
                        
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 580, 0, 0),
                child: IconButton(
                  icon: Image.asset("image/schedule.png"),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Calendar2()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(230, 600, 0, 0),
                child: IconButton(
                  icon: Image.asset("image/add1.png"),
                  iconSize: 70,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Addplant()));
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 690, 0, 0),
                child: Text(
                  "ตารางรดน้ำ",
                  style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 20.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(230, 690, 0, 0),
                child: Text(
                  "เพิ่มต้นไม้",
                  style: TextStyle(
                    color: Color(0xff4E514A),
                    fontSize: 20.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]);
          }
        },
      ),
    );
  }

  void _backtomenu() async {
    final user = _auth.currentUser;

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Menu(user: user);
    }));
  }
// }
}
