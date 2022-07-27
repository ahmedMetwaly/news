import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/cubit/appcCubit.dart';
import 'package:news_app/screens/mainScreens/signUp.dart';
import '../../widgets/emailWidget.dart';
import '../../widgets/passwordWidget.dart';
import '../../widgets/signInWith.dart';
import 'home.dart';
import '../../model/writeReadDataFormFireBase.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isValid = false;

  void _saveForm() {
    setState(() async {
      _isValid = _form.currentState!.validate();
      if (_isValid) {
        try {
          signIn(
            email: _emailController.value.text,
            password: _passwordController.value.text,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Signed In Successfully",
                style: TextStyle(color: Colors.white),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } on FirebaseAuthException catch (error) {
          showDialog(
            context: context,
            builder: (cont) => AlertDialog(
              title: const Text("Ops sign in is failed"),
              content: Text("${error.message}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "ok",
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  'https://firebasesorage.googleapis.com/v0/b/newsapp-1e98c.appspot.com/o/nbc-social-default.png?alt=media&token=cf8625bf-e5fa-41db-bb7b-282cb1777365',
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        color: Theme.of(context).appBarTheme.iconTheme?.color,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      "assets/images/nbc-social-default.png",
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Sign In",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Email(controller: _emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordWidget(
                    isObscure: true,
                    formKey: _form,
                    label: "Password",
                    passwordContorller: _passwordController,
                    withPasswordIndicator: false,
                    insideSignInPage: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: _saveForm,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.iconTheme?.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Or sign in with",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SignInOrUpWith(
                    imagePath: "assets/images/google.png",
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          AppCubit.navTo(context, const SignUp());
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(
                            color:
                                Theme.of(context).appBarTheme.iconTheme?.color,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import "../../model/writeReadDataFormFireBase.dart";
//
// class SignIn extends StatelessWidget {
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: ()async{ await signInWithGoogle();},
//           child: Text("Sign In"),
//         ),
//       ),
//     );
//   }
// }
