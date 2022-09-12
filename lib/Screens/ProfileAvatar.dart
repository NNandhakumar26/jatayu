import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isLocalImage;
  final bool isActive;
  final bool hasBorder;
  final double radius;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
    this.isLocalImage = false,
    this.radius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius + 3,
          backgroundColor: Style.nearlyDarkBlue,
          child: CircleAvatar(
            radius: hasBorder ? radius : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: (isLocalImage)
                ? AssetImage('assets/images/$imageUrl') as ImageProvider
                : CachedNetworkImageProvider(imageUrl),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: Style.online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
