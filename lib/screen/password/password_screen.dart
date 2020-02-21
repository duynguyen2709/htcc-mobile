import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController _passwordController;
  TextEditingController _repeatController;
  bool _passwordVisible = true;
  bool _repeatVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _repeatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đổi mật khẩu"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: _validate,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                validator: _validate,
                keyboardType: TextInputType.text,
                controller: _repeatController,
                obscureText: _repeatVisible,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      _repeatVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _repeatVisible = !_repeatVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  _formKey.currentState.validate();
                },
                child: Text("Thay đổi mật khấu"),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _validate(value) {
    if (_repeatController.text == "" || _passwordController.text == "")
      return Constants.messagePasswordEmpty;
    if (_repeatController.text != _passwordController.text) {
      return Constants.messagePasswordError;
    } else {
      return null;
    }
  }
}
