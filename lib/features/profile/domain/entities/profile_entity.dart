class ProfileEntity {
  final String? id;
  final String? displayName;
  final String? username;
  final List<dynamic>? roles;
  final bool? active;
  final int? experienceYears;
  final String? address;
  final String? level;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const ProfileEntity({
    this.id,
    this.displayName,
    this.username,
    this.roles,
    this.active,
    this.experienceYears,
    this.address,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
