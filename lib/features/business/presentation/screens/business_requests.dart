import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/provider_card.dart';
import 'package:tapella/core/widgets/stat_card.dart';
import 'package:tapella/core/widgets/toggle_pill.dart';
import 'package:tapella/core/widgets/new_jobs_card.dart';
import 'package:tapella/core/widgets/past_jobs.dart';

class BusinessRequests extends StatefulWidget {
  const BusinessRequests({super.key});

  @override
  State<BusinessRequests> createState() => _BusinessRequestsState();
}

class _BusinessRequestsState extends State<BusinessRequests> {
  String selectedTab = 'All';
  int toggleIndex = 0;

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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  height: 1.7,
                ),
              ),
              SizedBox(height: 8),
              ProviderCard(
                title: "Account Status",
                subtitle: "Total Earnings",
                row1: [
                  const StatCard(value: "4", label: "COMPLETED JOBS"),
                  const StatCard(value: "ETB 3500", label: "INCOME"),
                ],
              ),
              SizedBox(height: 8),
              TogglePill(
                leftLabel: "New Requests",
                rightLabel: "Past Jobs",
                selectedIndex: toggleIndex,
                onChanged: (index) => setState(() => toggleIndex = index),
              ),
              SizedBox(height: 16),

              if (toggleIndex == 0)
                Expanded(
                  child: ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final names = ['Abebe G', 'Zemedu T', 'Sara M'];
                      final professions = [
                        'House Cleaning',
                        'Gardening',
                        'Laundry',
                      ];
                      return NewJob(
                        name: names[index],
                        status: 'pending',
                        proffession: professions[index],
                        dateTime: DateTime.now().add(Duration(days: index)),
                        location: 'Addis Ababa',
                        category: 'Cleaning',
                      );
                    },
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final names = ['Almaz K', 'Mesay T', 'Tigist M'];
                      final professions = [
                        'House Cleaning',
                        'Painting',
                        'Gardening',
                      ];
                      final money = [2500.0, 3200.0, 1800.0];
                      return PastJob(
                        name: names[index],
                        status: 'accepted',
                        proffession: professions[index],
                        dateTime: DateTime.now().subtract(
                          Duration(days: index + 1),
                        ),
                        location: 'Addis Ababa',
                        category: 'Completed',
                        money: money[index],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/business/home');
        break;

      case 1:
        context.go('/business/requests');
        break;

      case 2:
        context.go('/business/profile');
        break;
    }
  }
}
