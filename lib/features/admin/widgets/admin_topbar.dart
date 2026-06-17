import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminTopBar extends StatelessWidget {
  final bool isMobile;
  final String pageTitle;

  const AdminTopBar({
    super.key,
    required this.isMobile,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: Row(
        children: [
          if (isMobile) ...[
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Iconsax.menu_1),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            const SizedBox(width: 8),
          ],

          Text(
            pageTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1C1E),
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.refresh, size: 20, color: Colors.grey),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.moon, size: 20, color: Colors.grey),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification, size: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
