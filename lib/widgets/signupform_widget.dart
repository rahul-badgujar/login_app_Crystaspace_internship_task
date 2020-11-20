import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/signupform_model.dart';
import 'package:login_app/utils/constants.dart';

import 'form_widgets.dart';

class SignupFormWidget extends StatefulWidget {
  final SignupFormModel signupFormModel;

  SignupFormWidget(this.signupFormModel);

  @override
  _SignupFormWidgetState createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _signupFormKey = new GlobalKey<FormState>();

  final TextEditingController passwordTextController =
      new TextEditingController(); // for confirm password and password matching check

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DimConstants.FORMBODY_PADDING,
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
            // email field
            label: StringConstants.EMAIL_TXT,
            hint: StringConstants.EMAIL_TXT,
            validator: _emailFieldValidator,
            onSaved: _emailFieldOnSaved,
          ),
          FormInputField(
            // password field
            label: StringConstants.PASSWORD_TXT,
            hint: StringConstants.PASSWORD_TXT,
            validator: _passwordFieldValidator,
            onSaved: _passwordFieldOnSaved,
            isTextObscure: true,
            controller: passwordTextController,
          ),
          FormInputField(
            // confirm password field
            label: StringConstants.CNF_PASSWORD_TXT,
            hint: StringConstants.CNF_PASSWORD_TXT,
            validator: _confirmPasswordFieldValidator,
            onSaved: _confirmPasswordFieldOnSaved,
            isTextObscure: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          FormSubmitButton(
            // sign up button
            label: StringConstants.SIGNUP_TXT,
            onClick: _onFormSubmit,
          ),
        ],
      ),
    );
  }

  String _confirmPasswordFieldValidator(String value) {
    final String password = passwordTextController.text.toString();
    final bool matchingWithPassoword =
        password == value; // check if password and confirm password matches
    if (!matchingWithPassoword) {
      // print("Password: " + password + ", Confirm Password: " + value);
      return "Passwords not matching";
    }
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
        context: context,
        label: StringConstants.CNF_PASSWORD_TXT,
        value: value);
  }

  void _confirmPasswordFieldOnSaved(String value) {
    widget.signupFormModel.confirmPassword = value;
  }

  String _passwordFieldValidator(String value) {
    final length = value.length;
    if (length < 8) {
      // if password is short
      return "Password should be of mininum " +
          NumberConstants.MIN_PSW_LEN.toString() +
          " characteres";
    }
    final validator = Validator(validators: [RequiredValidator()]);
    return validator.validate(
        context: context, label: StringConstants.PASSWORD_TXT, value: value);
  }

  void _passwordFieldOnSaved(String value) {
    widget.signupFormModel.password = value;
  }

  String _emailFieldValidator(String value) {
    final validator =
        Validator(validators: [RequiredValidator(), EmailValidator()]);
    return validator.validate(
        context: context, label: StringConstants.EMAIL_TXT, value: value);
  }

  void _emailFieldOnSaved(String value) {
    widget.signupFormModel.email = value;
  }

  void _onFormSubmit() {
    // when form is submitted
    bool formValidation = _signupFormKey.currentState.validate();
    if (formValidation) {
      // if form is valid
      _signupFormKey.currentState.save();
      print(widget.signupFormModel);
      showTextSnackbar(context, "Signup Succesfull");
    } else {
      showTextSnackbar(context, "Errors in Signup Form");
    }
  }
}
