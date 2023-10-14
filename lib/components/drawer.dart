import 'dart:io';

import 'package:flutter/material.dart';
import '/utils/custom_commands.dart';
import 'package:flutter_svg/svg.dart';

import '../pages/settings.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF130E36),
      child: Stack(
        children: [
          // Close button to dismiss the drawer
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.closeDrawer();
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 28),

              // Developer information and avatar
              SizedBox(
                height: 96,
                width: 96,
                child: CircleAvatar(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/avatar.jpeg'),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Parsa Sharifi',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                '@ZhiaDev',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              const SizedBox(height: 4),

              // Social media links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton.outlined(
                      onPressed: () {
                        CustomCommands.openURLInBrowser(context,
                            link: 'instagram.com/zhiadev');
                      },
                      splashRadius: 90,
                      padding: const EdgeInsets.all(0),
                      icon: SizedBox(
                        height: 20,
                        child: SvgPicture.asset(
                          'assets/instagram.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton.outlined(
                      onPressed: () {
                        CustomCommands.openURLInBrowser(context,
                            link: 'github.com/ZhiaDev');
                      },
                      splashRadius: 90,
                      padding: const EdgeInsets.all(0),
                      icon: SizedBox(
                        height: 22,
                        child: SvgPicture.asset(
                          'assets/github.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton.outlined(
                      onPressed: () {
                        CustomCommands.openURLInBrowser(context,
                            link: 'zarinp.al/zhiadev');
                      },
                      splashRadius: 90,
                      padding: const EdgeInsets.all(0),
                      icon: SizedBox(
                        height: 20,
                        child: SvgPicture.asset(
                          'assets/coffee.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Drawer items
              SizedBox(
                height: 100,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Settings item
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/settings.svg',
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                      title: const Text("Settings"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ));
                      },
                    ),

                    // Quit item to exit the application
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/exit.svg',
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onSurfaceVariant,
                          BlendMode.srcIn,
                        ),
                      ),
                      title: const Text('Quit'),
                      onTap: () {
                        // Exit the application
                        exit(0);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }
}
