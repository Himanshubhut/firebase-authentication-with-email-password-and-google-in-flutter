import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? ispasswordfield;
  final String? hintText;
  final String? lebalText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onfieldsubmitted;
  final TextInputType? inputType;
  const FormContainer(
      {super.key,
      this.controller,
      this.fieldkey,
      this.ispasswordfield,
      this.hintText,
      this.lebalText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onfieldsubmitted,
      this.inputType});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.blueAccent),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldkey,
        obscureText: widget.ispasswordfield == true ? _obscureText : false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onfieldsubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black38),
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.ispasswordfield == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText == false
                          ? Colors.blueAccent
                          : Colors.brown,
                    )
                  : Text('')),
        ),
      ),
    );
  }
}
