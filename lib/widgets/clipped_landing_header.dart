import 'package:app/helpers/app_constants.dart';
import 'package:app/screens/landing_screen.dart';
import 'package:app/widgets/animated_background_image.dart';
import 'package:app/widgets/social_media_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class ClippedLandingHeader extends StatelessWidget {
  final ScrollController scrollController;

  const ClippedLandingHeader(
    this.scrollController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipper(),
      child: Stack(
        children: [
          // Widget that has animated background image while scrolling
          AnimatedBackgroundImage(scrollController),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveWrapper.of(context).isDesktop
                  ? 280.0
                  : ResponsiveWrapper.of(context).isMobile
                      ? 64
                      : 200,
              vertical: ResponsiveWrapper.of(context).isDesktop
                  ? 180.0
                  : ResponsiveWrapper.of(context).isMobile
                      ? 48
                      : 90,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlitInDiagonal(
                  child: const SelectableText(
                    AppConstants.landingTitle,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
                const SizedBox(height: 22.0),
                const Divider(
                  thickness: 1.75,
                  color: dividerColor,
                ),
                const SizedBox(height: 30.0),
                const SelectableText(
                  AppConstants.landingMotto,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 24.0),
                const SocialMediaButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted from "flutter_custom_clippers" package.
class DiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height - 112.0)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
