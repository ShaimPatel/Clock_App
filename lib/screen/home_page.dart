import 'package:clock_app/screen/signin_page.dart';
import 'package:clock_app/screen/time_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool status = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        backgroundColor: HexColor('#013334'),
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.yMMMEd().format(DateTime.now()),
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: FlutterAnalogClock(
                  dateTime: DateTime.now(),
                  dialPlateColor: const Color.fromARGB(255, 238, 234, 6),
                  hourHandColor: Colors.white,
                  minuteHandColor: Colors.black,
                  secondHandColor: Colors.black,
                  numberColor: Colors.black,
                  borderColor: Colors.black,
                  tickColor: Colors.white,
                  centerPointColor: Colors.black,
                  showBorder: true,
                  showTicks: true,
                  showMinuteHand: true,
                  showSecondHand: true,
                  showNumber: true,
                  borderWidth: 4.0,
                  hourNumberScale: 1.0,
                  hourNumbers: const [
                    'I',
                    'II',
                    'III',
                    'IV',
                    'V',
                    'VI',
                    'VII',
                    'VIII',
                    'IX',
                    'X',
                    'XI',
                    'XII'
                  ],
                  isLive: true,
                  width: 200.0,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: TimePage(),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninPage()));
  }
}
