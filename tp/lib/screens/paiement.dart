import 'package:flutter/material.dart';
import 'package:kkiapay_flutter_sdk/kkiapay/view/widget_builder_view.dart';
import 'package:kkiapay_flutter_sdk/utils/kkiapayConf.sample.dart';

import './successScreen.dart';

void successCallback(response, context) {
  print(response);
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SuccessScreen(
      //  amount: response['requestData']['amount'],
      //  transactionId: response['transactionId'],
      ),
    ),
  );
}
final String name="";
final int amount=0;
final String  e_mail="";
final String phone="";

final kkiapay = KKiaPay(
  amount: amount,
  countries: ["BJ"],
  phone: phone,
  name: name,
  email: e_mail,
  reason: 'transaction reason',
  data: 'Fake data',
  sandbox: true,
  apikey: '23698380b9da11edb6ee35ec34fdbb2f',
  callback: successCallback,
  theme: defaultTheme, // Ex : "#222F5A",
  partnerId: '6402159e0599010009c19e85',
    paymentMethods: ["momo","card"]
);

class Paiement extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: nColorPrimary,
          title: Text('Kkiapay Sample'),
          centerTitle: true,
        ),
        body: KkiapaySample(),
      ),
    );
  }
}

class KkiapaySample extends StatelessWidget {
  const KkiapaySample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              minWidth: 500.0,
              height: 100.0,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff222F5A)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => kkiapay),
                  );
                },
              ),
            )
          ],
        )
    );
  }
}