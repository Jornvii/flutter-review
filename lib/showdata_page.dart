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

  void _showPressurePopup(String sys, String dia) {
    int sysValue = int.parse(sys);
    int diaValue = int.parse(dia);
    String condition = determineCondition(sysValue, diaValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ข้อมูลความดันโลหิต"),
          content: Text("SYS: $sys mmHg\nDIA: $dia mmHg\nสภาวะ: $condition"),
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
        title: const Text('ข้อมูลความดันโลหิต'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _sysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'SYS (mmHg)',
              ),
            ),
            TextField(
              controller: _diaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'DIA (mmHg)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String sys = _sysController.text;
                String dia = _diaController.text;
                if (sys.isNotEmpty && dia.isNotEmpty) {
                  _showPressurePopup(sys, dia);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('กรุณากรอกค่า SYS และ DIA.')),
                  );
                }
              },
              child: const Text('แสดงข้อมูลความดันโลหิต'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShowdataPopup(),
  ));
}