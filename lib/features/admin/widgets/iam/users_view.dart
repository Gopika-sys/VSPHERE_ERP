import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/iam_models.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final List<IAMUser> _users = []; // Empty list for no mock data

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.info_circle, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Manage accounts, roles, permissions and access",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isSmall = constraints.maxWidth < 600;
              
              Widget searchField = TextField(
                decoration: InputDecoration(
                  hintText: "Search users...",
                  prefixIcon: const Icon(Iconsax.search_normal_1, size: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              );

              Widget createButton = ElevatedButton.icon(
                onPressed: () => _showCreateUserDialog(context),
                icon: const Icon(Iconsax.add, size: 20),
                label: const Text("Create User"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 52),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    searchField,
                    const SizedBox(height: 12),
                    createButton,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: searchField),
                  const SizedBox(width: 16),
                  createButton,
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: _users.isEmpty
                ? _buildEmptyState()
                : _buildUsersTable(),
          ),
        ],
      ),
    );
  }

  void _showCreateUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New User"),
        content: const Text("User creation form will be implemented here."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Create")),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.user_remove, size: 64, color: Color(0xFFE2E8F0)),
          SizedBox(height: 16),
          Text(
            "No users found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
          ),
          SizedBox(height: 8),
          Text(
            "Create a new user to manage their access.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersTable() {
    // This will be implemented when backend is connected
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        headingRowHeight: 56,
        dataRowMaxHeight: 72,
        columns: const [
          DataColumn(label: Text("USER", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("ROLE", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("GROUPS / POLICIES", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("STATUS", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: _users.map((user) => DataRow(cells: [
          DataCell(Text(user.name)),
          DataCell(Text(user.role)),
          DataCell(Text(user.policies.join(", "))),
          DataCell(Text(user.status)),
          const DataCell(Icon(Icons.more_vert)),
        ])).toList(),
      ),
    );
  }
}
