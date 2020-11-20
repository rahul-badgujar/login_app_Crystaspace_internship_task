import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/loginform_model.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginFormModel _loginFormModel;

  LoginFormWidget(this._loginFormModel);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _loginFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildLoginForm(context),
    );
  }

  Form buildLoginForm(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          buildEmailField(context),
          buildPasswordField(context),
          buildLoginButton(),
        ],
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: _onFormSubmit,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("Login"),
        ),
      ),
    );
  }

  TextFormField buildPasswordField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
      ),
      validator: (value) {
        final validator = Validator(validators: [RequiredValidator()]);
        return validator.validate(
            context: context, label: "Password", value: value);
      },
      onSaved: (value) {
        widget._loginFormModel.password = value;
      },
    );
  }

  TextFormField buildEmailField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        labelText: "Email",
      ),
      validator: (value) {
        final validator =
            Validator(validators: [RequiredValidator(), EmailValidator()]);
        return validator.validate(
            context: context, label: "Email", value: value);
      },
      onSaved: (value) {
        widget._loginFormModel.email = value;
      },
    );
  }

  void _onFormSubmit() {
    bool formValidation = _loginFormKey.currentState.validate();
    if (formValidation) {
      _loginFormKey.currentState.save();
      print(widget._loginFormModel.toString());
      _showTextSnackbar("Login Succesfull");
    } else {
      _showTextSnackbar("Errors in Login Form");
    }
  }

  void _showTextSnackbar(String s) {
    SnackBar snackBar = SnackBar(content: Text(s));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
