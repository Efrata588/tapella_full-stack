import 'package:flutter/material.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';

class PlaceHolderScreen extends StatefulWidget {
  const PlaceHolderScreen({super.key});

  @override
  State<PlaceHolderScreen> createState() => _PlaceHolderScreenState();
}

class _PlaceHolderScreenState extends State<PlaceHolderScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomTopAppBar(),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'This is a placeholder screen.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ],
      ),
    );
  }
}
