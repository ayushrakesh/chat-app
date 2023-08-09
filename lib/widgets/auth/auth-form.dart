import 'dart:io';
import 'package:chat_app/widgets/login_now.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import './pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function submitForm;
  final bool isLoading;

  AuthForm(this.submitForm, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  File? userImageFile;
  var isLogin = true;

  var scale = 1.0;

  void pickImgFn(File image) {
    userImageFile = image;
  }

  void trySubmit() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (userImageFile == null && !isLogin) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please pick an image',
            style: TextStyle(
              letterSpacing: 0.5,
            ),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    }

    if (isValid) {
      formKey.currentState!.save();
      widget.submitForm(
        userEmail.trim(),
        userName.trim(),
        userPassword.trim(),
        userImageFile,
        isLogin,
        context,
        // context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.02,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisSize: MainAxisSize.min,
              children: [
                if (isLogin) LoginNow(),
                AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 3000,
                  ),
                  child: UserImagePicker(pickImgFn),
                  height: isLogin ? 0 : height * 0.24,
                  // curve: Curves.easeInOutCirc,
                ),
                Gap(height * 0.02),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email-address';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // labelText: 'Email Address',
                    hintText: "Email Address",
                    hintStyle: const TextStyle(letterSpacing: 0.6),
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withRed(1),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onSaved: (value) {
                    userEmail = value!;
                  },
                ),
                Gap(height * 0.02),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Username should be at least 4 characters long.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      // labelText: 'Username',
                      hintText: 'Username',
                      hintStyle: const TextStyle(letterSpacing: 0.6),
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor.withRed(1),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSaved: (value) {
                      userName = value!;
                    },
                  ),
                Gap(height * 0.02),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password should be at least 7 characters long.';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    // labelText: 'Password',
                    hintText: 'Password',
                    hintStyle: const TextStyle(letterSpacing: 0.6),
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withRed(1),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) {
                    userPassword = value!;
                  },
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                if (widget.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (!widget.isLoading)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 5,
                      shadowColor: Colors.pink.shade100,
                      primary:
                          Theme.of(context).buttonTheme.colorScheme?.secondary,
                      padding: (EdgeInsets.symmetric(
                        vertical: height * 0.024,
                        horizontal: width * 0.36,
                      )),
                    ),
                    onPressed: trySubmit,
                    child: !isLogin
                        ? const Text(
                            'SIGNUP',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.6),
                          )
                        : const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.6),
                          ),
                  ),
                Gap(height * 0.04),
                if (!widget.isLoading)
                  isLogin
                      ? Row(
                          children: [
                            Spacer(),
                            const Text(
                              'Dont\'t have an account!',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    isLogin = !isLogin;
                                  },
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    letterSpacing: 0.4,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Spacer(),
                          ],
                        )
                      : Row(
                          children: [
                            Spacer(),
                            const Text(
                              'I already have an account!',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(
                                  () {
                                    isLogin = !isLogin;
                                  },
                                );
                              },
                              child: Text(
                                'Login here',
                                style: TextStyle(
                                    letterSpacing: 0.4,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
