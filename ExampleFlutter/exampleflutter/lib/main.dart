import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
      home: const MyHomePage(title: 'ExampleFlutter'),
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

  final redirectURLController = TextEditingController();
  final amountController = TextEditingController();
  final referenceController = TextEditingController();
  final descriptionController = TextEditingController();
  final accountTypeController = TextEditingController();
  final identificationController = TextEditingController();
  final nameController = TextEditingController();
  final currencyController = TextEditingController();

   @override
  void initState() {
    super.initState();
    redirectURLController.text = "https://preprodenv.pengpay.io/paycompleted";
    amountController.text = "11.3";
    referenceController.text = "Sample Reference";
    descriptionController.text = "Sample Description";
    accountTypeController.text = "SortCode";
    identificationController.text = "10203012345678";
    nameController.text = "John Doe";
    currencyController.text = "GBP";
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column (
          children: [
                  ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      children: [             
                        TextFormField(
                        controller: redirectURLController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Redirect URL',
                        ),
                      ),
                      TextFormField(
                        controller: amountController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Amount',
                        ),
                      ),
                      TextFormField(
                        controller: referenceController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Reference (Max: 18)',
                        ),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Description (Max: 255)',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Text('Creditor Account',
                        style: TextStyle(fontSize: 22))),
                      TextFormField(
                        controller: accountTypeController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Type("SortCode", "Iban", "Bban")',
                        ),
                      ),
                      TextFormField(
                        controller: identificationController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Identification',
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: currencyController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Currency("GBP", "EUR", etc.)',
                        ),
                      ),  
                    ],           
              ),   
             Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: RaisedButton(
                child: Text("Pay with Paylink"), 
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: () {
                  initiate(context);
                })
                ), 
          ]
        )
      ),    
    );
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

  void initiate(BuildContext context) async {

    Object? resultObject;

    Map<String, dynamic> arguments = {
      "amount" :  double.tryParse(amountController.text) ?? 0,
      "redirect_url" : redirectURLController.text,
      "reference" : referenceController.text,
      "description" : descriptionController.text,
      "creditor_account" : {
        "currency" : currencyController.text,
        "identification" : identificationController.text,
        "type" : accountTypeController.text,
        "name" : nameController.text
      }
    }; 

    try {
      resultObject = await platform.invokeMethod("initiate", arguments);  
      var result = PaymentResult(resultObject);
      showAlertDialog(context, result.status);

    } catch(e) {
      print("error" + e.toString());
    }
  }
}

void showAlertDialog(BuildContext context, String? result) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () { 
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Payment Result"),
    content: Text(result ?? "Unknown"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class PaymentResult {
  
  String? status;
  
  PaymentResult(Object? object) {
      Map<String, dynamic> map = jsonDecode(json.encode(object)); 
      this.status = map['status'];
  }
}