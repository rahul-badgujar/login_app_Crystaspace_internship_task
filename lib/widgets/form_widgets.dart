import 'package:flutter/material.dart';

void showTextSnackbar(BuildContext context, String s) {
  SnackBar snackBar = SnackBar(content: Text(s));
  Scaffold.of(context).showSnackBar(snackBar);
}

class FormSubmitButton extends StatelessWidget {
  final String label;
  final Function onClick;

  const FormSubmitButton({Key key, this.label = "Click", this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
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

class FormInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isTextObscure;
  final AutovalidateMode autovalidateMode;
  final Function validator;
  final Function onSaved;

  const FormInputField({
    Key key,
    this.label = "Label",
    this.hint = "Hint",
    this.isTextObscure = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.validator,
    this.onSaved,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: this.hint,
        labelText: this.label,
      ),
      validator: this.validator,
      onSaved: this.onSaved,
      autovalidateMode: this.autovalidateMode,
    );
  }
}

Widget TabBarTab(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
