import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Magic 8 Ball'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  final rnd = Random();
  String text = '';
  List<double> p = [];

  //LIST OF ANSWERS
  List<String> listAnswers = [
    'Yes',
    'No',
    'Maybe',
    'Dont do it i think',
    'Up to you',
  ];

  //INITIALIZE P for events
  @override
  void initState() {
    var pInit = 1 / listAnswers.length;
    for (int i = 0; i < listAnswers.length; i++) {
      if (i == 0) {
        p.add(double.parse(pInit.toStringAsFixed(2)));
      } else if (i > 0) {
        p.add(double.parse(pInit.toStringAsFixed(2)) +
            double.parse((p[i - 1]).toStringAsFixed(2)));
      }
    }
    print(p);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              height: 56.0,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),

            //FUNCTION FOR GENERATING ANSWER
            InkWell(
              onTap: () {
                //PROBABILITTY OF EVENT
                var randvalue = (rnd.nextDouble() * (1 - 0) + 0);
                // print(randvalue);

                //FIND INSIDE THE INTERVAL
                for (int k = 0; k < listAnswers.length; k++) {
                  if (k == 0) {
                    if (randvalue > 0 && randvalue < p[k]) {
                      setState(() {
                        text = listAnswers[k];
                      });
                    }
                  } else if (k == listAnswers.length - 1) {
                    if (randvalue > p[k - 1] && randvalue < p[k]) {
                      setState(() {
                        text = listAnswers[k];
                      });
                    }
                  } else {
                    if (randvalue > p[k - 1] && randvalue < p[k]) {
                      setState(() {
                        text = listAnswers[k];
                      });
                    }
                  }
                }
              },
              child: Container(
                height: 60.0,
                width: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black),
                child: const Center(
                  child: Text(
                    'ANSWER',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45.0,
            ),
            Container(
              height: 80.0,
              width: 190.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
