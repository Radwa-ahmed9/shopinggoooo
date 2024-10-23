import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_app/components/custombuttonauth.dart';
import 'package:store_app/components/customlogoauth.dart';
import 'package:store_app/components/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:store_app/screens/Verified _Email.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 50),
                const CustomLogoAuth(),
                Container(height: 20),
                const Text("Login",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Container(height: 10),
                const Text("Login To Continue Using The App",
                    style: TextStyle(color: Colors.grey)),
                Container(height: 20),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: email,
                  validator: (val) {
                    if (val == "") {
                      return "Can't To be Empty";
                    }
                  },
                ),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: password,
                  validator: (val) {
                    if (val == "") {
                      return "Can't To be Empty";
                    }
                  },
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == "") {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc:
                            'الرجاء كتابة البريد الالكتروني ثم قم بالضغط علي Forget Password',
                      ).show();
                      return;
                    }
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc:
                            'لقد تم ارسال لينك لاعادة تعيين كلمة المرور الي بريدك الالكتروني الرجاء الذهاب الي البريد والضغط علي ال اللينك',
                      ).show();
                    } catch (e) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc:
                            'الرجاء التأكد من أن البريد الالكتروني الذي ادخلته صحيح ثم قم باعادة المحاولة',
                      ).show();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "login",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                    if (credential.user!.emailVerified &&
                        credential.user!.email == "nr1413@fayoum.edu.eg") {
                      ///////////////////
                      Navigator.of(context).pushReplacementNamed("homepage");
                    } else if (credential.user!.emailVerified &&
                        credential.user!.email != "nr1413@fayoum.edu.eg") {
                      ///////////////////
                      Navigator.of(context).pushReplacementNamed("HomeScreen");
                    } else {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc:
                            'الرجاء التوجه علي بريدك الالكتروني والضغط علي لينك التحقق من البريد حتي يتم تفعيل حسابك',
                      ).show();
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'No user found for that email.',
                      ).show();
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'Wrong password provided for that user.',
                      ).show();
                    }
                  }
                } else {
                  print("Not Valid");
                }
              }), ////////////////////////////////////////////////////////////////////////////////////////////
          Container(height: 20),

          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {
                signInWithGoogle();
              }, ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 20,
                  )
                ],
              )),
          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Navigator.of(context)
                  .pushReplacementNamed("signup"); //////////////////////
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
