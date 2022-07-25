import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../constants.dart';

class PasswordWidget extends StatefulWidget {
  final TextEditingController passwordContorller;
  final String label;
  final GlobalKey<FormState> formKey;
  final bool withPasswordIndicator;
  final String? comparison;
  bool? insideSignInPage = false;
  bool isObscure;

  PasswordWidget({
    Key? key,
    required this.passwordContorller,
    required this.label,
    required this.formKey,
    required this.withPasswordIndicator,
    this.comparison,
    this.insideSignInPage,
    required this.isObscure,
  }) : super(key: key);

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (password.isEmpty) {
      setState(() {
        passwordStrength = 0;
      });
    } else if (password.length < 6) {
      setState(() {
        passwordStrength = 1 / 4;
      });
    } else if (password.length < 8) {
      setState(() {
        passwordStrength = 2 / 4;
      });
    } else {
      if (passValid.hasMatch(password)) {
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          passwordStrength = 3 / 4;
        });
        print(passwordStrength);
        return false;
      }
    }
    print(passwordStrength);

    return false;
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.subtitle1,
            controller: widget.passwordContorller,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {
              widget.formKey.currentState!.validate();
            },
            obscureText: widget.isObscure,
            decoration: InputDecoration(
              labelText: widget.label,

              helperText: widget.insideSignInPage == true ? "" : "Abd#1234",
              suffixIcon: IconButton(
                icon: Icon(
                  widget.isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else {
                if (true) {
                  bool result = validatePassword(value);
                  if (result) {
                    // create account event'
                    return null;
                  } else if (widget.comparison != null &&
                      widget.passwordContorller.text.toString() !=
                          widget.comparison) {
                    return "Password isn't match";
                  } else {
                    if (widget.insideSignInPage == false) {
                      return " Password should contain Capital, small letter & Number & Special";
                    }
                  }
                }
              }
            },
          ),
          Conditional.single(
            context: context,
            conditionBuilder: (context) => widget.withPasswordIndicator,
            widgetBuilder: (context) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: LinearProgressIndicator(
                value: passwordStrength,
                backgroundColor: Colors.grey[500],
                minHeight: 5,
                color: passwordStrength <= 1 / 4
                    ? Colors.red
                    : passwordStrength == 2 / 4
                        ? Colors.yellow
                        : passwordStrength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
              ),
            ),
            fallbackBuilder: (context) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
