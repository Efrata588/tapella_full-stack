import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import '../../../../core/widgets/client_request_card.dart';
import '../../../../core/widgets/bottom_navbar.dart';

class ClientRequestpage extends StatefulWidget {
  const ClientRequestpage({super.key});

  @override
  State<ClientRequestpage> createState() => _ClientRequestpageState();
}

class _ClientRequestpageState extends State<ClientRequestpage> {
  String selectedTab = 'All';

  List<Widget> requestCards = [
    RequestCard(
      name: 'Alana Smith',
      status: 'accepted',
      proffession: 'Student',
      dateTime: DateTime.now(),
      location: 'New York',
    ),

    RequestCard(
      name: 'Michael Johnson',
      status: 'pending',
      proffession: 'Software Engineer',
      dateTime: DateTime.now(),
      location: 'California',
    ),

    RequestCard(
      name: 'Sophia Brown',
      status: 'rejected',
      proffession: 'UI/UX Designer',
      dateTime: DateTime.now(),
      location: 'Chicago',
    ),

    RequestCard(
      name: 'Daniel Wilson',
      status: 'accepted',
      proffession: 'Doctor',
      dateTime: DateTime.now(),
      location: 'Boston',
    ),

    RequestCard(
      name: 'Emma Davis',
      status: 'pending',
      proffession: 'Teacher',
      dateTime: DateTime.now(),
      location: 'Seattle',
    ),

    RequestCard(
      name: 'James Miller',
      status: 'rejected',
      proffession: 'Photographer',
      dateTime: DateTime.now(),
      location: 'Miami',
    ),

    RequestCard(
      name: 'Olivia Taylor',
      status: 'accepted',
      proffession: 'Architect',
      dateTime: DateTime.now(),
      location: 'Houston',
    ),

    RequestCard(
      name: 'William Anderson',
      status: 'pending',
      proffession: 'Lawyer',
      dateTime: DateTime.now(),
      location: 'Denver',
    ),

    RequestCard(
      name: 'Ava Thomas',
      status: 'rejected',
      proffession: 'Nurse',
      dateTime: DateTime.now(),
      location: 'Atlanta',
    ),

    RequestCard(
      name: 'Benjamin Moore',
      status: 'accepted',
      proffession: 'Data Analyst',
      dateTime: DateTime.now(),
      location: 'San Francisco',
    ),
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
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  height: 1.7,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'TRACK AND MANAGE YOUR SERVICE ORDERS',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  height: 1.7,
                  letterSpacing: 0.35,
                ),
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  _buildTab('All'),
                  _buildTab('Accepted'),
                  _buildTab('Pending'),
                  _buildTab('Rejected'),
                ],
              ),
              SizedBox(height: 16),

              Expanded(
                child: ListView.separated(
                  itemCount: requestCards.length,
                  itemBuilder: (context, index) => requestCards[index],
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
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

  Widget _buildTab(String title) {
    final bool active = selectedTab == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },

      child: Padding(
        padding: const EdgeInsets.only(right: 18),

        child: SizedBox(
          width: 65,

          child: Column(
            children: [
              Text(
                title,

                style: TextStyle(
                  color: active
                      ? const Color(0xFF60A5FA)
                      : const Color(0xFF94A3B8),

                  fontWeight: active ? FontWeight.bold : FontWeight.normal,

                  fontSize: 16,
                  fontFamily: 'Inter',
                  height: 1.5,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 16),

              if (active)
                Container(
                  width: double.infinity,
                  height: 2,
                  color: const Color(0xFF60A5FA),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
