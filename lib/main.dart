import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest Calculator",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  final minimumPadding = 5.0;
  var currencies = ['Rupees', 'dollar'];
  TextStyle textStyle;
  var currentItemSelected = 'Rupees';
  var displayResult = '';

  //TextController
  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principleController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Principle amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Principle',
                          hintText: 'Enter Principle e.g 12000',
                          errorStyle:
                              TextStyle(color: Colors.yellow, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ))),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: roiController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Rate of interest amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Rate of interest',
                          hintText: 'In percentage',
                          errorStyle:
                              TextStyle(color: Colors.yellow, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ))),
                Padding(
                    padding: EdgeInsets.only(
                        top: minimumPadding, bottom: minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                controller: termController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Time';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Term',
                                  hintText: 'Time in year',
                                  errorStyle: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 12.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ))),
                        Container(
                          margin: EdgeInsets.all(minimumPadding * 5),
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          style: textStyle,
                          value: currentItemSelected,
                          onChanged: (String newValueSelected) {
                            onDropDownItemSelected(newValueSelected);
                          },
                        )),
                      ],
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: minimumPadding, bottom: minimumPadding),
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text("CALCULATE"),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    this.displayResult = calculateTotalReturn();
                                  }
                                });
                              },
                            ))),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: minimumPadding, bottom: minimumPadding),
                            child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text("RESET"),
                              onPressed: () {
                                setState(() {
                                  resetData();
                                });
                              },
                            ))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125, height: 125);
    return Container(child: image, margin: EdgeInsets.all(minimumPadding * 8));
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }

  String calculateTotalReturn() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principle + (principle * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable';
    return result;
  }

  void resetData() {
    principleController.clear();
    roiController.clear();
    termController.clear();
    this.displayResult = '';
  }
}
