import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:login_app/models/loginform_model.dart';
import 'package:login_app/utils/constants.dart';

import 'form_widgets.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginFormModel loginFormModel;

  LoginFormWidget(this.loginFormModel);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _loginFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: DimConstants.FORMBODY_PADDING,
        child: buildLoginForm(context),
      ),
    );
  }

  Form buildLoginForm(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          FormInputField(
            // field for email
            label: StringConstants.EMAIL_TXT,
            hint: StringConstants.EMAIL_TXT,
            validator: _emailFieldValidator,
            onSaved: _emailFieldOnSaved,
          ),
          FormInputField(
            // field for password
            label: StringConstants.PASSWORD_TXT,
            hint: StringConstants.PASSWORD_TXT,
            validator: _passwordFieldValidator,
            onSaved: _passwordFieldOnSaved,
            isTextObscure: true,
          ),
          FormSubmitButton(
            // login button
            label: StringConstants.LOGIN_TXT,
            onClick: _onFormSubmit,
          ),
        ],
      ),
    );
  }

  String _passwordFieldValidator(String value) {
    final length = value.length;
    if (length < NumberConstants.MIN_PSW_LEN) {
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
    widget.loginFormModel.password = value;
  }

  String _emailFieldValidator(String value) {
    final validator =
        Validator(validators: [RequiredValidator(), EmailValidator()]);
    return validator.validate(
        context: context, label: StringConstants.EMAIL_TXT, value: value);
  }

  void _emailFieldOnSaved(String value) {
    widget.loginFormModel.email = value;
  }

  void _onFormSubmit() {
    // when form is submitted
    bool formValidation = _loginFormKey.currentState.validate();
    if (formValidation) {
      // if form is valid
      _loginFormKey.currentState.save();
      print(widget.loginFormModel.toString());
      showTextSnackbar(context, "Login Succesfull");
    } else {
      showTextSnackbar(context, "Errors in Login Form");
    }
  }
}
