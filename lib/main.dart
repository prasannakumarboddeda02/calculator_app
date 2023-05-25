import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() {
  runApp(const MaterialApp( home: CalculatorApp()));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  var output = '0';
  var input = '';


  void onButtonClicked(symbol){
    if(symbol == 'AC'){
      input='';
      output='0';
    }
    else if(symbol == '←'){
      if(input.isNotEmpty){
        input = input.substring(0,input.length-1);
      }
    }
    else if(symbol == '='){
      var operation = input;
      operation = operation.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(operation);
      ContextModel cm = ContextModel();
      output = exp.evaluate(EvaluationType.REAL,cm).toString();
    }
    else{
      var list = ['+','-','x','/','%'];
      if(!(list.contains(symbol) && list.contains(input[input.length-1]))){
      input = input+symbol;
      }
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          children: [
            Expanded(
              child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white.withOpacity(0.7)
                    ),
                  )
                ],
              ),
              )),
            Row(
              children: [
              button(text: 'AC',backgroundcolor: operatorcolor,textcolor: orangecolor),
              button(text: '%',backgroundcolor: operatorcolor,textcolor: orangecolor),
              button(text: '/',backgroundcolor: operatorcolor,textcolor: orangecolor),
              button(text: '←',backgroundcolor: operatorcolor,textcolor: orangecolor)
            ]),
            Row(
              children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: 'x',backgroundcolor: operatorcolor,textcolor: orangecolor)
            ]),
            Row(
              children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-',backgroundcolor: operatorcolor,textcolor: orangecolor)
            ]),
            Row(
              children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+',backgroundcolor: operatorcolor,textcolor: orangecolor)
            ]),
            Row(
              children: [
              button(text: '0',flex: 2),
              button(text: '.'),
              button(text: '=',backgroundcolor: orangecolor,textcolor: Colors.black)
            ])
          ]),
    );
  }

  Widget button({
    text, backgroundcolor = buttoncolor, textcolor = Colors.white, flex = 1
  }){
    return Expanded(
      flex: flex,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: backgroundcolor,
            padding: const EdgeInsets.all(22)),
            onPressed: () => onButtonClicked(text),
            child: Text(
              text,
              style: TextStyle(color: textcolor,fontSize: 20,fontWeight: FontWeight.bold))
      )
    ),
  );
}

}