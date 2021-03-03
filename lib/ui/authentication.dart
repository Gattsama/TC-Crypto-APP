import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[800],
        title: Text(
          'Team Cousin Crypto Conversion Tool',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/BTC_background.jpeg'),
              // NetworkImage('https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/Eug_QjmOeijhmcjnu/abstract-animation-of-bitcoin-currency-sign-in-digital-cyberspace_rkrq6cbyg_thumbnail-full07.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      //TODO: Add if not valiate
                      return 'Please Enter Email';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                  controller: emailField,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 30),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                  controller: passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green[600]),
                width: MediaQuery.of(context).size.width / 1.4,
                child: MaterialButton(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RockRoll',
                          fontSize: 18),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        //TODO: Add if not valiate
                        bool shouldNavigate =
                            await register(emailField.text, passwordField.text);
                        if (shouldNavigate) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeView(),
                            ),
                          );
                        }
                      }
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[600],
                ),
                width: MediaQuery.of(context).size.width / 1.4,
                child: MaterialButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        fontFamily: 'RockRoll'),
                  ),
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(emailField.text, passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeView(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
