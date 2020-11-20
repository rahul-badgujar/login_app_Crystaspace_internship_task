import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/signupform_model.dart';

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
          buildEmailField(context),
          buildPasswordField(context),
          buildConfirmPasswordField(context),
          buildSignupButton(),
        ],
      ),
    );
  }

  ElevatedButton buildSignupButton() {
    return ElevatedButton(
      onPressed: _onFormSubmit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text("Sign Up"),
      ),
    );
  }

  TextFormField buildConfirmPasswordField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        labelText: "Confirm Password",
      ),
      validator: (value) {
        final String password = passwordTextController.text;
        final bool matchingWithPassoword = password == value;
        if (!matchingWithPassoword) return "Passwords doesnt Match";
        final validator = Validator(validators: [RequiredValidator()]);
        return validator.validate(
            context: context, label: "Password", value: value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: passwordTextController,
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
    );
  }

  void _onFormSubmit() {
    bool formValidation = _signupFormKey.currentState.validate();
    if (formValidation) {
      _signupFormKey.currentState.save();
      _showTextSnackbar("Signup Succesfull");
    } else {
      _showTextSnackbar("Errors in Signup Form");
    }
  }

  void _showTextSnackbar(String s) {
    SnackBar snackBar = SnackBar(content: Text(s));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
