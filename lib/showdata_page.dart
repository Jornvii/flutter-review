import 'package:flutter/material.dart';
import 'package:flutter_test_1/condition.dart';

class ShowdataPopup extends StatefulWidget {
  const ShowdataPopup({super.key});

  @override
  State<ShowdataPopup> createState() => _ShowdataPopupState();
}

class _ShowdataPopupState extends State<ShowdataPopup> {
  final TextEditingController _sysController = TextEditingController();
  final TextEditingController _diaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showPressurePopup(String sys, String dia) {
    int sysValue = int.parse(sys);
    int diaValue = int.parse(dia);
    String condition = determineCondition(sysValue, diaValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "ข้อมูลความดันโลหิต",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "SYS: $sys mmHg\nDIA: $dia mmHg\nสภาวะ: $condition",
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("ตกลง"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ข้อมูลความดันโลหิต',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: _sysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'SYS (mmHg)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกค่า SYS';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _diaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'DIA (mmHg)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกค่า DIA';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          String sys = _sysController.text;
                          String dia = _diaController.text;
                          _showPressurePopup(sys, dia);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('กรุณากรอกค่า SYS และ DIA.'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 101, 255, 106),
                        shadowColor: Colors.black45,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('แสดงข้อมูลความดันโลหิต'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}