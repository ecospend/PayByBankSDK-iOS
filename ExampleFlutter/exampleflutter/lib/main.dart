import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';

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

  static const MethodChannel platform = const MethodChannel("paylink/flutter");
  static const EventChannel paymentInitiateEventChannel = EventChannel('paylink/initiateEvent');

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
    paymentInitiateEventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    redirectURLController.text = "https://preprodenv.pengpay.io/paycompleted";
    amountController.text = "11.3";
    referenceController.text = "Sample Reference";
    descriptionController.text = "Sample Description";
    accountTypeController.text = "SortCode";
    identificationController.text = "10203012345678";
    nameController.text = "John Doe";
    currencyController.text = "GBP";
  }

  void _onEvent(Object? event) {
      print(event);
      var result = PaymentResult(event);
      String jsonResult = jsonEncode(result);
      print(jsonResult);
      _showToast(context, result.status);
  }

  void _onError(Object error) {
    print(error);
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
      await platform.invokeMethod("initiate", arguments);
    } catch(e) {
      print("error" + e.toString());
    }
  }
}

void _showToast(BuildContext context, String? result) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(result ?? ""),
      ),
    );
}

class PaymentResult {

  String? status;

  PaymentResult(Object? object) {
      Map<String, dynamic> map = jsonDecode(json.encode(object));
      this.status = map['status'];
  }

  Map toJson() => {
        'status': status,
      };
}
