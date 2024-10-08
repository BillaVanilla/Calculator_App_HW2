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
  const CalculatorPage({super.key});

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

 void ClearButton() {
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
          // Start of Button Layout
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
          // Start of Button List
           children: [
            Buttonbuilder('7', () => DigitButtonPress('7'), color: const Color.fromARGB(255, 9, 255, 0)),
            Buttonbuilder('8', () => DigitButtonPress('8'), color: const Color.fromARGB(255, 9, 255, 0)),
            Buttonbuilder('9', () => DigitButtonPress('9'), color: const Color.fromARGB(255, 9, 255, 0)),
            Buttonbuilder('/', () => OperatorButtonPress('/'), color: const Color.fromARGB(255, 238, 255, 0)),
            Buttonbuilder('4', () => DigitButtonPress('4'), color: const Color.fromARGB(255, 255, 102, 0)),
            Buttonbuilder('5', () => DigitButtonPress('5'), color: const Color.fromARGB(255, 255, 102, 0)),
            Buttonbuilder('6', () => DigitButtonPress('6'), color: const Color.fromARGB(255, 255, 102, 0)),
            Buttonbuilder('*', () => OperatorButtonPress('*'), color: const Color.fromARGB(255, 238, 255, 0)),
            Buttonbuilder('1', () => DigitButtonPress('1'), color: const Color.fromARGB(255, 0, 60, 255)),
            Buttonbuilder('2', () => DigitButtonPress('2'), color: const Color.fromARGB(255, 0, 60, 255)),
            Buttonbuilder('3', () => DigitButtonPress('3'), color: const Color.fromARGB(255, 0, 60, 255)),
            Buttonbuilder('-', () => OperatorButtonPress('-'), color: const Color.fromARGB(255, 238, 255, 0)),
            Buttonbuilder('0', () => DigitButtonPress('0'), color: const Color.fromARGB(255, 0, 60, 255)),
            Buttonbuilder('.', () => DigitButtonPress('.')),
            Buttonbuilder('=', calculate, color: const Color.fromARGB(255, 255, 1, 192)),
            Buttonbuilder('+', () => OperatorButtonPress('+'), color: const Color.fromARGB(255, 0, 247, 255)),
              ],
            ),
          ),
          // Clear Button Start
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                backgroundColor: Colors.redAccent,
                  ),
          onPressed: ClearButton,
              child: const Text(
                'Clear',
                style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 50),
         ],
      ),
    );
  }
}
