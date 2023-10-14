import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/custom_snackbar.dart';

class CustomCommands {
  // Open a link in the user's browser
  static void openURLInBrowser(BuildContext context, {required String link}) async {
    ProcessResult result = await Process.run(
      'open',
      ['https://$link'],
    );

    if (result.exitCode == 0) {
      // Show a green Snackbar when the link is opened
      CustomSnackBar.green(context, content: 'Opening link...');
    } else {
      // Show a red Snackbar for an error
      CustomSnackBar.red(context, content: 'Error: Link can\'t open!');
    }
  }

  // Proxies commands for HTTP, HTTPS, and SOCKS
  static Future<ProcessResult> enableHTTPProxy({
    required String server,
    required String port,
  }) async {
    final result = await Process.run(
      'networksetup',
      ['-setwebproxy', 'Wi-Fi', server, port],
      runInShell: true,
    );

    return result;
  }

  static Future<ProcessResult> enableHTTPSProxy({
    required String server,
    required String port,
  }) async {
    final result = await Process.run(
      'networksetup',
      ['-setsecurewebproxy', 'Wi-Fi', server, port],
      runInShell: true,
    );

    return result;
  }

  static Future<ProcessResult> enableSocksProxy({
    required String server,
    required String port,
  }) async {
    final result = await Process.run(
      'networksetup',
      ['-setsocksfirewallproxy', 'Wi-Fi', server, port],
      runInShell: true,
    );

    return result;
  }

  static Future<ProcessResult> disableHTTPProxy() async {
    final result = await Process.run(
      'networksetup',
      ['-setwebproxystate', 'Wi-Fi', 'off'],
      runInShell: true,
    );

    return result;
  }

  static Future<void> disableHTTPSProxy() async {
    await Process.run(
      'networksetup',
      ['-setsecurewebproxystate', 'Wi-Fi', 'off'],
      runInShell: true,
    );
  }

  static Future<void> disableSocksProxy() async {
    await Process.run(
      'networksetup',
      ['-setsocksfirewallproxystate', 'Wi-Fi', 'off'],
      runInShell: true,
    );
  }
}
