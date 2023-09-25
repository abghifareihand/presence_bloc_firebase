import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:presence_bloc_firebase/bloc/auth/auth_bloc.dart';
import 'package:presence_bloc_firebase/bloc/user/user_bloc.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/data/models/user_model.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 36),
        children: [
          const SizedBox(height: 16),
          // section 1 - profile
          StreamBuilder<UserModel>(
              stream: userBloc.datasource.streamUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final user = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 124,
                        height: 124,
                        color: Colors.blue,
                        child: Image.network(
                          "https://ui-avatars.com/api/?name=${user!.name}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      user.role,
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ],
                );
              }),
          // section 2 - menu
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 42),
            child: Column(
              children: [
                MenuTile(
                  title: 'Update Profile',
                  icon: SvgPicture.asset(
                    'assets/icons/profile-1.svg',
                  ),
                  onTap: () {
                    context.pushNamed(Routes.editProfile);
                  },
                ),
                MenuTile(
                  title: 'Add Employee',
                  icon: SvgPicture.asset(
                    'assets/icons/people.svg',
                  ),
                  onTap: () {},
                ),
                MenuTile(
                  title: 'Change Password',
                  icon: SvgPicture.asset(
                    'assets/icons/password.svg',
                  ),
                  onTap: () {},
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLogoutLoaded) {
                      Flushbar(
                        margin: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(8),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: AppColor.success,
                        title: 'Success',
                        message: "Berhasil logout",
                        icon: const Icon(
                          Icons.done,
                          size: 28.0,
                          color: Colors.white,
                        ),
                      ).show(context);
                      context.goNamed(Routes.login);
                    }
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColor.error,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return MenuTile(
                      isDanger: true,
                      title: state is AuthLogoutLoading
                          ? 'Loading...'
                          : 'Sign Out',
                      icon: SvgPicture.asset(
                        'assets/icons/logout.svg',
                      ),
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogoutEvent());
                      },
                    );
                  },
                ),
                Container(
                  height: 1,
                  color: AppColor.primaryExtraSoft,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.secondaryExtraSoft,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(right: 24),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color:
                      (isDanger == false) ? AppColor.secondary : AppColor.error,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                color:
                    (isDanger == false) ? AppColor.secondary : AppColor.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
