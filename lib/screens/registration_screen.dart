import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat/firestore_access.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //final _firestore = FirebaseFirestore.instance;
  final _firestoreAccess = FirestoreAccess();
  bool _showSpinner = false;
  late String _email;
  late String _password;
  late String _displayName;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 250.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  _displayName = value;
                },
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                decoration: kTextFieldDecoration(
                    'Enter your display name', Colors.blueAccent),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    kTextFieldDecoration('Enter your email', Colors.blueAccent),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: kTextFieldDecoration(
                    'Enter your password', Colors.blueAccent),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  text: 'Register',
                  onPress: () async {
                    /*print(_email + ' ' + _password);*/
                    try {
                      setState(() {
                        _showSpinner = true;
                      });
                      final newUser = _firestoreAccess.createNewUser(
                          _email, _password, _displayName);

                      if (newUser != null) {
                        Navigator.pushReplacementNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      setState(() {
                        _showSpinner = false;
                      });
                      print(e);
                    }
                  },
                  color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
