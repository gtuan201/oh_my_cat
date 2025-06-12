import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../widget/item_setting.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).cardTheme.shadowColor!,
            width: 3
        )
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(S.of(context).contact_us),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8,),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            decoration: decoration,
            child: Column(
              children: [
                ItemSetting(
                  title: S.of(context).facebook,
                  icon: Icons.facebook,
                  onTap: () {
                    openFacebookProfile();
                  },
                ),
                const Divider(thickness: 2,),
                ItemSetting(
                  title: S.of(context).email,
                  icon: Icons.email,
                  onTap: () {
                    openEmail();
                  },
                ),
                const Divider(thickness: 2,),
                ItemSetting(
                  title: S.of(context).phoneNumber,
                  icon: Icons.phone,
                  onTap: () {
                    makePhoneCall();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> openFacebookProfile() async {
    const String username = 'tuan.nguyxn';
    String url;
    if (Platform.isIOS) {
      url = 'fb://profile/$username';
    } else if (Platform.isAndroid) {
      url = 'fb://page/$username';
    } else {
      url = 'https://www.facebook.com/$username';
    }
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await launchUrl(Uri.parse('https://www.facebook.com/$username'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'giantuan153@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Contact from User - OhMyCat',
      }),
    );

    await launchUrl(emailUri);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> makePhoneCall() async {
    const String phoneNumber = 'tel:+84963433211';
    try {
      await launchUrl(
        Uri.parse(phoneNumber),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Không thể quay số: $e');
    }
  }
}
