import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/provider_card.dart';
import 'package:tapella/core/widgets/stat_card.dart';
import 'package:tapella/core/widgets/toggle_pill.dart';
import 'package:tapella/core/widgets/new_jobs_card.dart';
import 'package:tapella/core/widgets/past_jobs.dart';
import 'package:tapella/features/bookings/presentation/providers/bookings_provider.dart';

class BusinessRequests extends ConsumerStatefulWidget {
  const BusinessRequests({super.key});

  @override
  ConsumerState<BusinessRequests> createState() => _BusinessRequestsState();
}

class _BusinessRequestsState extends ConsumerState<BusinessRequests> {
  int toggleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final incoming = ref.watch(incomingBookingsProvider);
    final history = ref.watch(historyBookingsProvider);
    final actions = ref.read(bookingActionsProvider);

    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () => context.go('/business/profile'),
            icon: const Icon(Icons.account_circle, size: 32),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Service Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 8),
              const ProviderCard(
                title: 'Account Status',
                subtitle: 'Total Earnings',
                row1: [
                  StatCard(value: '4', label: 'COMPLETED JOBS'),
                  StatCard(value: 'ETB 3500', label: 'INCOME'),
                ],
              ),
              const SizedBox(height: 8),
              TogglePill(
                leftLabel: 'New Requests',
                rightLabel: 'Past Jobs',
                selectedIndex: toggleIndex,
                onChanged: (index) => setState(() => toggleIndex = index),
              ),
              const SizedBox(height: 16),
              if (toggleIndex == 0)
                Expanded(
                  child: incoming.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                    data: (bookings) => ListView.separated(
                      itemCount: bookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final b = bookings[index];
                        return NewJob(
                          name: b.customerName,
                          status: b.status,
                          proffession: b.listingTitle,
                          dateTime: DateTime.tryParse(b.scheduledDate ?? '') ?? DateTime.now(),
                          location: 'Addis Ababa',
                          category: 'Service',
                          onAccept: () async {
                            await actions.accept(b.id);
                            ref.invalidate(incomingBookingsProvider);
                          },
                          onReject: () async {
                            await actions.reject(b.id);
                            ref.invalidate(incomingBookingsProvider);
                          },
                        );
                      },
                    ),
                  ),
                )
              else
                Expanded(
                  child: history.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                    data: (bookings) => ListView.separated(
                      itemCount: bookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final b = bookings[index];
                        return PastJob(
                          name: b.customerName,
                          status: b.status,
                          proffession: b.listingTitle,
                          dateTime: DateTime.tryParse(b.scheduledDate ?? '') ?? DateTime.now(),
                          location: 'Addis Ababa',
                          category: b.status == 'completed' ? 'Completed' : b.status,
                          money: b.amountEtb,
                          onComplete: b.status == 'accepted'
                              ? () async {
                                  await actions.complete(b.id);
                                  ref.invalidate(historyBookingsProvider);
                                }
                              : null,
                        );
                      },
                    ),
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
      case 1:
        context.go('/business/requests');
      case 2:
        context.go('/business/profile');
    }
  }
}
