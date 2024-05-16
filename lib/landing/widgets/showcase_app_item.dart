import 'package:app/landing/widgets/interactive_image_viewer.dart';
import 'package:app/landing/widgets/source_aware_image.dart';
import 'package:app/utilities/showcase_app_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/landing/landing_screen.dart';
import 'package:app/landing/widgets/animated_image_overlay.dart';
import 'package:app/landing/widgets/external_link_button.dart';

import 'package:app/apps/idle_app/idle_app_screen.dart';
import 'package:app/apps/job_description/job_description_screen.dart';
import 'package:app/apps/question_generator/question_generator_screen.dart';

class ShowcaseAppItem extends StatelessWidget {
  final ShowcaseAppModel app;

  const ShowcaseAppItem(
    this.app, {
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
        bottomLeft: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      ),
      child: Stack(
        children: [
          _buildChild(),
          Positioned(
            top: 0.0,
            // bottom: 192.0,
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              // When overlay tapped, open full screen interactive image viewer.
              onTap: () async {
                if (app.name == 'Job Description Generator') {
                  // Load job description generator screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDescriptionScreen(),
                    ),
                  );
                } else if (app.name == 'Idle App') {
                  // Load idle app screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IdleAppScreen(),
                    ),
                  );
                } else if (app.name == 'Interview Question Generator') {
                  // Load question generator screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionCheckerPage(),
                    ),
                  );
                }
              },
              child: AnimatedImageOverlay(app.topic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    return Container(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SourceAwareImage(
            image: app.image,
            isNetworkImage: app.isNetworkImage,
          ),
          _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppName(),
              const Divider(
                color: dividerColor,
                thickness: 1.5,
                height: 32.0,
              ),
            ],
          ),
          // Add description text
          const Text(
            'This is a description of the app.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppName() {
    return Text(
      app.name,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 1.4,
      ),
    );
  }
}
