import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/iam_models.dart';
import 'create_policy_dialog.dart';

class PoliciesView extends StatefulWidget {
  const PoliciesView({super.key});

  @override
  State<PoliciesView> createState() => _PoliciesViewState();
}

class _PoliciesViewState extends State<PoliciesView> {
  final List<IAMPolicy> _builtInPolicies = [];
  final List<IAMPolicy> _customPolicies = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.info_circle, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "Define built-in and custom access policies",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () => _showCreatePolicyDialog(context),
              icon: const Icon(Iconsax.add, size: 20),
              label: const Text("Create Custom Policy"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.setting_3, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Built-in Policies (${_builtInPolicies.length})",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _builtInPolicies.isEmpty
                      ? _buildEmptyPoliciesState("No built-in policies found.")
                      : _buildPolicyGrid(_builtInPolicies),
                  
                  if (_customPolicies.isNotEmpty) ...[
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        const Icon(Iconsax.user_edit, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          "Custom Policies (${_customPolicies.length})",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildPolicyGrid(_customPolicies),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPoliciesState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          const Icon(Iconsax.shield_search, size: 48, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPolicyGrid(List<IAMPolicy> policies) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1200 ? 3 : (constraints.maxWidth > 800 ? 2 : 1);
        double childAspectRatio = constraints.maxWidth > 1200 ? 1.6 : (constraints.maxWidth > 800 ? 1.8 : 2.2);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: policies.length,
          itemBuilder: (context, index) {
            final policy = policies[index];
            return _buildPolicyCard(policy);
          },
        );
      },
    );
  }

  Widget _buildPolicyCard(IAMPolicy policy) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                policy.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "BUILT-IN",
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            policy.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Spacer(),
          Text(
            "${policy.modulesCount} module${policy.modulesCount > 1 ? 's' : ''} • ${policy.permissionsCount} permission${policy.permissionsCount > 1 ? 's' : ''}",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: policy.modules.take(3).map((m) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.book, size: 12, color: Colors.blue),
                const SizedBox(width: 4),
                Text(m, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }

  void _showCreatePolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreatePolicyDialog(),
    );
  }
}
