import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = const MethodChannel("paylink/flutter");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [ 
              RaisedButton(
                child: Text("Open webView"), 
                onPressed: () {
                  open();
                }),
                RaisedButton(
                child: Text("Initiate"), 
                onPressed: () {
                  initiate();
                }),
            ],
      ),
      ),
    
    );
  }

  void beep() async {
    String value;

    try {
      value = await platform.invokeMethod("beep");
      print(value);
    } catch(e) {
      print(e);
    }
  }

  void configure() async {
    String value;

    Map<String, String> arguments = {
      "clientID": "client-id", 
      "clientSecret": "client-secret",
    };

    try {
      value = await platform.invokeMethod("configure", arguments);
      print(value);
    } catch(e) {
      print(e);
    }
  }

  void open() async {
    String value;

    Map<String, String> arguments = {
      "uid": "a02ac408-563a-4e55-a5e2-3aebc119f908"
    };

    try {
      value = await platform.invokeMethod("open", arguments);
      print(value);
    } catch(e) {
      print(e);
    }
  }

  void initiate() async {
   dynamic value;   

    Map<String, dynamic> arguments = {
      "amount" : 1,
      "redirect_url" : "https://preprodenv.pengpay.io/paycompleted",
      "reference" : "Sample Reference",
      "description" : "Sample Description",
      "creditor_account" : {
        "currency" : "GBP",
        "identification" : "10203012345678",
        "type" : "SortCode",
        "name" : "John Doe"
      }
    }; 

    try {
      value = await platform.invokeMethod("initiate", arguments);
      print(value);
    } catch(e) {
      print("error" + e.toString());
    }
  }
}