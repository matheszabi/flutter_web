import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("hh:mm:ss a").format(time);
  }
  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMM yyyy").format(date);
  }

  @override
  void initState() {
    super.initState();
    // time
    timeText = formatCurrentLiveTime(DateTime.now());
    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTime();
    });

  }

  getCurrentLiveTime()
  {
      final DateTime timeNow = DateTime.now();
      final String liveTime = formatCurrentLiveTime(timeNow);
      final String liveDate = formatCurrentDate(timeNow);

      if(mounted){
        setState(() {
          timeText = liveTime;
          dateText = liveDate;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pinkAccent,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0,1],
              tileMode: TileMode.clamp,
            )
          ),
        ),
        title: const Text(
            "Welcome Home",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 3,
                    color: Colors.yellowAccent
                ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
              timeText + "\n" + dateText,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.cyanAccent,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold
                  )
              ),
            ),
            // user activae block account button ui
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //activate
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                    label: Text(
                      "Activate Users \nAccount" .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        color:Colors.white,
                        letterSpacing: 3
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      primary: Colors. deepPurpleAccent
                    ),
                    onPressed: () {  },
                  ),
                  const SizedBox(width: 20,),
                  //block
                  ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                    label: Text(
                      "Block User\nAccount" .toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16,
                          color:Colors.white,
                          letterSpacing: 3
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        primary: Colors. pinkAccent
                    ),
                    onPressed: () {  },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
