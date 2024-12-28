import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  String opr = '';
  String preOpr = '';

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 30,
            color: txtcolor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          backgroundColor: btncolor,
        ),
      ),
    );
  }

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1) : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) == 0) return splitDecimal[0];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: const Text('CALCULATOR'),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Calculator display
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: calcbutton('AC', Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('+/-', Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('%', Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('/', Colors.amber[700] ?? Colors.amber, Colors.white)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: calcbutton('7', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('8', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('9', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('x', Colors.amber[700] ?? Colors.amber, Colors.white)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: calcbutton('4', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('5', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('6', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('-', Colors.amber[700] ?? Colors.amber, Colors.white)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: calcbutton('1', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('2', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('3', Colors.grey[850] ?? Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('+', Colors.amber[700] ?? Colors.amber, Colors.white)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          calculation('0');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.grey[850], // Set the background color here
                        ),
                        child:
                        Expanded(child: calcbutton('.', Colors.grey[850] ?? Colors.grey, Colors.white)),

                      ),
                    ),
                  ),
                  Expanded(child: calcbutton('.', Colors.grey[850] ?? Colors.grey, Colors.white)),
                  Expanded(child: calcbutton('=', Colors.amber[700] ?? Colors.amber, Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


