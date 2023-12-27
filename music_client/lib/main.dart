import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_client/client/client.dart';
import 'package:music_client/client/auth.dart' as auth;
import 'package:music_shared/music_shared.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const PreloadPage(),
    );
  }
}

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  late final GlobalKey homePageKey;
  late final GlobalKey landingPageKey;

  late final StreamSubscription authStateChangedSubscription;

  late bool loaded;
  late bool authenticated;

  @override
  void initState() {
    homePageKey = GlobalKey();
    landingPageKey = GlobalKey();

    authStateChangedSubscription = auth.authStateChanged.listen((event) {
      final newAuthenticated = event != null;
      if (authenticated != newAuthenticated) {
        setState(() => authenticated = newAuthenticated);
      }
    });

    loaded = false;
    authenticated = false;

    preload().then((value) => setState(() => loaded = true));
    super.initState();
  }

  Future<void> preload() async {
    await autoSessionRefresh();
    runSpeedTestOnConnectivityChanged();
  }

  Future<void> autoSessionRefresh() async {
    if (!await resumeSavedSession()) {
      if (!await startSessionWithSavedCredentials()) {
        authenticated = false;
        return;
      }
    }
    authenticated = true;
  }

  Future<bool> resumeSavedSession() async {
    final identityTokenString = await auth.secureStorage.read(key: 'token');
    if (identityTokenString == null) return false;

    final identityTokenObject = auth.IdentityToken.decode(identityTokenString);
    if (identityTokenObject == null) return false;

    auth.identityToken = identityTokenString;
    return true;
  }

  Future<bool> startSessionWithSavedCredentials() async {
    final uidString = await auth.secureStorage.read(key: 'uid');
    if (uidString == null || uidString.isEmpty) return false;

    final passwordString = await auth.secureStorage.read(key: 'password');
    if (passwordString == null || passwordString.isEmpty) return false;

    return await auth.startSession(uid: uidString, password: passwordString) == 200;
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : authenticated
            ? HomePage(key: homePageKey)
            : LandingPage(key: landingPageKey);
  }
}

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
      body: Padding(
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                        filled: true,
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                        filled: true,
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
    );
  }
}

class ConfirmPasswordPage extends StatefulWidget {
  final String email;
  final String password;

  const ConfirmPasswordPage({super.key, required this.email, required this.password});

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

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterNameAndCreateUserPage(
                  email: widget.email,
                  password: widget.password,
                )));

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                child: IconButton(
                  iconSize: 32.0,
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
              alignment: const Alignment(0.0, 1.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value != widget.password) return 'Passwords do not match';
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnterNameAndCreateUserPage extends StatefulWidget {
  final String email;
  final String password;

  const EnterNameAndCreateUserPage({super.key, required this.email, required this.password});

  @override
  State<EnterNameAndCreateUserPage> createState() => _EnterNameAndCreateUserPageState();
}

class _EnterNameAndCreateUserPageState extends State<EnterNameAndCreateUserPage> {
  late final GlobalKey formKey;

  late String name;

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

      final (success, errors) = await auth.createUser(name, widget.email, widget.password);
      if (success) {
        final identityTokenObject = auth.IdentityToken.decode(auth.identityToken!);
        if (identityTokenObject != null) {
          auth.secureStorage.write(key: 'uid', value: identityTokenObject.userId);
          auth.secureStorage.write(key: 'password', value: widget.password);

          Navigator.pop(context);
        } else {
          Navigator.pop(context);

          throw Exception('Server returned invalid IdentityToken');
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
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                child: IconButton(
                  iconSize: 32.0,
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment(0.0, 1.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Who\'re\nYou?',
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(10000.0)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null) return 'Please provide a name';
                            value = value.trim();
                            if (value.isEmpty) return 'Please provide a name';
                            if (!validateUserName(value)) return 'Must be between $userNameMinLength and $userNameMaxLength characters';
                            return null;
                          },
                          onSaved: (value) => name = value!.trim(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

  @override
  void initState() {
    auth.getName().then((value) => setState(() => name = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: name == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name!),
                  const SizedBox(height: 14.0),
                  FilledButton.tonal(
                    onPressed: () {
                      auth.signOut();
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
      ),
    );
  }
}
