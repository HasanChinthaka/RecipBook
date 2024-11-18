import 'package:flutter/material.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginformKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_title(), _loginform()],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recip Book",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginform() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
        key: _loginformKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'emilys',
              onSaved: (value) {
                setState(() {
                  username = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Username";
                }
              },
              decoration: const InputDecoration(hintText: "User Name "),
            ),
            TextFormField(
              initialValue: 'emilyspass',
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Enter Valid Password";
                }
              },
              decoration: const InputDecoration(hintText: "Password"),
            ),
            _loginbutton(),
          ],
        ),
      ),
    );
  }

  Widget _loginbutton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginformKey.currentState?.validate() ?? false) {
            _loginformKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
            if (result) {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 1),
                title: "Welcome Back!",
                subtitle: "Login Successfull",
                configuration: const IconConfiguration(
                  icon: Icons.check_circle,
                ),
                maxWidth: 260,
              );
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: "Login Failed",
                subtitle: "Please try again",
                configuration: const IconConfiguration(
                  icon: Icons.error,
                ),
                maxWidth: 260,
              );
            }
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
