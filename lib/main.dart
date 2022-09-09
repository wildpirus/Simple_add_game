import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension RandomInt on int {
  static int generate({int min = 0, required int max}) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.josefinSansTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(child: SumWidget()),
      ),
    );
  }
}

class SumWidget extends StatefulWidget {
  const SumWidget({Key? key}) : super(key: key);

  @override
  State<SumWidget> createState() => _SumWidgetState();
}

class _SumWidgetState extends State<SumWidget> {
  late int op1;
  late int op2;
  late int rta;
  List<int> vectorRta = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
  }

  void onResultClick(int value) {
    if (value == rta) {
      score = score + 1;
    }
    setState(() {});
  }

  void setValues() {
    print("Set Values");
    op1 = RandomInt.generate(max: 50);
    op2 = RandomInt.generate(max: 50);

    rta = op1 + op2;
    vectorRta.clear();
    vectorRta.add(rta);
    vectorRta.add(rta + 1);
    vectorRta.add(rta - 1);
    vectorRta.shuffle();
  }

  void reset() {
    setState(() {
      score = 0;
    });

    setValues();
  }

  @override
  Widget build(BuildContext context) {
    setValues();
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 36,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print('click');
                          reset();
                        },
                        child: const Icon(Icons.replay),
                      ),
                    )
                  ],
                )),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OpWidget(text: op1.toString()),
                    const OpWidget(text: '+'),
                    OpWidget(text: op2.toString()),
                    const OpWidget(text: '='),
                    const OpWidget(text: '?'),
                  ]),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              resultButton(vectorRta[0]),
              resultButton(vectorRta[1]),
              resultButton(vectorRta[2]),
            ],
          ),
        )
      ],
    );
  }

  Widget resultButton(int value) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () => onResultClick(value),
          child: Text(value.toString(),
              style: const TextStyle(
                fontSize: 40,
              ))),
    ));
  }
}

class OpWidget extends StatelessWidget {
  const OpWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    print(text);
    return Text(text,
        style: const TextStyle(
          fontSize: 40,
        ));
  }
}
