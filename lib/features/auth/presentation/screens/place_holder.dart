import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';

class PlaceHolderScreen extends StatelessWidget {
  const PlaceHolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      body: const Center(
        child: Text(
          'This is a placeholder screen.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
