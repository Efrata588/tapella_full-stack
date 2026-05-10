import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final String location;
  final String role;
  final double rating;
  final String description;
  final bool isSaved;
  final VoidCallback onSaveToggle;
  final VoidCallback onBookNow;

  const ServiceCard({
    super.key,
    required this.name,
    required this.location,
    required this.role,
    required this.rating,
    required this.description,
    required this.isSaved,
    required this.onSaveToggle,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 32, backgroundColor: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFFDAE2FD),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'manrope',
                        height: 28 / 18,
                        letterSpacing: 0,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Color(0xFFC1C6D7),
                          weight: 0.3,
                        ),
                        SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(color: Color(0xFFC1C6D7)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          "$role •",
                          style: const TextStyle(
                            color: Color(0xFFC1C6D7),
                            fontFamily: 'inter',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            height: 20 / 14,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.star, color: Colors.amberAccent, size: 16),
                        SizedBox(width: 5),
                        Text(
                          '$rating',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onSaveToggle,
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: isSaved ? Colors.blue : Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onBookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA6C8FF),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

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
            ],
          ),
        ],
      ),
    );
  }
}
