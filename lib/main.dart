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
    return Column( // Columns allow us to place widgets vertically
      children: [
        ResultDisplay(text: '0'),
        Row( // Rows are likewise in the horizontal direction
          children: [
            // Here is the bottom of the first row
            CalculatorButton(
                label: "BUTTON",
                onClick: () => {

                }, // onClick
                size: 90
            )
          ],
        )
      ]
    );
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

class CalculatorButton extends StatelessWidget
{
  CalculatorButton({
    required this.label,
    required this.onClick,
    required this.size,
    this.bgColour = Colors.black,
    this.labelColour = Colors.white
  });

  String label = ""; // What's going to be displayed on the button
  VoidCallback onClick; // The callback function to be executed when the button is pressed
  double size = 0.0; // The size of the button
  Color bgColour;
  Color labelColour;

  @override
  Widget build(BuildContext context)
  {
    /*return Padding(
      padding: EdgeInsets.all(6), // Creates a margin between all of the buttons of the calculator
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration( // Allows us to style the boxes, adding borders, drop-shadow, etc.
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 2
            ),
          ],

          borderRadius: BorderRadius.all(
            Radius.circular(size / 2)
          ),
          color: bgColour
        ),

        child: TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder() // Make the button circular
          ),
          onPressed: onClick,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: labelColour
              )
            )
          )
        )
      )
    );*/

    return Padding(
      padding: EdgeInsets.all(6),
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 2
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2)
          ),
          color: bgColour
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(size / 2),
            ),
          ),
          onTap: onClick,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: labelColour
              ),
            ),
          ),
        )
      ),
    );
  }



}