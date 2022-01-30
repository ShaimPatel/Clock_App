import 'package:clock_app/screen/home_page.dart';
import 'package:clock_app/screen/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('User').snapshots();
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  //! There Are Code of registration..
  final _formKey = GlobalKey<FormState>();
  bool agree = false;

  var username = '';
  var email = '';
  var password = '';
  var phonenumber = '';

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  TextStyle defaultStyle =
      GoogleFonts.workSans(color: Colors.grey, fontSize: 15.0);
  TextStyle linkStyle = GoogleFonts.workSans(color: Colors.blue);

  //RegisterUser
  CollectionReference addstd = FirebaseFirestore.instance.collection('User');
  Future<void> addUser() {
    // print('User Added');
    return addstd
        .add({
          'name': username,
          'email': email,
          'password': password,
          'contactno': phonenumber
        })
        // ignore: avoid_print
        .then((value) => print('User are added..!'))
        // ignore: avoid_print
        .catchError((error) => print("Feaild : $error"));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  //! Celar All feild's..!
  clearText() {
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
  }

  //! There Are Starting AppBar..
  var appbar = AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 110,
    title: const Text('SIGN UP'),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          color: HexColor("#013334")),
    ),
  );
// End Of The AppBar...
  @override
  Widget build(BuildContext context) {
    var allheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar,
      body: SizedBox(
        height: allheight - appbar.preferredSize.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Create your account",
                  style: GoogleFonts.workSans(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        cursorColor: HexColor("#013334"),
                        controller: _usernameController,
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: HexColor("#013334"),
                            ),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _usernameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                        ),
                      ),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: UnderlineInputBorder(),
                        ),
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _passwordController.text = value!;
                        },
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                        ),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Contact Number',
                          border: UnderlineInputBorder(),
                        ),
                        style: GoogleFonts.workSans(
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Contact number';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: HexColor("#013334"),
                      checkColor: Colors.white,
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    Expanded(
                      flex: 2,
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          style: defaultStyle,
                          children: <TextSpan>[
                            const TextSpan(
                                text:
                                    'By creating an account , you agree to the '),
                            TextSpan(
                                style: linkStyle,
                                text: 'Terms ',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // print('Terms of Service"');
                                  }),
                            const TextSpan(text: ' and  '),
                            TextSpan(
                              text: 'Condoition ',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // print('Privacy Policy"');
                                },
                            ),
                            const TextSpan(text: 'and '),
                            TextSpan(
                              text: 'Privacy Policy ',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // print('Privacy Policy"');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.0,
                    minWidth: MediaQuery.of(context).size.width * 0.10,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#013334"),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      signUp(_emailController.text, _passwordController.text);
                    },
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.workSans(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.0,
                      minWidth: MediaQuery.of(context).size.width * 0.20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.workSans(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/loginPage');
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.workSans(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = _usernameController.text;
    userModel.password = _passwordController.text;
    userModel.phonenumber = _phoneController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }
}
