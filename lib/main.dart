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
    textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      body: Container(
          margin: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principleController,
                      decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter Principle e.g 12000',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      decoration: InputDecoration(
                        labelText: 'Rate of interest',
                        hintText: 'In percentage',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              controller: termController,
                              decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in year',
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
                                this.displayResult = calculateTotalReturn();
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
                                
                                    double totalAmountPayable = principle * (principle * roi * term) / 100;
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
