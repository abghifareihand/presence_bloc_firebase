import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_bloc_firebase/bloc/auth/auth_bloc.dart';
import 'package:presence_bloc_firebase/bloc/cubit/page_cubit.dart';
import 'package:presence_bloc_firebase/bloc/location/location_bloc.dart';
import 'package:presence_bloc_firebase/bloc/user/user_bloc.dart';
import 'package:presence_bloc_firebase/data/datasources/auth_datasource.dart';
import 'package:presence_bloc_firebase/data/datasources/location_datasource.dart';
import 'package:presence_bloc_firebase/data/datasources/user_datasource.dart';
import 'package:presence_bloc_firebase/firebase_options.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => BottomNavCubit(),
        // ),
        BlocProvider(
          create: (context) => AuthBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationDatasource()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserDatasource()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
