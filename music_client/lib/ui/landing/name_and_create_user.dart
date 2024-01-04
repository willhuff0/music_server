import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_client/client/auth.dart' as auth;
import 'package:music_client/ui/landing/landing_scaffold.dart';
import 'package:music_shared/music_shared.dart';

class EnterNameAndCreateUserPage extends StatefulWidget {
  final LandingState state;

  const EnterNameAndCreateUserPage({super.key, required this.state});

  @override
  State<EnterNameAndCreateUserPage> createState() => _EnterNameAndCreateUserPageState();
}

class _EnterNameAndCreateUserPageState extends State<EnterNameAndCreateUserPage> {
  late final GlobalKey formKey;

  var loading = false;

  @override
  void initState() {
    formKey = GlobalKey(debugLabel: 'enterNameAndCreateUser_formKey');
    super.initState();
  }

  void clickNext() async {
    setState(() => loading = true);
    try {
      final formState = formKey.currentState as FormState;
      if (!formState.validate()) return;
      formState.save();

      final (success, errors) = await auth.createUser(widget.state.name!, widget.state.email!, widget.state.password!);
      if (success) {
        final identityTokenObject = auth.IdentityToken.decode(auth.identityToken!);
        if (identityTokenObject != null) {
          auth.secureStorageWrite(key: 'uid', value: identityTokenObject.userId);
          auth.secureStorageWrite(key: 'password', value: widget.state.password);

          //Navigator.pop(context);
        } else {
          //Navigator.pop(context);

          throw Exception('Server returned an invalid IdentityToken');
        }
      } else {
        if (!mounted) return;

        if (errors case ['server_other' || 'server_token', ...]) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Text('An error occured on the server'),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 150,
              right: 20,
              left: 20,
            ),
          ));

          if (kDebugMode) print('Error(s) returned from createUser: $errors');
        } else {
          throw Exception('Error(s) returned from createUser which shouldn\'t be possible: $errors');
        }
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
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
                  'Who Are\nYou?',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 84.0,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                      if (value == null) return 'Please provide a name';
                      value = value.trim();
                      if (value.isEmpty) return 'Please provide a name';
                      if (!validateUserName(value)) return 'Must be between $userNameMinLength and $userNameMaxLength characters';
                      return null;
                    },
                    onSaved: (value) => widget.state.name = value!.trim(),
                    enabled: !loading,
                    onFieldSubmitted: (value) => clickNext(),
                    onTapOutside: (pointerDownEvent) {},
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: loading ? null : clickNext,
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
