import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  Widget buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(icon),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Manage",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          const Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "System administration and access management",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          buildCard(
            icon: Icons.people,
            title: "User Management",
            subtitle:
            "Manage administrators, faculty and students",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.admin_panel_settings,
            title: "Roles & Permissions",
            subtitle:
            "Configure RBAC and access policies",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.security,
            title: "IAM Policies",
            subtitle:
            "Identity and Access Management controls",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.groups,
            title: "User Groups",
            subtitle:
            "Manage organizational groups",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.history,
            title: "Audit Logs",
            subtitle:
            "View security and activity logs",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.settings,
            title: "System Settings",
            subtitle:
            "Global ERP configuration",
          ),

          const SizedBox(height: 16),

          buildCard(
            icon: Icons.backup,
            title: "Backup & Recovery",
            subtitle:
            "Database backup management",
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}