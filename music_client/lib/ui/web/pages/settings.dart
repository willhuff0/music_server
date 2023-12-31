import 'package:flutter/material.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DynMouseScroll(
      builder: (context, controller, physics) {
        return ListView(
          controller: controller,
          physics: physics,
          children: [
            SizedBox(height: 150.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: 775.0,
                  child: Text('Settings', style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
