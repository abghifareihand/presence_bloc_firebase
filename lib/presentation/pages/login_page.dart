import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:presence_bloc_firebase/bloc/auth/auth_bloc.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/presentation/widgets/custom_button.dart';
import 'package:presence_bloc_firebase/presentation/widgets/custom_text_field.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHide = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/pattern-1-1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Presence App\nLogin",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontFamily: 'poppins',
                        height: 150 / 100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// Email
                    CustomTextField(
                      text: 'Email',
                      hintText: 'youremail@gmail.com',
                      controller: emailController,
                    ),

                    /// Password
                    CustomTextField(
                      text: 'Password',
                      hintText: '**********',
                      isObscureText: isHide,
                      controller: passwordController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: SvgPicture.asset(
                          isHide
                              ? 'assets/icons/hide.svg'
                              : 'assets/icons/show.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),

                    /// Button Login
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoginLoaded) {
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: AppColor.success,
                            title: 'Success',
                            message: "Berhasil login",
                            icon: const Icon(
                              Icons.done,
                              size: 28.0,
                              color: Colors.white,
                            ),
                          ).show(context);
                          context.goNamed(Routes.navbar);
                        }
                        if (state is AuthError) {
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: AppColor.error,
                            message: state.message,
                            icon: const Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text: state is AuthLoginLoading
                              ? 'Loading...'
                              : 'Login',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                        );
                      },
                    ),

                    // Text button
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      alignment: Alignment.topCenter,
                      child: TextButton(
                        onPressed: () {
                          context.pushNamed(Routes.register);
                        },
                        child: Text(
                          "Belum ada akun ? Register",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: AppColor.secondarySoft,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
