import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/tab_selector.dart';
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
      name: 'Efrate E',
      status: 'pending',
      proffession: 'House Keeping',
      dateTime: DateTime.now(),
      location: 'Addis Ababa',
    ),

    RequestCard(
      name: 'Saron K',
      status: 'rejected',
      proffession: 'House Keeping',
      dateTime: DateTime.now(),
      location: 'Addis Ababa',
    ),

    RequestCard(
      name: 'Kaleab M',
      status: 'accepted',
      proffession: 'House Keeping',
      dateTime: DateTime.now(),
      location: 'Addis ababa',
    ),

    RequestCard(
      name: 'Naomi M',
      status: 'pending',
      proffession: 'House Keeping',
      dateTime: DateTime.now(),
      location: 'Addis Ababa',
    ),

    RequestCard(
      name: 'Elroi T',
      status: 'rejected',
      proffession: 'House Keeping',
      dateTime: DateTime.now(),
      location: 'Addis Ababa',
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
              TabSelector(
                selectedTab: selectedTab,
                onTabChanged: (tab) => setState(() => selectedTab = tab),
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
}
