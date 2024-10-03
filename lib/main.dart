import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key, required this.title});


  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String textDisplay = 'Enter a number:';
  double firstNumber = 0;
  String operand = '';
  bool newentry = true;
  bool containsDecimal = false;

  void DigitButtonPress(String number) {
    setState(() {
      if (newentry) {
        textDisplay = number == '.' ? '0.' : number;
        newentry = false;
      } else if (number == '.' && !containsDecimal) {
        textDisplay += '.';
        containsDecimal = true;
      } else if (number != '.') {
        textDisplay += number;
      }
    });
  }

void OperatorButtonPress(String operator) {
    setState(() {
      firstNumber = double.parse(textDisplay);
      operand = operator;
      newentry = true;
      containsDecimal = false;
    });
  }

  void calculate() {
    setState(() {
      double secondNumber = double.parse(textDisplay);
      double result = 0;

      switch (operand) {
        case '+':
          result = firstNumber + secondNumber;
          break;
        case '-':
          result = firstNumber - secondNumber;
          break;
        case '*':
          result = firstNumber * secondNumber;
          break;
        case '/':
          result = secondNumber != 0 ? firstNumber / secondNumber : double.nan;
          break;
        default:
          return;
      }

      textDisplay = result.isNaN ? "Error: Please Retry" : result.toString();
      if (textDisplay.endsWith('.0')) {
        textDisplay = textDisplay.substring(0, textDisplay.length - 2);
      }
      newentry = true;
      containsDecimal = textDisplay.contains('.');
    });
  }

 void _clear() {
    setState(() {
      textDisplay = '0';
      firstNumber = 0;
      operand = '';
      newentry = true;
      containsDecimal = false;
    });
  }

Widget Buttonbuilder(String text, Function() onPressed, {Color? color}) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.red[100],
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text("Babila's Calculator"),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
         children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerRight,
            child: Text(
              textDisplay,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
         ]
      ),
    );
  }
}
