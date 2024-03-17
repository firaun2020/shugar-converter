import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BloodSugarConverterApp());
}

class BloodSugarConverterApp extends StatelessWidget {
  const BloodSugarConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BloodSugarConverterScreen(),
    );
  }
}

class BloodSugarConverterScreen extends StatefulWidget {
  const BloodSugarConverterScreen({super.key});

  @override
  _BloodSugarConverterScreenState createState() =>
      _BloodSugarConverterScreenState();
}

class _BloodSugarConverterScreenState extends State<BloodSugarConverterScreen> {
  TextEditingController mgdlController = TextEditingController(text: '110');
  TextEditingController mmolController = TextEditingController(text: '6.1');

  void convertToMmol() {
    if (mgdlController.text.isNotEmpty) {
      double mgdlValue = double.tryParse(mgdlController.text) ?? 0;
      double mmolValue = mgdlValue / 18.0;
      mmolController.text = mmolValue.toStringAsFixed(1);
      //mgdlController.clear();
    } else if (mmolController.text.isNotEmpty) {
      double mmolValue = double.tryParse(mmolController.text) ?? 0;
      double mgdlValue = mmolValue * 18.0;
      mgdlController.text = mgdlValue.toStringAsFixed(0);
      // mmolController.clear();
    }
  }

  void resetValues() {
    setState(() {
      mgdlController.text = '110';
      mmolController.text = '6.1';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Diabetes Dua"),
                      content: Image.asset('assets/sugar_prayer.jpg'),
                    );
                  },
                );
              },
              icon: const Icon(Icons.mosque),
            )
          ],
          title: const Text(
            'Blood Sugar Converter',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    style: const TextStyle(fontSize: 30),
                    controller: mmolController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+.?[0-9]*'))
                    ],
                    decoration: InputDecoration(
                      labelText: 'Blood Sugar (mmol/L)',
                      border: OutlineInputBorder(
                        // Add border
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                    onTap: () {
                      mmolController.clear();
                      mgdlController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: convertToMmol,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0), // Adjust padding
                    ),
                    child: const Text(
                      'Convert',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white), // Increase text size
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(fontSize: 30),
                    controller: mgdlController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Blood Sugar (mg/dL)',
                      border: OutlineInputBorder(
                        // Add border
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                    onTap: () {
                      mgdlController.clear();
                      mmolController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0), // Adjust padding
                    ),
                    onPressed: resetValues,
                    child: const Text('RESET'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
