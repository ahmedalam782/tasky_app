class ProfileInfoEntity {
  final String title;
  final String value;
  final bool isVisibleCopyButton;
  const ProfileInfoEntity({
    required this.title,
    required this.value,
    this.isVisibleCopyButton = false,
  });
}
