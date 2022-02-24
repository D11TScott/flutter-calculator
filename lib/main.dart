import 'package:flutter/material.dart';

void main()
{
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget
{
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
        // Material app gives us a lot of predefined functionality, in line with Google's Material Design
        return MaterialApp(
          title: 'Calculator',
          home: Scaffold( // A scaffold lets us work with the fonts, but will also provides an API
            body: SafeArea(
              child: Calculator() // Calculator will contain the screen that holds all the UI elements
            )
          ),
        );
  }
}

class Calculator extends StatefulWidget
{
  @override
  _CalculationState createState() => _CalculationState();

}

class _CalculationState extends State<Calculator>
{
  int m_result = 0;

  @override
  Widget build(BuildContext context)
  {
    return ResultDisplay(text: '0');
  }
}

class ResultDisplay extends StatelessWidget
{
  ResultDisplay({
    required this.text
  });

  int m_result = 0;
  String text = "";

  @override
  Widget build(BuildContext context) {
    // In here, we're building the display of the calculator at the top of the window
    return Container(
        width: double.infinity,
        height: 80,
        color: Colors.black,
        child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 24),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34
              ),
            )
        )
    );
  }
}