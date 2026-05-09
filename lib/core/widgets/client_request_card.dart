import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'package:intl/intl.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String status;
  final String proffession;
  final DateTime dateTime;
  final String location;
  // final bool isActive;
  //bool callPermissionGranted = false;

  const RequestCard({
    super.key,
    required this.name,
    required this.status,
    required this.proffession,
    required this.dateTime,
    required this.location,
    // this.isActive = true,
    // this.callPermissionGranted = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white24,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: const Color.fromARGB(255, 25, 26, 36),
                        child: Icon(
                          Icons.account_circle,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),

                      // 2. The Status Indicator
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          //color: isActive ? const Color(0xFF4AE176) : const Color(0xFF1A1F31),
                          color: const Color(0xFF4AE176), // The green color
                          shape: BoxShape.circle,
                          // This border creates the "cutout" look from your image
                          border: Border.all(
                            color: const Color(
                              0xFF1A1F31,
                            ), // Match this to your card's background color
                            width: 2.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFFD8E2FF),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'manrope',
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),

                      Text(
                        proffession,
                        style: const TextStyle(
                          color: Color(0xFFC1C6D7),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'inter',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _statusCheck(status),
              ],
            ),

            const SizedBox(height: 18),

            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Color(0xFFC1C6D7),
                      weight: 2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDateTime(dateTime),
                      style: const TextStyle(
                        color: Color(0xFFC1C6D7),
                        fontWeight: FontWeight.normal,
                        fontFamily: 'inter',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFFC1C6D7),
                      weight: 2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFFC1C6D7),
                        fontWeight: FontWeight.normal,
                        fontFamily: 'inter',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF007AFF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFF007AFF), // outline color
                          width: 0.5, // thickness
                        ),
                      ),
                      child: Icon(
                        Icons.phone_in_talk_outlined,
                        // color: callPermissionGranted ? const Color(0xFF007AFF) : const Color(0xFF4AE176),
                        color: Color(0xFF007AFF),
                        size: 16,
                        weight: 2,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB4AB).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFFFB4AB), // outline color
                          width: 0.5, // thickness
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Color(0xFFFFB4AB),
                            size: 16,
                            weight: 2,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Cancle Request',
                            style: const TextStyle(
                              color: Color(0xFFFFB4AB),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'inter',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('MMMM dd, yyyy • hh:mm a');
  return formatter.format(dateTime);
}

Widget _statusCheck(String status) {
  if (status == 'accepted') {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      decoration: BoxDecoration(
        color: const Color(0xFF4AE176).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFF4AE176), // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: Color(0xFF4AE176),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  } else if (status == 'pending') {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      decoration: BoxDecoration(
        color: const Color(0xFFFACC15).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFFFACC15), // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: Color(0xFFFACC15),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      decoration: BoxDecoration(
        color: const Color(0xFFFFB4AB).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color(0xFFFFB4AB), // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: Color(0xFFFFB4AB),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
