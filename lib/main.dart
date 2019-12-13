import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(),
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
                        value: 'Rupees',
                        onChanged: (String newValueSelected) {
                          // value = newValueSelected;
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
                            child: Text("CALCULATE"),
                            onPressed: () {},
                          ))),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: minimumPadding, bottom: minimumPadding),
                          child: RaisedButton(
                            child: Text("RESET"),
                            onPressed: () {},
                          ))),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: Text('Dumy Data'),
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
}
