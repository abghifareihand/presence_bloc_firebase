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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHide = true;

  @override
  void dispose() {
    nipController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Presence App\nRegister",
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
                    /// Text Register
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// NIP
                    CustomTextField(
                      text: 'NIP',
                      hintText: 'your NIP',
                      controller: nipController,
                    ),

                    /// Name
                    CustomTextField(
                      text: 'Name',
                      hintText: 'your name',
                      controller: nameController,
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

                    /// Button Register
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthRegisterLoaded) {
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: AppColor.success,
                            message: "Berhasil register",
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            duration: const Duration(seconds: 3),
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
                          text: state is AuthRegisterLoading
                              ? 'Loading...'
                              : 'Register',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthRegisterEvent(
                                    nip: nipController.text,
                                    name: nameController.text,
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
                          context.pop();
                        },
                        child: Text(
                          "Sudah ada akun ? Login",
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
