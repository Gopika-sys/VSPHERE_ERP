import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  static final List<Map<String, dynamic>> menuItems = [
    {"title": "Dashboard", "icon": Iconsax.grid_5},
    {"title": "Students", "icon": Iconsax.user_tag},
    {"title": "Academic", "icon": Iconsax.teacher},
    {"title": "LMS", "icon": Iconsax.book},
    {"title": "Attendance", "icon": Iconsax.task},
    {"title": "Exams", "icon": Iconsax.edit_2},
    {"title": "Fees & Finance", "icon": Iconsax.wallet_money},
    {"title": "HR & Payroll", "icon": Iconsax.profile_2user},
    {"title": "Library", "icon": Iconsax.book_1},
    {"title": "Hostel", "icon": Iconsax.house},
    {"title": "Communication", "icon": Iconsax.sms_notification},
    {"title": "Reports", "icon": Iconsax.status_up},
    {"title": "Settings", "icon": Iconsax.setting_2},
    {"title": "Admin Panel", "icon": Iconsax.security_user},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.school_rounded, color: Colors.blue, size: 24),
                ),
                const SizedBox(width: 12),
                const Text(
                  "vSphere ERP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1C1E),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: ListTile(
                    dense: true,
                    selected: isSelected,
                    selectedTileColor: const Color(0xFF0061FF).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Icon(
                      item["icon"],
                      color: isSelected ? const Color(0xFF0061FF) : Colors.grey,
                      size: 20,
                    ),
                    title: Text(
                      item["title"],
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0061FF) : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    onTap: () => onItemTap(index),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade100,
                    child: const Icon(Iconsax.user, color: Colors.grey, size: 20),
                  ),
                  title: const Text(
                    "---",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: const Text("---", style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.more_vert, size: 20),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Iconsax.logout, color: Colors.red, size: 20),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    // Handle logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
