// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'dart:async';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class TimePage extends StatefulWidget {
  const TimePage({Key? key}) : super(key: key);

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  late int H;
  late int h;
  late int m;
  late int s;
  // bool status = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    H = DateTime.now().hour;
    m = DateTime.now().minute;
    s = DateTime.now().second;
    h = (DateTime.now().hour > 12)
        ? DateTime.now().hour - 12
        : (DateTime.now().hour == 0)
            ? 12
            : DateTime.now().hour;

    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
  }

  getTime() {
    setState(() {
      H = DateTime.now().hour;
      m = DateTime.now().minute;
      s = DateTime.now().second;
      h = (DateTime.now().hour > 12)
          ? DateTime.now().hour - 12
          : (DateTime.now().hour == 0)
              ? 12
              : DateTime.now().hour;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // status
          //     ? Expanded(
          //         flex: 3,
          //         child: Row(
          //           children: [
          //             Expanded(
          //               flex: 1,
          //               child: Text(
          //                   '${(H < 10) ? "0$H" : H}:${(m < 10) ? "0$m" : m}:${(s < 10) ? "0$s" : s}',
          //                   style: const TextStyle(
          //                     fontSize: 32.0,
          //                   )),
          //             ),
          //             // Expanded(
          //             //   flex: 1,
          //             //   child: Text(
          //             //     (H >= 12) ? "P.M" : "A.M",
          //             //     style: const TextStyle(fontSize: 25),
          //             //   ),
          //             // )
          //           ],
          //         ))
          //     : Expanded(
          //         flex: 3,
          //         child: Row(
          //           children: [
          //             Expanded(
          //               flex: 1,
          //               child: Text(
          //                 '${(h < 10) ? "0$h" : h}:${(m < 10) ? "0$m" : m}:${(s < 10) ? "0$s" : s}',
          //                 style: const TextStyle(
          //                   fontSize: 32.0,
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 1,
          //               child: Text(
          //                 (H >= 12) ? "P.M" : "A.M",
          //                 style: const TextStyle(fontSize: 15),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          Visibility(
            visible: isVisible,
            child: DigitalClock(
              digitAnimationStyle: Curves.elasticOut,
              is24HourTimeFormat: true,
              areaDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              hourMinuteDigitTextStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 50,
              ),
              amPmDigitTextStyle: const TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
            visible: !isVisible,
            child: DigitalClock(
              digitAnimationStyle: Curves.elasticOut,
              is24HourTimeFormat: false,
              areaDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              hourMinuteDigitTextStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 50,
              ),
              amPmDigitTextStyle: const TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(
            height: 25,
          ),
          CustomSwitch(
            activeColor: Colors.green,
            value: isVisible,
            onChanged: (v) {
              // print("V : $v");
              setState(() {
                isVisible = !isVisible;
                // status = v;
                // Fluttertoast.showToast(msg: '$status');
              });
            },
          ),
        ],
      ),
    );
  }
}
