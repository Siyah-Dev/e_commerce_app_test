class LoginResponseEntity {
  const LoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.sessionExpiresAt,
    required this.user,
    required this.role,
    required this.tenantId,
    required this.company,
    required this.userRoles,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime? sessionExpiresAt;

  final AuthUser user;
  final String role;
  final String tenantId;

  final CompanyInfo company;
  final List<UserPermission> userRoles;
}

class AuthUser {
  const AuthUser({
    required this.userId,
    required this.userName,
    required this.isMaster,
    required this.branchId,
  });

  final int userId;
  final String userName;
  final bool isMaster;
  final int branchId;
}

class UserPermission {
  const UserPermission({
    required this.permissionId,
    required this.module,
    required this.action,
  });

  final int permissionId;
  final String module;
  final String action;
}

class CompanyInfo {
  const CompanyInfo({
    required this.decimalPart,
    required this.currencySymbol,
  });

  final int decimalPart;
  final String currencySymbol;
}