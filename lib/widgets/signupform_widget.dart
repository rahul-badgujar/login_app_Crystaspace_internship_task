import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/signupform_model.dart';

import 'form_widgets.dart';

class SignupFormWidget extends StatefulWidget {
  final SignupFormModel _signupFormModel;

  SignupFormWidget(this._signupFormModel);

  @override
  _SignupFormWidgetState createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _signupFormKey = new GlobalKey<FormState>();

  final TextEditingController passwordTextController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildSignupForm(context),
    );
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    super.dispose();
  }

  Form buildSignupForm(BuildContext context) {
    return Form(
      key: _signupFormKey,
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
          FormInputField(
            label: "Confirm Password",
            hint: "Confirm Password",
            validator: _confirmPasswordFieldValidator,
            onSaved: _confirmPasswordFieldOnSaved,
            isTextObscure: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          FormSubmitButton(label: "Sign Up", onClick: _onFormSubmit),
        ],
      ),
    );
  }

  String _confirmPasswordFieldValidator(String value) {
    final String password = passwordTextController.text;
    final bool matchingWithPassoword = password == value;
    if (!matchingWithPassoword) return "Passwords doesnt Match";
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
        context: context, label: "Password", value: value);
  }

  void _confirmPasswordFieldOnSaved(String value) {
    widget._signupFormModel.confirmPassword = value;
  }

  String _passwordFieldValidator(String value) {
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
        context: context, label: "Password", value: value);
  }

  void _passwordFieldOnSaved(String value) {
    widget._signupFormModel.password = value;
  }

  String _emailFieldValidator(String value) {
    final validator =
        Validator(validators: [RequiredValidator(), EmailValidator()]);
    return validator.validate(context: context, label: "Email", value: value);
  }

  void _emailFieldOnSaved(String value) {
    widget._signupFormModel.email = value;
  }

  void _onFormSubmit() {
    bool formValidation = _signupFormKey.currentState.validate();
    if (formValidation) {
      _signupFormKey.currentState.save();
      print(widget._signupFormModel);
      showTextSnackbar(context, "Signup Succesfull");
    } else {
      showTextSnackbar(context, "Errors in Signup Form");
    }
  }
}
