import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/data/models/user_model.dart';

class PresenceCard extends StatelessWidget {
  final UserModel user;
  final Map<String, dynamic>? todayData;
  const PresenceCard({
    super.key,
    required this.user,
    required this.todayData,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 24,
        top: 24,
        right: 24,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage('assets/images/pattern-1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // job
          Text(
            user.role,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          //  Employee ID
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              user.nip,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          // check in - check out box
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.primarySoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                //  check in
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: const Text(
                          "check in",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        todayData?["masuk"] == null
                            ? "-"
                            : DateFormat.jms().format(
                                DateTime.parse(
                                  todayData!["masuk"]["date"],
                                ),
                              ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 24,
                  color: Colors.white,
                ),
                // check out
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: const Text(
                          "check out",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        todayData?["keluar"] == null
                            ? "-"
                            : DateFormat.jms().format(
                                DateTime.parse(
                                  todayData!["keluar"]["date"],
                                ),
                              ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
