// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailor_shop/components/my_button.dart';
import 'package:tailor_shop/components/my_text_form.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_aleart_dialog.dart';
import '../components/my_dialog_box.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void login() async {
      showDialog(context: context, builder: (context) => const MyDialogBox());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        if (context.mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        myAleartDialog(e.code, context);
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 210, 214),
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: 900,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 153, 243, 255),
                      blurRadius: 8,
                      offset: Offset(2, 7),
                    ),
                  ],
                ),
                child: constraints.maxWidth > 600
                    ? Row(
                        children: [
                          SizedBox(
                            height: 320,
                            child: Image.asset("lib/images/muslimah.png")),
                         
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Tailor Shop",
                                      style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyTextForm(
                                    labeltext: "Email",
                                    controller: email,
                                    icon: const Icon(Icons.mail),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyTextForm(
                                      labeltext: "Password",
                                      controller: password,
                                      obscureText: true,
                                      icon: const Icon(Icons.lock)),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  MyButton(
                                    text: "Login",
                                    height: 50,
                                    color: Colors.cyan,
                                    fontsize: 18,
                                    icon: Icons.login,
                                    textcolor: Colors.white,
                                    buttonBlur: 0.5,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                       login();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          const CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage("lib/images/muslimah.png"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Tailor Shop",
                                    style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan)),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyTextForm(
                                  labeltext: "Email",
                                  controller: email,
                                  icon: const Icon(Icons.mail),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyTextForm(
                                    labeltext: "Password",
                                    controller: password,
                                    obscureText: true,
                                    icon: const Icon(Icons.lock)),
                                const SizedBox(
                                  height: 12,
                                ),
                                MyButton(
                                  text: "Login",
                                  height: 50,
                                  color: Colors.cyan,
                                  fontsize: 18,
                                  icon: Icons.login,
                                  textcolor: Colors.white,
                                  buttonBlur: 0.5,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

