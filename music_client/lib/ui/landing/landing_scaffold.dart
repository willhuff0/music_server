import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_client/ui/landing/confirm_password.dart';
import 'package:music_client/ui/landing/landing.dart';
import 'package:music_client/ui/landing/name_and_create_user.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';

class LandingState {
  String? email;
  String? password;
  String? name;
  var done = false;
}

class LandingScaffold extends StatefulWidget {
  const LandingScaffold({super.key});

  @override
  State<LandingScaffold> createState() => _LandingScaffoldState();
}

class _LandingScaffoldState extends State<LandingScaffold> {
  late final GlobalKey autofillKey;

  late final PageController _pageController;

  late final TapGestureRecognizer backGestureRecognizer;

  late final LandingState state;

  var currentPage = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    autofillKey = GlobalKey();
    _pageController = PageController();
    backGestureRecognizer = TapGestureRecognizer()..onTap = () => animateToPage(0);
    state = LandingState();
    pages = [
      LandingPage(
        state: state,
        autofillKey: autofillKey,
        onNextPage: () => animateToPage(1),
      ),
      ConfirmPasswordPage(
        state: state,
        onNextPage: () => animateToPage(2),
      ),
      EnterNameAndCreateUserPage(
        state: state,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    setState(() => currentPage = page);
    _pageController.animateToPage(page, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final pageView = Stack(
            children: [
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: currentPage == 0 ? 0.0 : 1.0,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: 32.0,
                            icon: const Icon(Icons.chevron_left),
                            onPressed: currentPage == 0
                                ? null
                                : () {
                                    animateToPage(0);
                                  },
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.labelSmall,
                                children: [
                                  const TextSpan(text: 'Creating a new account as '),
                                  TextSpan(text: state.email, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                                  const TextSpan(text: '\nNot you? '),
                                  TextSpan(
                                    text: 'Back to sign in',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
                                    recognizer: currentPage == 0 ? null : backGestureRecognizer,
                                  ),
                                  const TextSpan(text: ' '),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );

          if (constraints.maxWidth > 800) {
            // Desktop
            return AnimatedUltraGradient(
              duration: const Duration(seconds: 4),
              maxStoppedDuration: const Duration(milliseconds: 500),
              opacity: .75,
              pointSize: 2000.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 450,
                  margin: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.7), width: 2.0),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: pageView,
                ),
              ),
            );
          } else {
            // Mobile
            return AnimatedUltraGradient(
              duration: const Duration(seconds: 4),
              maxStoppedDuration: const Duration(milliseconds: 500),
              opacity: .75,
              pointSize: 1000.0,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(child: pageView),
              ),
            );
          }
        },
      ),
    );
  }
}

MaterialStateTextStyle textFieldLabelStyle(BuildContext context) {
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
    final TextStyle textStyle = textTheme.bodyLarge ?? const TextStyle();
    if (states.contains(MaterialState.disabled)) {
      return textStyle.copyWith(color: colors.onSurface.withOpacity(0.38));
    }
    if (states.contains(MaterialState.error)) {
      if (states.contains(MaterialState.focused)) {
        return textStyle.copyWith(color: colors.error);
      }
      if (states.contains(MaterialState.hovered)) {
        return textStyle.copyWith(color: colors.onErrorContainer);
      }
      return textStyle.copyWith(color: colors.error);
    }
    if (states.contains(MaterialState.focused)) {
      return textStyle.copyWith(color: colors.primary);
    }
    if (states.contains(MaterialState.hovered)) {
      return textStyle.copyWith(color: colors.onSurfaceVariant);
    }
    return textStyle.copyWith(color: colors.onSurfaceVariant);
  });
}
