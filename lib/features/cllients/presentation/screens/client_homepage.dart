import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/glass_card.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  TextEditingController searchController = TextEditingController();
  int index = 0;
  final List<Map<String, dynamic>> workers = [
    {
      "name": "Naomi M",
      "location": "Megenagna",
      "role": "Master Plumber",
      "rating": 4.8,
      "description": "Master of pipes, pressure, and precision",
      "isSaved": false,
    },
    {
      "name": "Kaleab M",
      "location": "Mexico",
      "role": "Programmer",
      "rating": 4.8,
      "description": "Website developer, maintainer, and tech specialist",
      "isSaved": true,
    },
  ];
  final List<Map<String, dynamic>> topRated = [
    {"name": "Saron K", "loc": "Bole", "role": "Master Plumber", "rate": 4.9},
    {"name": "Abel T", "loc": "Kazanchis", "role": "Electrician", "rate": 4.8},
    {"name": "Miki L", "loc": "Piassa", "role": "Painter", "rate": 4.7},
  ];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle, size: 32),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                hintText: "Hinted search text",
                hintStyle: const TextStyle(color: Colors.grey),

                suffixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 201, 200, 200),
                ),

                filled: true,
                fillColor: const Color.fromARGB(255, 23, 47, 83),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildCategoryChip("ALL SERVICES", isSelected: true),

                _buildCategoryChip("PLUMBING"),

                _buildCategoryChip("ELECTRICIAN"),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOP RATED NEAR YOU',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "SEE ALL",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Top Rated Card (Horizontal or Single Large)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: topRated.map((item) {
                  return _buildTopRatedCard(
                    name: item["name"],
                    loc: item["loc"],
                    role: item["role"],
                    rate: item["rate"],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'AVAILABLE WORKERS',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            // List of available workers
            ...workers.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> worker = entry.value;
              return ServiceCard(
                name: worker['name'],
                location: worker['location'],
                role: worker['role'],
                rating: worker['rating'],
                description: worker['description'],
                isSaved: worker['isSaved'],
                onSaveToggle: () {
                  setState(() {
                    workers[index]['isSaved'] = !workers[index]['isSaved'];
                  });
                },
                onBookNow: () {
                  // Logic for booking
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Booking ${worker['name']}...")),
                  );
                },
              );
            }),
            const SizedBox(height: 100), // Padding for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/client/home');
        break;

      case 1:
        context.go('/client/requests');
        break;

      case 2:
        context.go('/client/profile');
        break;
    }
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(right: 16), // Adds spacing for selected chip
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA6C8FF) : const Color(0xFF1C222E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTopRatedCard({
    required String name,
    required String loc,
    required role,
    required rate,
  }) {
    return GlassCard(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      margin: EdgeInsets.only(right: 24),
      child: Row(
        children: [
          const CircleAvatar(radius: 30, backgroundColor: Colors.grey),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                    weight: 0.5,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    loc,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              Text('$role •', style: const TextStyle(color: Colors.white70)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amberAccent, size: 16),
                  SizedBox(width: 5),
                  Text('$rate', style: const TextStyle(color: Colors.white70)),
                  SizedBox(width: 32),
                  Text(
                    "AVAILABLE NOW",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
