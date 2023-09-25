import 'package:flutter/material.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/data/models/user_model.dart';

class DistanceCard extends StatelessWidget {
  final UserModel user;
  const DistanceCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 84,
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: const Text(
                      'Latitude',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Text(
                    '${user.position.lat}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 84,
              decoration: BoxDecoration(
                color: AppColor.primaryExtraSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: const Text(
                      'Longitude',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Text(
                    '${user.position.lng}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       height: 84,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         color: AppColor.primaryExtraSoft,
          //         borderRadius: BorderRadius.circular(8),
          //         image: const DecorationImage(
          //           image: AssetImage('assets/images/map.jpg'),
          //           fit: BoxFit.cover,
          //           opacity: 0.3,
          //         ),
          //       ),
          //       child: const Text(
          //         'Open in maps',
          //         style: TextStyle(fontWeight: FontWeight.w600),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
