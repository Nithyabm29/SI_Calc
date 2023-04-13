import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Sic(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      //accentColor: Colors.indigoAccent
    ),
  ));
}

class Sic extends StatefulWidget {
  const Sic({Key? key}) : super(key: key);

  @override
  State<Sic> createState() => _SicState();
}

class _SicState extends State<Sic> {
  final _fromkey = GlobalKey<FormState>();
  var sampleList = ["Rupees", "Dollars", "Pounds", "Others"];
  var dropdownValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = sampleList[0];
  }

  TextEditingController picon = TextEditingController();
  TextEditingController roicon = TextEditingController();
  TextEditingController tcon = TextEditingController();
  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Simple Interest Calculator"),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        body: Form(
          key: _fromkey,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  const Image(image: AssetImage("snap/s2.png")),
                  Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 5.0),
                      child: TextFormField(
                        controller: picon,
                        validator: (String? value){
                          if (value!.isEmpty) {
                            return "Enter Principal amount!";
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            label: const Text("Principal"),
                            hintText: "Enter the Principal e.g 12000",
                            errorStyle: TextStyle(
                                color: Colors.purple[400],
                                fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0))),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        controller: roicon,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return " Enter rate of interest";
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                            label: const Text("Rate of Interest"),
                            errorStyle: TextStyle(
                                color: Colors.purple[400],
                                fontSize: 15.0
                            ),
                            hintText: "In percent",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: TextFormField(
                                    controller: tcon,
                                    validator: (String? value){
                                      if(value!.isEmpty){
                                        return "Enter the year!";
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                        labelText: "Term",
                                        errorStyle: TextStyle(
                                            color: Colors.purple[400],
                                            fontSize: 15.0
                                        ),
                                        hintText: "Time in years",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(5.0))),
                                  ))),
                          Container(width: 5.0),
                          DropdownButton<String>(
                            value: dropdownValue,
                            items: sampleList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              _dropDownSelected(newValue);
                            },
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                child: const Text("Calculate"),
                                onPressed: () {
                                  setState(() {
                                    if (_fromkey.currentState!.validate()) {
                                      displayResult = _calculateTotalReturns();
                                    }
                                  });
                                },
                              )),
                          Container(width: 4.0),
                          Expanded(
                              child: ElevatedButton(
                                child: const Text("Reset"),
                                onPressed: () {
                                  setState(() {
                                    reset();
                                  });
                                },
                              ))
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(displayResult),
                  )
                ],
              )),
        ));
  }

  void _dropDownSelected(String? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
  }

  String _calculateTotalReturns() {
    double pi = double.parse(picon.text);
    double roi = double.parse(roicon.text);
    double term = double.parse(tcon.text);
    double totalAmountPayable = pi + (pi * roi * term) / 100;
    String res =
        " After $term of years, your investment will be worth of $totalAmountPayable $dropdownValue";
    return res;
  }

  void reset() {
    picon.text = "";
    roicon.text = "";
    tcon.text = "";
    dropdownValue = sampleList[0];
    displayResult = "";
  }

}
