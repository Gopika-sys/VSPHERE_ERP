import 'package:flutter/material.dart';

class IAMStats {
  final int totalUsers;
  final int userGroups;
  final int totalPolicies;

  IAMStats({
    required this.totalUsers,
    required this.userGroups,
    required this.totalPolicies,
  });

  factory IAMStats.empty() => IAMStats(totalUsers: 0, userGroups: 0, totalPolicies: 0);
}

class IAMUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final List<String> groups;
  final List<String> policies;
  final String status;

  IAMUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.groups,
    required this.policies,
    required this.status,
  });
}

class IAMPolicy {
  final String id;
  final String name;
  final String description;
  final int modulesCount;
  final int permissionsCount;
  final List<String> modules;
  final bool isBuiltIn;

  IAMPolicy({
    required this.id,
    required this.name,
    required this.description,
    required this.modulesCount,
    required this.permissionsCount,
    required this.modules,
    this.isBuiltIn = true,
  });
}

class ModulePermission {
  final String moduleName;
  final IconData icon;
  final List<String> permissions;

  ModulePermission({
    required this.moduleName,
    required this.icon,
    this.permissions = const ['View', 'Create', 'Edit', 'Delete'],
  });
}
