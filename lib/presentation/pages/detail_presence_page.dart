import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence_bloc_firebase/common/constants.dart';

class DetailPresencePage extends StatelessWidget {
  final Map<String, dynamic> presenceData;
  const DetailPresencePage({
    super.key,
    required this.presenceData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Presence'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          /// Check in
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'check in',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          presenceData["masuk"] == null
                              ? "-"
                              : DateFormat.jm().format(
                                  DateTime.parse(
                                    presenceData["masuk"]["date"],
                                  ),
                                ),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(presenceData["date"])),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'status',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["masuk"]?["status"] == true)
                      ? "In area presence"
                      : "Outside area presence",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                const Text(
                  'distance',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${presenceData['masuk']['distance'].toString().split('.').first} meter',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                const Text(
                  'address',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  presenceData["masuk"] == null
                      ? "-"
                      : "${presenceData["masuk"]["address"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          /// Check out
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'check out',
                          style: TextStyle(color: AppColor.secondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          presenceData["keluar"] == null
                              ? "-"
                              : DateFormat.jm().format(
                                  DateTime.parse(
                                    presenceData["keluar"]["date"],
                                  ),
                                ),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(presenceData["date"])),
                      style: TextStyle(color: AppColor.secondary),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'status',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  (presenceData["keluar"]?["status"] == true)
                      ? "In area presence"
                      : "Outside area presence",
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'distance',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  '${presenceData['masuk']['distance'].toString().split('.').first} meter',
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Text(
                  'address',
                  style: TextStyle(color: AppColor.secondary),
                ),
                const SizedBox(height: 4),
                Text(
                  presenceData["keluar"] == null
                      ? "-"
                      : "${presenceData["keluar"]["address"]}",
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
