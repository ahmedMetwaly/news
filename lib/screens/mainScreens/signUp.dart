import "dart:io";
import "dart:async";
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/userData.dart';
import '../../model/writeReadDataFormFireBase.dart';
import '../../widgets/emailWidget.dart';
import '../../widgets/nameWidget.dart';
import '../../widgets/passwordWidget.dart';
import '../../widgets/signInWith.dart';

enum ImageSourceType { gallery, camera }

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isObscure = true;
  bool _isValid = false;

  final _form = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _rePassword = TextEditingController();
  final _phoneNumber = TextEditingController();
  final String _imagePath = "assets/images/profilePic.png";
  File? imageFile;
  ScrollController? scrollController;

  void _saveForm() async{
    setState(() {
      _isValid = _form.currentState!.validate();
    });
    if (_isValid) {
      try {
        final user = Users(
          firstName: _firstName.value.text,
          lastName: _lastName.value.text,
          phoneNumber: _phoneNumber.value.text,
          imageUrl: "https://images.app.goo.gl/MWYj6pTgPoUuUNWQ8",
        );
        final Map<String, dynamic> userData = user.userData();

        sendDataToCloud(userData);

        signUp(
          email: _email.value.text,
          password: _password.value.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully registered"),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (error) {
        showDialog(
          context: context,
          builder: (cont) => AlertDialog(
            title: const Text("Ops register is failed"),
            content: Text("${error.message}"),
          ),
        );
      }
    }
  }

  Future getImageFrom(ImageSource type) async {
    try {
      final image = await ImagePicker().pickImage(source: type);
      if (image == null) return;
      var imageTemp = File(image.path);
      setState(() {
        imageFile = imageTemp;
        print("path :${imageFile?.path}");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImage() async {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.2,
      maxHeight: 0.2,
      context: context,
      isSafeArea: true,
      bottomSheetColor: Theme.of(context).scaffoldBackgroundColor,
      isExpand: true,
      builder: (context, scrollController, bottomSheetOffset) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.photo,
                  color: Theme.of(context).appBarTheme.iconTheme?.color),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                getImageFrom(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera,
                  color: Theme.of(context).appBarTheme.iconTheme?.color),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                getImageFrom(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    )
                  : Image.asset(
                      "assets/images/profilePic.png",
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: pickImage,
              child: const Text("Upload Image"),
            ),
            Row(
              children: [
                Expanded(
                  child: defaultTextInput(
                    controller: _firstName,
                    labelText: "First name",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: defaultTextInput(
                      labelText: "Last name", controller: _lastName),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            defaultTextInput(
              labelText: "Phone Number ",
              controller: _phoneNumber,
              keyBoardType: TextInputType.number,
              hintText: "01234567891",
            ),
            const SizedBox(
              height: 10,
            ),
            Email(controller: _email),
            const SizedBox(
              height: 10,
            ),
            PasswordWidget(
              passwordContorller: _password,
              label: "Password",
              formKey: _form,
              withPasswordIndicator: true,
              isObscure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            PasswordWidget(
              passwordContorller: _rePassword,
              label: "Re-password",
              formKey: _form,
              withPasswordIndicator: true,
              isObscure: true,
              comparison: _password.text.toString(),
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
                  "Sign Up",
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const Text(
              "Or sign up with",
              style: TextStyle(fontSize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SignInOrUpWith(
                  imagePath: "assets/images/google.png",
                ),
                SignInOrUpWith(
                  imagePath: "assets/images/Facebook_Logo.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
