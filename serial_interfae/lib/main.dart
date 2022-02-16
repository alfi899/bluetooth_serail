import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import './MainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DBref = FirebaseDatabase.instance.ref();
  int ledStatus = 0;
  bool isLoading = false;

  getLEDStatus() async {
  await DBref.child("LED_STATUS").get().then((DataSnapshot? snapshot) {
    print("----------------");
    print(snapshot!.value);
    ledStatus = snapshot.value as int;
  });
  /*await DBref.child("LED_STATUS").once().then((event) {
      final dataSnapshot = event.snapshot;
      ledStatus = ;
      //print(ledStatus.toString());
    });*/

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    getLEDStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IoT Example"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            buttonPressed();
          },
          child: Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(ledStatus == 0 ? "ON" : "OFF"),
            )
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    ledStatus == 0 
      ? DBref.child("LED_STATUS").set(1)
      : DBref.child("LED_STATUS").set(0);
    if (ledStatus == 0) {
      setState(() {
        ledStatus = 1;
      });
    } else {
      setState(() {
        ledStatus = 0;
      });
    }
  }
}