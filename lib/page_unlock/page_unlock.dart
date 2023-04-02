import 'dart:convert';
import 'package:aspis/global_realm.dart';
import 'package:aspis/components/flat_textfield.dart';
import 'package:aspis/store/test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as pe;
import 'package:realm/realm.dart';

class PageUnlock extends StatefulWidget {
  const PageUnlock({super.key});

  @override
  State<PageUnlock> createState() => _PageUnlockState();
}

class _PageUnlockState extends State<PageUnlock> {
  final passwordTextController = TextEditingController();

  String errorMsg = "";

  @override
  void dispose() {
    passwordTextController.dispose();
    super.dispose();
  }

  void attemptToUnlockRealm() {
    // print("Attempting to unlock realm");
    var bytes = utf8.encode(passwordTextController.text);
    var digest = sha256.convert(bytes);

    var dd = digest.toString().substring(0, 32); // get the first 32 chars as the aes key
    final key = pe.Key.fromUtf8(dd);
    final iv = pe.IV.fromLength(16);

    final encrypter = pe.Encrypter(pe.AES(key));

    // long static string to ensure enough bytes are generated for the 64 byte encryptionkey
    final encrypted = encrypter
        .encrypt("mAEFuw90ebncuasethesthsethse hsseti203bjci0jbcji 0-beI) YCuI)BWEc", iv: iv);

    print("AES key - ${encrypted.bytes}");
    print("AES key - ${encrypted}");

    // TODO: ensure encrypted bytes is atleast 64 bytes
    // needs some more testing without the try catch

    List<int> x = [];
    for (var i = 0; i < 64; ++i) {
      x.add(encrypted.bytes[i]);
    }

    print(x);

    // Get on-disk location of the default Realm
    final storagePath = Configuration.defaultStoragePath;
    // See value in your application
    print(storagePath);

    try {
      final encryptedConfig = Configuration.local([Person.schema, OTP.schema], encryptionKey: x);
      gRealm = Realm(encryptedConfig);
      passwordTextController.text = "";
      setState(
        () => errorMsg = "",
      );
      context.go('/home');
    } catch (e) {
      setState(
        () => errorMsg = "Wrong password.",
      );
      // likely wrong password failed to open realm
      // TODO: check docs if there are error codes or something better
      print("Couldnt open realm");
      // TODO: have ui element showing error opening db (vault)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // TestRealm(),
                Image.asset(
                  'assets/lock_screen/lock.png',
                  width: 80,
                  height: 80,
                ),

                const SizedBox(height: 16),

                const Text("Enter Password",
                    style: TextStyle(
                      fontSize: 24,
                    )),

                if (errorMsg != "") ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMsg,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  constraints: const BoxConstraints(minWidth: 280, maxWidth: 640),
                  child: FlatTextField(
                    textController: passwordTextController,
                    hintText: "Password",
                    password: true,
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(onPressed: () => {attemptToUnlockRealm()}, child: const Text("Unlock"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
