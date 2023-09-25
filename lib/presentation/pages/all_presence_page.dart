import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/presentation/widgets/presence_tile.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

class AllPresencePage extends StatelessWidget {
  const AllPresencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Presence'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Search...',
              ),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.all(20),
          //     itemCount: 10,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.only(bottom: 16),
          //         child: InkWell(
          //           onTap: () {
          //             context.pushNamed(Routes.detailPresence);
          //           },
          //           borderRadius: BorderRadius.circular(8),
          //           child: const PresenceTile(),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
