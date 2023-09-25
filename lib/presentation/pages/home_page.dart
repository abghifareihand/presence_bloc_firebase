import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:presence_bloc_firebase/bloc/user/user_bloc.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/data/models/user_model.dart';
import 'package:presence_bloc_firebase/presentation/widgets/distance_card.dart';
import 'package:presence_bloc_firebase/presentation/widgets/presence_card.dart';
import 'package:presence_bloc_firebase/presentation/widgets/presence_tile.dart';
import 'package:presence_bloc_firebase/routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: StreamBuilder<UserModel>(
        stream: userBloc.datasource.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final user = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      /// Image
                      ClipOval(
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Image.network(
                            "https://ui-avatars.com/api/?name=${user!.name}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),

                      /// Welcome
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "welcome back",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.secondarySoft,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      /// Jam realtime
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: StreamBuilder<int>(
                          stream: Stream.periodic(
                              const Duration(seconds: 1), (i) => i),
                          builder: (context, snapshot) {
                            final now = DateTime.now();
                            final formattedTime =
                                DateFormat('hh:mm:ss a').format(now);
                            return Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                /// Card presence
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: userBloc.datasource.streamTodayPresence(),
                  builder: (context, snapshot) {
                    Map<String, dynamic>? todayData = snapshot.data?.data();
                    return PresenceCard(
                      user: user,
                      todayData: todayData,
                    );
                  },
                ),

                /// Last location
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 24, left: 4),
                  child: Text(
                    user.address.isNotEmpty ? user.address : "Belum ada lokasi",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),

                /// Distance map
                DistanceCard(user: user),

                /// History
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Presence History",
                      style: TextStyle(
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.allPresence);
                      },
                      style: TextButton.styleFrom(),
                      child: const Text("show all"),
                    ),
                  ],
                ),

                // Presence Tile
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: userBloc.datasource.streamLastPresence(),
                  builder: (context, snapshotPresence) {
                    if (snapshotPresence.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshotPresence.hasData &&
                        snapshotPresence.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshotPresence.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snapshotPresence.data!.docs[index].data();
                          return PresenceTile(data: data);
                        },
                      );
                    } else {
                      // Tampilkan teks jika data kosong
                      return const Center(
                        child: Text(
                          'Belum ada absen',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }
          return const Center(
            child: Text('Error Data Cek Internet'),
          );
        },
      ),
    );
  }
}
