import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/loginform_model.dart';

import 'form_widgets.dart';

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
          FormInputField(
            label: "Login",
            hint: "Login",
            validator: _emailFieldValidator,
            onSaved: _emailFieldOnSaved,
          ),
          FormInputField(
            label: "Password",
            hint: "Password",
            validator: _passwordFieldValidator,
            onSaved: _passwordFieldOnSaved,
            isTextObscure: true,
          ),
          FormSubmitButton(label: "Login", onClick: _onFormSubmit),
        ],
      ),
    );
  }

  String _passwordFieldValidator(String value) {
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
        context: context, label: "Password", value: value);
  }

  void _passwordFieldOnSaved(String value) {
    widget._loginFormModel.password = value;
  }

  String _emailFieldValidator(String value) {
    final validator =
        Validator(validators: [RequiredValidator(), EmailValidator()]);
    return validator.validate(context: context, label: "Email", value: value);
  }

  void _emailFieldOnSaved(String value) {
    widget._loginFormModel.email = value;
  }

  void _onFormSubmit() {
    bool formValidation = _loginFormKey.currentState.validate();
    if (formValidation) {
      _loginFormKey.currentState.save();
      print(widget._loginFormModel.toString());
      showTextSnackbar(context, "Login Succesfull");
    } else {
      showTextSnackbar(context, "Errors in Login Form");
    }
  }
}
