import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class RequestCard extends StatelessWidget {
  final String name;
  final String status;
  final String proffession;
  final DateTime dateTime;
  final String location;

  const RequestCard({
    super.key,
    required this.name,
    required this.status,
    required this.proffession,
    required this.dateTime,
    required this.location,
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
                  backgroundColor: AppColors.requestAvatarBackground,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.requestAvatarCircle,
                        child: Icon(
                          Icons.account_circle,
                          size: 64,
                          color: AppColors.requestAvatarIcon,
                        ),
                      ),

                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: AppColors.requestBoxDecorationBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.requestBoxDecorationBorder,
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
                      Text(name, style: AppTextStyles.cardTitle),
                      const SizedBox(width: 8),

                      Text(proffession, style: AppTextStyles.cardSub),
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
                      color: AppColors.iconColor,
                      weight: 2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDateTime(dateTime),
                      style: AppTextStyles.cardSub,
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.iconColor,
                      weight: 2,
                    ),
                    const SizedBox(width: 8),
                    Text(location, style: AppTextStyles.cardSub),
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
                        color: AppColors.reaedyToCall.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.reaedyToCall, // outline color
                          width: 0.5, // thickness
                        ),
                      ),
                      child: Icon(
                        Icons.phone_in_talk_outlined,
                        // color: callPermissionGranted ? const Color(0xFF007AFF) : const Color(0xFF4AE176),
                        color: AppColors.reaedyToCall,
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
                        color: AppColors.notReady.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.notReady, // outline color
                          width: 0.5, // thickness
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.notReady,
                            size: 16,
                            weight: 2,
                          ),
                          const SizedBox(width: 8),
                          Text('Cancle Request', style: AppTextStyles.notReady),
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
        color: AppColors.successBright.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.successBright, // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: AppColors.successBright,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  } else if (status == 'pending') {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.warning, // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: AppColors.warning,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  } else {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      decoration: BoxDecoration(
        color: AppColors.notReady.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.notReady, // outline color
          width: 0.5, // thickness
        ),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: AppColors.notReady,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
