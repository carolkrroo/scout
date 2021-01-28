import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scout/components/rounded_button.dart';
import 'package:scout/constants.dart';
import 'package:scout/models/user-login.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool showSpinner = false;

  UserLogin user = UserLogin();

  _showSnackBar(String message) {
    var _snackBar = SnackBar(
      content: Text(message),
    );
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/img/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Insira seu e-mail',
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    setState(() {
                      user.email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Insira sua senha',
                    labelText: 'Senha',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    setState(() {
                      user.password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Entrar',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                                email: user.email, password: user.password);
                        if (userCredential != null) {
                          Navigator.pushNamed(context, ScoutHome.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-email') {
                          _showSnackBar('Insira um e-mail válido.');
                        } else if (e.code == 'user-not-found') {
                          _showSnackBar('Usuário não encontrado.');
                        } else if (e.code == 'wrong-password') {
                          _showSnackBar('A senha está incorreta.');
                        }
                      } catch (e) {
                        _showSnackBar('Ocorreu o erro: $e');
                      } finally {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } else {
                      _showSnackBar('Preencha os campos obrigatórios.');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
