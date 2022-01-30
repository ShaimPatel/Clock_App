// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'dart:async';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  bool status = true;

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
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CustomSwitch(
              activeColor: Colors.green,
              value: status,
              onChanged: (v) {
                // print("V : $v");
                setState(() {
                  status = v;
                  // Fluttertoast.showToast(msg: '$status');
                });
              },
            ),
          ),
          const SizedBox(width: 60),
          status
              ? Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                            '${(H < 10) ? "0$H" : H}:${(m < 10) ? "0$m" : m}:${(s < 10) ? "0$s" : s}',
                            style: const TextStyle(
                              fontSize: 25.0,
                            )),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     (H >= 12) ? "P.M" : "A.M",
                      //     style: const TextStyle(fontSize: 25),
                      //   ),
                      // )
                    ],
                  ))
              : Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${(h < 10) ? "0$h" : h}:${(m < 10) ? "0$m" : m}:${(s < 10) ? "0$s" : s}',
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (H >= 12) ? "P.M" : "A.M",
                          style: const TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
