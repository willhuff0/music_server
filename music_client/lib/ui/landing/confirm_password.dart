import 'package:flutter/material.dart';
import 'package:music_client/ui/landing/landing_scaffold.dart';

class ConfirmPasswordPage extends StatefulWidget {
  final LandingState state;

  final void Function() onNextPage;

  const ConfirmPasswordPage({super.key, required this.state, required this.onNextPage});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  late final GlobalKey formKey;

  late String confirmPassword;

  @override
  void initState() {
    formKey = GlobalKey(debugLabel: 'confirmPassword_formKey');
    super.initState();
  }

  void clickNext() async {
    final formState = formKey.currentState as FormState;
    if (!formState.validate()) return;
    formState.save();

    widget.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  'Reenter\nPassword',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 64.0,
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
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
                      if (value != widget.state.password) return 'Passwords do not match';
                      return null;
                    },
                    onSaved: (value) => confirmPassword = value!,
                    onFieldSubmitted: (value) => clickNext(),
                    onTapOutside: (pointerDownEvent) {},
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: clickNext,
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
    );
  }
}
