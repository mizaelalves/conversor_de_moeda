import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=3e7ad246";

void main() async {
  runApp(MaterialApp
  (home: Home(),
  theme: themeData(
      hintColor: Colors.orange,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
      ),
    ),
    ));
  }
  
  themeData({MaterialColor hintColor, Color primaryColor, InputDecorationTheme inputDecorationTheme}) {
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("\$Conversor"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(35, 10, 89, 10),
          actions: <Widget>[],
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "carregando dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "erro ao carregar dados",
                      style: TextStyle(color: Colors.orange, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar = snapshot.data["results"]["currencies"]["USD"]["BUY"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["BUY"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.orange),

                              TextField(
                                decoration:  InputDecoration(
                                  labelText: "Reais",
                                  labelStyle: TextStyle(color: Colors.orange),
                                  border: OutlineInputBorder(),
                                  prefixText: "R\$"
                                ),
                                style: TextStyle(
                                  color: Colors.orange, fontSize: 25.0
                                )
                              ),
                              Divider(),
                              TextField(
                                decoration:  InputDecoration(
                                  labelText: "Dolar",
                                  labelStyle: TextStyle(color: Colors.orange),
                                  border: OutlineInputBorder(),
                                  prefixText: "US\$"
                                ),
                                style: TextStyle(
                                  color: Colors.orange, fontSize: 25.0
                                )
                              ),
                              Divider(),
                              TextField(
                                decoration:  InputDecoration(
                                  labelText: "Euros",
                                  labelStyle: TextStyle(color: Colors.orange),
                                  border: OutlineInputBorder(),
                                  prefixText: "US\$"
                                ),
                                style: TextStyle(
                                  color: Colors.orange, fontSize: 25.0
                                )
                              )
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
