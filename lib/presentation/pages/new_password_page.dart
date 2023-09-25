// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:presence_bloc_firebase/bloc/login/login_bloc.dart';
// import 'package:presence_bloc_firebase/routes/router.dart';

// class NewPasswordPage extends StatefulWidget {
//   const NewPasswordPage({super.key});

//   @override
//   State<NewPasswordPage> createState() => _NewPasswordPageState();
// }

// class _NewPasswordPageState extends State<NewPasswordPage> {
//   TextEditingController newPasswordController = TextEditingController();

//   @override
//   void dispose() {
//     newPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Password'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           TextFormField(
//             autocorrect: false,
//             obscureText: true,
//             controller: newPasswordController,
//             decoration: InputDecoration(
//               labelText: 'New Password',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             onPressed: () {
//               context.read<LoginBloc>().add(
//                     NewPasswordEmployee(
//                       password: newPasswordController.text,
//                     ),
//                   );
//             },
//             child: BlocConsumer<LoginBloc, LoginState>(
//               listener: (context, state) {
//                 if (state is NewPasswordLoaded) {
//                   context.goNamed(Routes.home);
//                 }
//               },
//               builder: (context, state) {
//                 return Text(
//                   state is NewPasswordLoading ? 'Loading...' : 'Continue',
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
