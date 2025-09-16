import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

// Used copilot to generate code and I just adjusted the interface of what I wanted it to look like

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator App',
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final exp = Expression.parse(
            _expression.replaceAll('×', '*').replaceAll('÷', '/'),
          );
          final evaluator = const ExpressionEvaluator();
          final context = <String, dynamic>{};
          final evalResult = evaluator.eval(exp, context);
          _result = '= $evalResult';
        } catch (e) {
          _result = '= Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String label, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800],
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => _onPressed(label),
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Calculator App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 124, 132, 196),
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                '$_expression $_result',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column(
            children: [
              Row(children: ['7', '8', '9', '÷'].map(_buildButton).toList()),
              Row(children: ['4', '5', '6', '×'].map(_buildButton).toList()),
              Row(children: ['1', '2', '3', '-'].map(_buildButton).toList()),
              Row(children: ['0', '.', '=', '+'].map(_buildButton).toList()),
              Row(children: [_buildButton('AC', color: const Color.fromARGB(255, 19, 92, 189))]),
            ],
          ),
        ],
      ),
    );
  }
}
