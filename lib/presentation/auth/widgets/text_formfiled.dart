import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.labelText = '',
    this.isNumber = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isPassword = false,
    this.isCard = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isNumber;
  final bool isEmail;
  final bool isPassword;
  final bool isPhone;
  final bool isCard;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      cursorColor: Colors.black,
      onChanged: (_) => setState(() {}),
      maxLength: widget.isNumber ? 15 : 40,
      readOnly: false,
      enableInteractiveSelection: true,
      keyboardType: widget.isNumber
          ? TextInputType.number
          : widget.isPhone
              ? TextInputType.phone
              : widget.isEmail
                  ? TextInputType.emailAddress
                  : TextInputType.text,
      enabled: true,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      keyboardAppearance: Brightness.light,
      decoration: widget.isPassword
          ? fieldDecoration(widget.labelText).copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade300,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            )
          : widget.isEmail
              ? fieldDecoration(widget.labelText)
                  .copyWith(suffix: Icon(Icons.check, color: Colors.grey.shade300,))
              : fieldDecoration(widget.labelText),
    );
  }

  String? get validator {
    final validation = Validation();
    bool isValid = true;
    final text = widget.controller.value.text.toString();

    if (widget.isEmail) {
      isValid = validation.validateEmail(widget.controller.text.toString());
      if (!isValid) {
        return 'Enter Valid Email';
      }
    }
    return null;
  }

  InputDecoration fieldDecoration(String labelText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
      errorText: validator,
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      focusColor: Colors.blue,
      labelText: labelText,
      //hintText: labelText,
      counterText: '',
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.blue, width: 0.8),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.blue, width: 0.8),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 0.8),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.blue, width: 0.8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.8),
      ),
    );
  }
}

InputDecoration fieldDecoration(String labelText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
    errorStyle: const TextStyle(
      fontSize: 12,
      color: Colors.red,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.5),
    focusColor: Colors.blue,
    counterText: '',
    // labelText: labelText,
    hintText: labelText,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      borderSide: BorderSide(color: Colors.blue, width: 0.8),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      borderSide: BorderSide(color: Colors.blue, width: 0.8),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      borderSide: BorderSide(width: 0.8),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
      borderSide: BorderSide(color: Colors.blue, width: 0.8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(2)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.8),
    ),
  );
}

class Validation {
  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePhone(String value) {
    Pattern pattern = r"^[7|9][0-9]{8}$";
    RegExp regex = RegExp(pattern.toString());
    if (regex.hasMatch(value.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
