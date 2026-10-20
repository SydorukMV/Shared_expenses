import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.initials,
    this.radius = 20,
    this.showCameraBadge = false,
    this.onTap,
  });

  final String initials;
  final double radius;
  final bool showCameraBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      child: Text(
        initials,
        style: TextStyle(fontSize: radius * 0.75, fontWeight: FontWeight.w500),
      ),
    );

    final content = !showCameraBadge
        ? avatar
        : Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: EdgeInsets.all(radius * 0.12),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.surface, width: 3),
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    size: radius * 0.32,
                    color: colors.onPrimary,
                  ),
                ),
              ),
            ],
          );

    if (onTap == null) return content;
    return Semantics(
      button: true,
      label: 'Фото профілю',
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}
