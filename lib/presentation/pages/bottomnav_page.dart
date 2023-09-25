import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presence_bloc_firebase/bloc/location/location_bloc.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/presentation/pages/home_page.dart';
import 'package:presence_bloc_firebase/presentation/pages/profile_page.dart';

class BottomnavPage extends StatefulWidget {
  const BottomnavPage({super.key});

  @override
  State<BottomnavPage> createState() => _BottomnavPageState();
}

class _BottomnavPageState extends State<BottomnavPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 8,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      floatingActionButton: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            Flushbar(
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: AppColor.success,
              message: "Berhasil absen",
              icon: const Icon(
                Icons.done,
                size: 28.0,
                color: Colors.white,
              ),
              duration: const Duration(seconds: 3),
            ).show(context);
            // Setelah berhasil absen, ubah status hasCheckedIn menjadi true
          }
          if (state is LocationError) {
            Flushbar(
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: AppColor.error,
              message: "Gagal absen",
              icon: const Icon(
                Icons.error,
                size: 28.0,
                color: Colors.white,
              ),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<LocationBloc>().add(GetLocationEvent());
            },
            backgroundColor: Colors.white,
            child: state is LocationLoading
                ? Icon(
                    Icons.fingerprint,
                    color: AppColor.error,
                    size: 42,
                  )
                : Icon(
                    Icons.fingerprint,
                    color: AppColor.primary,
                    size: 36,
                  ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
