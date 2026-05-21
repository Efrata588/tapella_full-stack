import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/service_card.dart';
import 'package:tapella/features/services/presentation/providers/listings_provider.dart';

import 'package:tapella/core/models/listing_model.dart';
import 'package:tapella/features/cllients/presentation/providers/saved_listings_provider.dart';

class ClientHomePage extends ConsumerStatefulWidget {
  const ClientHomePage({super.key});

  @override
  ConsumerState<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends ConsumerState<ClientHomePage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listingsState = ref.watch(listingsProvider);
    final savedListings = ref.watch(savedListingsProvider);

    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () => context.go('/client/profile'),
            icon: const Icon(Icons.account_circle, size: 32),
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
              onSubmitted: (_) => ref.read(listingsProvider.notifier).load(
                    search: searchController.text,
                  ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                hintText: 'Search services...',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  onPressed: () => ref.read(listingsProvider.notifier).load(
                        search: searchController.text,
                      ),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 23, 47, 83),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (listingsState.isStale)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Showing saved data (offline)',
                  style: TextStyle(color: Colors.amber, fontSize: 12),
                ),
              ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('ALL', onTap: () {
                    ref.read(listingsProvider.notifier).load();
                  }),
                  ...appCategories.map((category) {
                    return _buildCategoryChip(category, onTap: () {
                      ref.read(listingsProvider.notifier).load(category: category);
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'AVAILABLE SERVICES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            if (listingsState.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (listingsState.error != null)
              Text(
                listingsState.error!,
                style: const TextStyle(color: Colors.redAccent),
              )
            else if (listingsState.listings.isEmpty)
              const Text('No listings yet', style: TextStyle(color: Colors.grey))
            else
              ...listingsState.listings.map((listing) {
                final isSaved = savedListings.contains(listing.id);
                return ServiceCard(
                  name: listing.providerName,
                  location: listing.location,
                  role: listing.title,
                  rating: listing.ratingAvg,
                  description: listing.description,
                  isSaved: isSaved,
                  onCardTap: () => context.go('/service/detail/${listing.id}'),
                  onSaveToggle: () {
                    ref.read(savedListingsProvider.notifier).toggleSave(listing.id);
                  },
                  onBookNow: () => context.go('/service/book/${listing.id}'),
                );
              }),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go('/client/home');
      case 1:
        context.go('/client/requests');
      case 2:
        context.go('/client/profile');
    }
  }

  Widget _buildCategoryChip(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C222E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
