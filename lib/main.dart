import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Калькулятор площади';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          backgroundColor: Colors.brown,
        ),
        body: MyCalculatorForm(),
      ),
    );
  }
}

class MyCalculatorForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyCalculatorFormState();
}

class MyCalculatorFormState extends State<MyCalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  late int _width;
  late int _height;
  late int _area;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(children: <Widget>[
            Container(padding: const EdgeInsets.all(10), child: const Text('Ширина (мм):')),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Задайте параметры")));
                        return 'Задайте Ширину';
                      }

                      try {
                        _width = int.parse(value);
                      } catch (e) {
                        return e.toString();
                      }
                    }))),
          ]),
          const SizedBox(height: 10),
          Row(children: <Widget>[
            Container(padding: const EdgeInsets.all(10), child: const Text('Высота (мм):')),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Задайте параметры")));
                        return 'Задайте Высоту';

                      }

                      try {
                        _height = int.parse(value);
                      } catch (e) {
                        return e.toString();
                      }
                    }))),
          ]),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (_width is int && _height is int) {
                      _area = _width * _height;
                    }
                  });
                  if (_area != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("S = $_width * $_height = $_area (мм2)"),
                      backgroundColor: Colors.indigo,
                    ));
                  }
                }
              },
              child: const Text(
                'Вычислить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
