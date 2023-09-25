import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence_bloc_firebase/common/constants.dart';
import 'package:presence_bloc_firebase/presentation/pages/detail_presence_page.dart';

class PresenceTile extends StatelessWidget {
  final Map<String, dynamic> data;

  const PresenceTile({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPresencePage(presenceData: data),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: AppColor.primaryExtraSoft,
            ),
          ),
          padding:
              const EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn("check in", data["masuk"]),
              const SizedBox(width: 24),
              _buildTimeColumn("check out", data["keluar"]),
              _buildDateText(data["date"]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, Map<String, dynamic>? timeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 6),
        Text(
          timeData == null
              ? "-"
              : DateFormat.jm().format(
                  DateTime.parse(
                    timeData["date"],
                  ),
                ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDateText(String date) {
    return Text(
      DateFormat.yMMMMEEEEd().format(
        DateTime.parse(
          date,
        ),
      ),
      style: TextStyle(
        fontSize: 10,
        color: AppColor.secondarySoft,
      ),
    );
  }
}
