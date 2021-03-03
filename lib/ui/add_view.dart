import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ['BTC', 'ETH', 'ADA'];
  String dropDownValue = 'BTC';
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropDownValue,
            icon: Icon(Icons.arrow_downward),
            onChanged: (String newValue) {
              setState(() {
                dropDownValue = newValue;
              });
            },
            items: coins.map((val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val),
              );
            }).toList(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Coin Amount'),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          MaterialButton(
              color: Colors.blueAccent,
              child: Text('Add Coin'),
              onPressed: () async {
                await addCoin(dropDownValue, _amountController.text);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
