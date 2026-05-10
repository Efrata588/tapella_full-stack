import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/provider_card.dart';
import 'package:tapella/core/widgets/provider_req_card.dart';
import 'package:tapella/core/widgets/stat_card.dart';
import 'package:tapella/core/widgets/tab_selector.dart';

class BusinessHome extends StatefulWidget {
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  int _currentIndex = 0;
  String selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      appBar: CustomAppBar(
        onMenuPressed: () => context.go("/business/login"),
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              onPressed: () => context.go("/business/login"),
              icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProviderCard(
              title: "Account Status",
              subtitle: "● Active Provider",
              row1: [
                const StatCard(value: "4.9", label: "RATING"),
                const StatCard(value: "124", label: "JOBS"),
              ],
              row2: [
                const StatIconCard(
                  icon: Icon(Icons.verified, color: Colors.white),
                  label: "VERIFIED",
                ),
                const StatCard(value: "ETB 3500", label: "INCOME"),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                label: "Add New Listing",
                height: 57,
                width: 200,
                fill: AppColors.primaryBlue,
                onPressed: () => context.go("/business/new-listing"),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Past Jobs",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TabSelector(
              selectedTab: selectedTab,
              onTabChanged: (tab) => setState(() => selectedTab = tab),
            ),
            SizedBox(height: 8),
            SizedBox(height: 8),
            BusinessReqCard(
              name: "Kaleab M",
              status: "accepted",
              proffession: "Programmer",
              dateTime: DateTime.now(),
              location: "Bole",
              category: "Cleaning",
              onComplete: () {},
              onDelete: () {},
            ),
            SizedBox(height: 16),
            BusinessReqCard(
              name: "Efrata E",
              status: "accepted",
              proffession: "Programmer",
              dateTime: DateTime.now(),
              location: "Tulu Dimtu",
              category: "Cleaning",
              onComplete: () {},
              onDelete: () {},
            ),
            SizedBox(height: 16),
            BusinessReqCard(
              name: "Naomi M",
              status: "accepted",
              proffession: "Programmer",
              dateTime: DateTime.now(),
              location: "Megenagna",
              category: "Cleaning",
              onComplete: () {},
              onDelete: () {},
            ),
          ],
        ),
      ),
    );
  }
}
