import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/iam_models.dart';

class CreatePolicyDialog extends StatefulWidget {
  const CreatePolicyDialog({super.key});

  @override
  State<CreatePolicyDialog> createState() => _CreatePolicyDialogState();
}

class _CreatePolicyDialogState extends State<CreatePolicyDialog> {
  final List<ModulePermission> _availablePermissions = [
    ModulePermission(moduleName: "Students", icon: Iconsax.user_tag),
    ModulePermission(moduleName: "Courses", icon: Iconsax.book_1),
    ModulePermission(moduleName: "Attendance", icon: Iconsax.task),
    ModulePermission(moduleName: "Exams", icon: Iconsax.edit_2),
    ModulePermission(moduleName: "Fees & Finance", icon: Iconsax.wallet_money),
    ModulePermission(moduleName: "HR Directory", icon: Iconsax.profile_2user),
    ModulePermission(moduleName: "Hostel", icon: Iconsax.house),
    ModulePermission(moduleName: "LMS", icon: Iconsax.book),
    ModulePermission(moduleName: "Library", icon: Iconsax.teacher),
    ModulePermission(moduleName: "Reports & Analytics", icon: Iconsax.status_up),
  ];

  final List<String> _selectedPermissions = [];

  void _togglePermission(String module, String permission) {
    final key = "$module:$permission";
    setState(() {
      if (_selectedPermissions.contains(key)) {
        _selectedPermissions.remove(key);
      } else {
        _selectedPermissions.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Custom Policy",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Define a new access policy using the permission builder.",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  ),
                ],
              ),
            ),

            const Divider(height: 32, color: Color(0xFFF1F5F9)),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Policy & Display Name
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isSmall = constraints.maxWidth < 500;
                        if (isSmall) {
                          return Column(
                            children: [
                              _buildTextField(
                                label: "POLICY NAME",
                                hint: "e.g. FeesReadOnly",
                                isRequired: true,
                                subtext: "No spaces — letters, numbers, underscores only",
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                label: "DISPLAY NAME",
                                hint: "e.g. Fees — Read Only",
                                isRequired: true,
                              ),
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "POLICY NAME",
                                hint: "e.g. FeesReadOnly",
                                isRequired: true,
                                subtext: "No spaces — letters, numbers, underscores only",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildTextField(
                                label: "DISPLAY NAME",
                                hint: "e.g. Fees — Read Only",
                                isRequired: true,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Description
                    _buildTextField(
                      label: "DESCRIPTION",
                      hint: "Brief description of this policy's purpose...",
                      maxLines: 2,
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "PERMISSION BUILDER",
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
                    ),

                    const SizedBox(height: 12),

                    // Builder Columns
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isStacked = constraints.maxWidth < 600;
                        return Flex(
                          direction: isStacked ? Axis.vertical : Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Available Permissions
                            Flexible(
                              flex: isStacked ? 0 : 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Iconsax.global, size: 12, color: Color(0xFF64748B)),
                                      SizedBox(width: 6),
                                      Text(
                                        "AVAILABLE PERMISSIONS",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 280,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFFE2E8F0)),
                                    ),
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(12),
                                      itemCount: _availablePermissions.length,
                                      itemBuilder: (context, index) {
                                        return _buildModulePermissions(_availablePermissions[index]);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            if (!isStacked) const SizedBox(width: 20),
                            if (isStacked) const SizedBox(height: 20),

                            // Selected Permissions
                            Flexible(
                              flex: isStacked ? 0 : 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Iconsax.shield_tick, size: 12, color: Color(0xFF64748B)),
                                      SizedBox(width: 6),
                                      Text(
                                        "SELECTED PERMISSIONS",
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _buildSelectedPanel(),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Footer
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Cancel", style: TextStyle(color: Color(0xFF1A1C1E), fontSize: 13)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0061FF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("+ Create Policy", style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    bool isRequired = false,
    String? subtext,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
            ),
            if (isRequired) const Text(" *", style: TextStyle(color: Colors.red, fontSize: 10)),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          ),
        ),
        if (subtext != null) ...[
          const SizedBox(height: 4),
          Text(subtext, style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
        ],
      ],
    );
  }

  Widget _buildModulePermissions(ModulePermission module) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(module.icon, size: 12, color: const Color(0xFF1A1C1E)),
            const SizedBox(width: 6),
            Text(
              module.moduleName,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1E)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: module.permissions.map((p) => _buildToggleChip(module.moduleName, p)).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildToggleChip(String module, String permission) {
    final key = "$module:$permission";
    final isSelected = _selectedPermissions.contains(key);

    Color color;
    switch (permission) {
      case 'View': color = const Color(0xFF6366F1); break;
      case 'Create': color = const Color(0xFF10B981); break;
      case 'Edit': color = const Color(0xFFF59E0B); break;
      case 'Delete': color = const Color(0xFFEF4444); break;
      default: color = Colors.blue;
    }

    return GestureDetector(
      onTap: () => _togglePermission(module, permission),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.grid_view_rounded,
              size: 8,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 4),
            Text(
              permission,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPanel() {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: const Color(0xFFE2E8F0),
        strokeWidth: 1.5,
        dashPattern: const [6, 4],
        radius: const Radius.circular(12),
        padding: EdgeInsets.zero,
      ),
      child: Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _selectedPermissions.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 12),
                    Text(
                      "Drag permission chips here or click\nthem",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 11, height: 1.5),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _selectedPermissions.map((key) {
                    final parts = key.split(':');
                    return Chip(
                      label: Text("${parts[0]}: ${parts[1]}", style: const TextStyle(fontSize: 9)),
                      onDeleted: () => _togglePermission(parts[0], parts[1]),
                      deleteIcon: const Icon(Icons.close, size: 10),
                      backgroundColor: const Color(0xFFF8FAFC),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }
}
