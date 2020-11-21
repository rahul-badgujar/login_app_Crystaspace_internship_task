import 'package:flutter/material.dart';
import 'package:login_app/utils/constants.dart';

// function to show text message snackbar
void showTextSnackbar(BuildContext context, String s) {
  SnackBar snackBar = SnackBar(content: Text(s));
  Scaffold.of(context).showSnackBar(snackBar);
}

void showStatusNotifyingDialog(BuildContext context,
    {@required bool isSuccessed, String message = "No Message"}) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Icon(
            isSuccessed ? Icons.check : Icons.cancel,
            color: isSuccessed
                ? ColorConstants.OPERATION_SUCCESS_COLOR
                : ColorConstants.OPERATION_FAILURE_COLOR,
            size: DimConstants.STATUS_NOTIFIER_DIALOG_ICON_SIZE,
          ),
          children: [
            SimpleDialogOption(
              child: Center(child: Text(message)),
            ),
          ],
        );
      });
}

// widget for submission button of form
class FormSubmitButton extends StatelessWidget {
  final String label;
  final Function onClick;

  const FormSubmitButton(
      {Key key, this.label = StringConstants.DEF_BUTTON_LABEL, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: DimConstants.BUTTON_MARGIN,
      child: ElevatedButton(
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label),
        ),
      ),
    );
  }
}

// widget form input field in form
class FormInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isTextObscure;
  final AutovalidateMode autovalidateMode;
  final Function validator;
  final Function onSaved;
  final TextEditingController controller;

  const FormInputField({
    Key key,
    this.label = StringConstants.DEF_LABEL_TXT,
    this.hint = StringConstants.DEF_HINT_TXT,
    this.isTextObscure = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validator,
    this.onSaved,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isTextObscure,
      decoration: InputDecoration(
        hintText: this.hint,
        labelText: this.label,
      ),
      validator: this.validator,
      onSaved: this.onSaved,
      autovalidateMode: this.autovalidateMode,
      controller: this.controller,
    );
  }
}

// widget form tabbar tab
class TabBarTab extends StatelessWidget {
  final String title;
  const TabBarTab({
    Key key,
    this.title = StringConstants.DEF_TAB_TXT,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DimConstants.TAB_PADDING,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: NumberConstants.TAB_TXT_SIZE,
        ),
      ),
    );
  }
}
