import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0;
  double ethereum = 0;
  double cardano = 0;

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('ethereum');
    cardano = await getPrice('cardano');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == 'BTC') {
        return bitcoin * amount;
      } else if (id == 'ETH') {
        return ethereum * amount;
      } else if (id == 'ADA') {
        return cardano * amount;
      }
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data.docs
                      .map(
                        (documents) => Container(
                          child: Card(
                            child: ListTile(
                              leading: Text('${documents.id}'),
                              title: Text(
                                  'Amount Owned ${documents.data()['Amount'].toStringAsFixed(4)}'),
                              subtitle: Text(
                                  '\$ ${getValue(documents.id, documents.data()['Amount']).toStringAsFixed(2)}'),
                            ),
                          ),

                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Text('Coin Name: ${documents.id}'),
                          //     Text(
                          //       'Amount Owned ${documents.data()['Amount']}',
                          //     ),
                          //     Text(
                          //       '\$ ${getValue(documents.id, documents.data()['Amount']).toStringAsFixed(4)}',
                          //     ),
                          //   ],
                          // ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddView(),
                ),
              );
            }),
      ),
    );
  }
}
