import 'package:flutter/material.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/theme/app_colors.dart';

class CreateServiceBody extends StatefulWidget {
  const CreateServiceBody({super.key});

  @override
  State<CreateServiceBody> createState() => _CreateServiceBodyState();
}

class _CreateServiceBodyState extends State<CreateServiceBody> {
  bool isCallEnabled = false;
  String? selectedCategory;
  final TextEditingController serviceTitleController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    serviceTitleController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        leading: Icon(Icons.arrow_back, color: Color(0xFFADC6FF)),
        title: 'Create New Service',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 26),
            // Header Text
            const Text(
              "New Listing",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'inter',
                height: 40 / 36,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Share your expertise with the celestial marketplace. Craft a compelling offer that shines.",
              style: TextStyle(
                color: Color(0xFFC1C6D7),
                fontSize: 16,
                height: 1.6,
                fontFamily: 'inter',
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Manage your professional presence and business details.",
              style: TextStyle(
                color: Color(0xFFC1C6D7),
                fontSize: 16,
                height: 1.6,
                fontFamily: 'inter',
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),

            // Form Fields
            _buildLabel("Service Title"),
            _buildTextField(hint: "e.g. Premium Identity Design"),

            _buildLabel("Category"),
            _buildDropdownField(
              hint: "Select Category",
              value: selectedCategory,
              items: ["Design", "Development", "Marketing"],
              onChanged: (val) {
                setState(() {
                  selectedCategory = val;
                });
              },
            ),

            _buildLabel("Phone Number"),
            _buildTextField(hint: "0912345678"),

            _buildLabel("Description"),
            _buildTextField(
              hint: "Describe what makes your service unique...",
              maxLines: 5,
            ),

            const SizedBox(height: 15),
            const Text(
              "SERVICE TAGS",
              style: TextStyle(
                color: Color(0xFFC1C6D7),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.5,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 9),

            // Tags Row
            Wrap(
              spacing: 8,
              children: [
                _buildChip("Minimalist x"),
                _buildChip("Fast Delivery x"),
                _buildChip("+ Add Tag", isAction: true),
              ],
            ),

            const SizedBox(height: 40),

            // Enable Call Button
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() => isCallEnabled = !isCallEnabled);
                },
                label: const Text(
                  "Enable Call",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    fontFamily: 'inter',
                  ),
                ),
                icon: const Icon(
                  Icons.phone_in_talk_outlined,
                  size: 18,
                  color: Color(0xFF007AFF),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: isCallEnabled ? Colors.blue : Colors.white24,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            PreferredSize(
              preferredSize: const Size.fromHeight(2),
              child: Container(
                height: 1,
                decoration: BoxDecoration(gradient: AppColors.grad),
              ),
            ),
            const SizedBox(height: 16),

            // Save Listing Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Text(
                  "Save Listing",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                label: const Icon(Icons.file_upload_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066CC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            const Center(
              child: Text(
                "LISTING WILL BE REVIEWED BEFORE GOING LIVE",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
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
        },
      ),
    );
  }

  // Helper widget for Labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFADC6FF),
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w400,
          fontFamily: 'inter',
        ),
      ),
    );
  }

  // Helper widget for TextFields
  Widget _buildTextField({
    required String hint,
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xFFFFFFFF).withValues(alpha: 0.2),
          fontSize: 16,
          fontFamily: 'inter',
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.grey, width: 0.3),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: Colors.grey, width: 0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.white24)),
          isExpanded: true,
          dropdownColor: AppColors.backgroundAlt,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFADC6FF)),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Helper widget for Chips
  Widget _buildChip(
    String label, {
    bool isAction = false,
    VoidCallback? ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isAction
              ? Colors.transparent
              : Colors.white.withValues(alpha: 0.06),
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isAction ? Color(0xFFC1C6D7) : Color(0xFFADC6FF),
            fontSize: 12,
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
