import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '/utils/custom_commands.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.scaffoldKey,
    required this.isConnected,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final RxBool isConnected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        // Open the link to the repository on GitHub
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () async {
              CustomCommands.openURLInBrowser(
                context,
                link: 'github.com/ZhiaDev/mac-proxy-manager',
              );
            },
            tooltip: 'Repository link',
            padding: const EdgeInsets.all(0),
            icon: SvgPicture.asset(
              'assets/github.svg',
              height: 28,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(
          onPressed: () {
            // Open the app's drawer
            scaffoldKey.currentState!.openDrawer();
          },
          tooltip: 'Menu',
          padding: const EdgeInsets.all(0),
          icon: SvgPicture.asset(
            'assets/menu.svg',
            height: 28,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show a connection or disconnection icon based on the 'isConnected' value
          Obx(() {
            return isConnected.value
                ? SvgPicture.asset(
                    'assets/connect.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/disconnect.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  );
          }),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
