import 'package:e_commerce_test/features/auth/domain/entities/auth_response_entity.dart';


class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.sessionExpiresAt,
    required super.user,
    required super.role,
    required super.tenantId,
    required super.company,
    required super.userRoles,
  });

  factory LoginResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final session =
        json['session'] as Map<String, dynamic>?;

    final user =
        json['user'] as Map<String, dynamic>?;

    final company =
        json['company'] as Map<String, dynamic>?;

    final roles =
        json['userRoles'] as List<dynamic>? ?? [];

    return LoginResponseModel(
      accessToken: json['accessToken']?.toString() ?? '',
      refreshToken: json['refreshToken']?.toString() ?? '',
      sessionExpiresAt: DateTime.tryParse(
        session?['expiresAt']?.toString() ?? '',
      ),
      user: AuthUser(
        userId: user?['userId'] as int? ?? 0,
        userName: user?['userName']?.toString() ?? '',
        isMaster: user?['isMaster'] as bool? ?? false,
        branchId: user?['branchId'] as int? ?? 0,
      ),
      role: json['role']?.toString() ?? '',
      tenantId: json['tenantId']?.toString() ?? '',
      company: CompanyInfo(
        decimalPart:
            company?['decimalPart'] as int? ?? 2,
        currencySymbol:
            company?['currencySymbol']?.toString() ?? '',
      ),
      userRoles: roles
          .whereType<Map<String, dynamic>>()
          .map(
            (role) => UserPermission(
              permissionId:
                  role['permissionId'] as int? ?? 0,
              module:
                  role['module']?.toString() ?? '',
              action:
                  role['action']?.toString() ?? '',
            ),
          )
          .toList(),
    );
  }
}