import 'package:clock_app/screen/signin_page.dart';
import 'package:clock_app/screen/time_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
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
          Expanded(
            flex: 1,
            child: FlutterAnalogClock(
              dateTime: DateTime.now(),
              dialPlateColor: const Color.fromARGB(255, 207, 196, 196),
              hourHandColor: Colors.white,
              minuteHandColor: Colors.black,
              secondHandColor: Colors.black,
              numberColor: Colors.black,
              borderColor: Colors.black,
              tickColor: Colors.black,
              centerPointColor: Colors.black,
              showBorder: true,
              showTicks: true,
              showMinuteHand: true,
              showSecondHand: true,
              showNumber: true,
              borderWidth: 4.0,
              hourNumberScale: 1.0,
              hourNumbers: const [
                '1',
                '2',
                '3',
                '4',
                '5',
                '6',
                '7',
                '8',
                '9',
                '10',
                '11',
                '12'
              ],
              isLive: true,
              width: 200.0,
              height: 200.0,
              decoration: const BoxDecoration(),
            ),
          ),
          const Expanded(flex: 1, child: TimePage()),
          Flexible(
            flex: 1,
            child: Text(
              DateFormat.yMMMEd().format(DateTime.now()),
              style: const TextStyle(fontSize: 24.0),
            ),
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
