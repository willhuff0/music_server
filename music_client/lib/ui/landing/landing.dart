import 'package:flutter/material.dart';
import 'package:music_client/ui/landing/confirm_password.dart';
import 'package:music_client/client/auth.dart' as auth;
import 'package:music_client/ui/widgets/ultra_gradient.dart';
import 'package:music_shared/music_shared.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late final GlobalKey formKey;

  late String email;
  late String password;
  var passwordIncorrect = false;

  var loading = false;

  @override
  void initState() {
    formKey = GlobalKey(debugLabel: 'landing_formKey');
    super.initState();
  }

  void clickNext() async {
    setState(() => loading = true);
    try {
      passwordIncorrect = false;

      final formState = formKey.currentState as FormState;
      if (!formState.validate()) return;
      formState.save();

      final statusCode = await auth.startSession(email: email, password: password);
      if (statusCode == 200) {
        final identityTokenObject = auth.IdentityToken.decode(auth.identityToken!);
        if (identityTokenObject != null) {
          auth.secureStorage.write(key: 'uid', value: identityTokenObject.userId);
          auth.secureStorage.write(key: 'password', value: password);
        } else {
          throw Exception('Server returned invalid IdentityToken');
        }
      } else {
        if (!mounted) return;

        switch (statusCode) {
          case 404: // Not found
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ConfirmPasswordPage(
                  email: email,
                  password: password,
                );
              },
            ));
            break;
          case 403: // Forbidden
            passwordIncorrect = true;
            final formState = formKey.currentState as FormState;
            formState.validate();
            break;
          default:
            ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              elevation: 2.0,
              content: const Text('An error occured on the server'),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(reason: MaterialBannerClosedReason.dismiss);
                  },
                  child: const Text('Dismiss'),
                ),
              ],
            ));
            break;
        }
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedUltraGradient(
        duration: const Duration(seconds: 4),
        maxStoppedDuration: const Duration(milliseconds: 500),
        opacity: .75,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Align(
            alignment: const Alignment(0.0, 0.0),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Music\nClient',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 96.0,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: textFieldLabelStyle(context),
                          floatingLabelStyle: textFieldLabelStyle(context),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.2)),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.2)),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                        ),
                        validator: (value) {
                          if (value == null) return 'Please provide an email';
                          value = value.trim();
                          if (value.isEmpty) return 'Please provide an email';
                          if (!validateUserEmail(value)) return 'Must be a valid email';
                          return null;
                        },
                        onSaved: (value) => email = value!.trim(),
                        enabled: !loading,
                        onFieldSubmitted: (value) {},
                        onTapOutside: (pointerDownEvent) {},
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: textFieldLabelStyle(context),
                          floatingLabelStyle: textFieldLabelStyle(context),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.2)),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.2)),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                            borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                        ),
                        validator: (value) {
                          if (passwordIncorrect) return 'Password is incorrect';
                          if (value == null || value.isEmpty) return 'Please provide a password';
                          if (!validateUserPassword(value)) return 'Must be between $userPasswordMinLength and $userPasswordMaxLength characters';
                          return null;
                        },
                        onSaved: (value) => password = value!,
                        enabled: !loading,
                        onFieldSubmitted: (value) => clickNext(),
                        onTapOutside: (pointerDownEvent) {},
                      ),
                      const SizedBox(height: 16.0),
                      FilledButton(
                        onPressed: loading ? null : clickNext,
                        // style: ButtonStyle(
                        //   backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary.withOpacity(.25)),
                        //   foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimaryContainer),
                        //   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        //     side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                        //     borderRadius: BorderRadius.circular(10000.0),
                        //   )),
                        // ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ),
              ].reversed.toList(),
            ),
          ),
        ),
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
