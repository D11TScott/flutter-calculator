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
  int? result; // ? operator means it's nullable
  int? firstOperand;
  int? secondOperand;
  String? operator;

  Widget getButton({required String text, required VoidCallback onClick, Color backgroundColour = Colors.white, Color labelColour = Colors.black}){
    return CalculatorButton(
        label: text,
        onClick: onClick,
        size: 90,
        bgColour: backgroundColour,
        labelColour: labelColour,
    );
  }

  String getDisplayText()
  {
    if(result != null)
    {
      return '$result';
    }

    if(secondOperand != null)
    {
      return '$firstOperand $operator $secondOperand';
    }

    if(operator != null)
    {
      return '$firstOperand $operator';
    }

    if(firstOperand != null)
    {
      return '$firstOperand';
    }

    return '0';
  }

  void numberPressed(int number)
  {
    setState(() {
      if(result != null)
      {
        result = null;
        firstOperand = number;
        return;
      }

      if(firstOperand == null)
      {
        firstOperand = number;
        return;
      }

      if(operator == null)
      {
        // Concatenate the newly-pressed number to the previous value if the operator wasn't pressed
        firstOperand = int.parse('$firstOperand$number');
        return;
      }

      if(secondOperand == null)
      {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });

  }

  void operatorPressed(String operator)
  {
    setState(() {
      // Treat it as a 0 if there is no number in the dialog
      if(firstOperand == null){
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  void equalsPressed()
  {
    // Don't calculate the result if there is only one number or the operation button hasn't been pressed
    if(operator == null || firstOperand == null || secondOperand == null)
    {
      return;
    }

    // Because ? is nullable, operators can't be used, cast to non-nullable types
    int first = firstOperand as int;
    int second = secondOperand as int;

    // setState() rebuilds the widget which shows the changes in the UI
    setState(() {
      switch(operator){
        case '+':
            result = first + second;
          break;
        case '/':
          if(second == 0){
            return;
          }
          result = first ~/ second;
          break;
        case 'X':
          result = first * second;
          break;
        case '-':
          result = first - second;
          break;
      }

      // Display the result and then reset the values
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  void isPrimePressed()
  {

  }

  void clear()
  {
    setState(() {
      result = null;
      operator = null;
      firstOperand = null;
      secondOperand = null;
    });
  }

  void clearEntry()
  {

  }

  void copyToClipboard()
  {

  }

  @override
  Widget build(BuildContext context)
  {
    return Column( // Columns allow us to place widgets vertically
      children: [
        ResultDisplay(
            text: getDisplayText()
        ),
        Row( // Rows are likewise in the horizontal direction
          children: [
            // Here is the bottom of the first row
            getButton(text: 'C', onClick: () => clear(), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
            getButton(text: 'CE', onClick: () => clearEntry(), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
            getButton(text: 'COPY', onClick: () => copyToClipboard(), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
            getButton(text: 'Prime?', onClick: () => isPrimePressed(), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
          ],
        ),
        Row( // Rows are likewise in the horizontal direction
          children: [
            getButton(text: '7', onClick: () => numberPressed(7)),
            getButton(text: '8', onClick: () => numberPressed(8)),
            getButton(text: '9', onClick: () => numberPressed(9)),
            getButton(text: 'X', onClick: () => operatorPressed("X"), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
          ],
        ),
        Row( // Rows are likewise in the horizontal direction
          children: [
            getButton(text: '4', onClick: () => numberPressed(4)),
            getButton(text: '5', onClick: () => numberPressed(5)),
            getButton(text: '6', onClick: () => numberPressed(6)),
            getButton(text: '/', onClick: () => operatorPressed("/"), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
          ],
        ),
        Row( // Rows are likewise in the horizontal direction
          children: [
            getButton(text: '1', onClick: () => numberPressed(1)),
            getButton(text: '2', onClick: () => numberPressed(2)),
            getButton(text: '3', onClick: () => numberPressed(3)),
            getButton(text: '+', onClick: () => operatorPressed("+"), backgroundColour: Colors.blueAccent, labelColour: Colors.white),
          ],
        ),
        Row( // Rows are likewise in the horizontal direction
          children: [
            getButton(text: '=', onClick: () => equalsPressed(), backgroundColour: Colors.deepPurple, labelColour: Colors.white),
            getButton(text: '0', onClick: () => numberPressed(0)),
            getButton(text: '-', onClick: () => operatorPressed("-")),
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