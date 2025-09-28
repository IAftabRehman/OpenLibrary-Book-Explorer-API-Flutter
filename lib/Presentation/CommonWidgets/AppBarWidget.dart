import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/Routes.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

/// Custom AppBar Widget
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String titleText;
  final bool searchIcon;
  final ValueChanged<bool>? onSearchToggle;
  final bool contactIcon;

  const AppBarWidget({
    super.key,
    required this.titleText,
    required this.searchIcon,
    this.onSearchToggle,
    this.contactIcon = false,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool openSearch = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      backgroundColor: themeProvider.appBarBackgroundColor,
      elevation: 5,
      shadowColor: themeProvider.primaryTextColor,

      /// Leading Icon
      leading: MyIconContainer(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icons.menu,
        iconSize: 30,
        iconColor: themeProvider.isNightMode ? Colors.white70 : Colors.black54,
      ),
      title: MyText(
        text: widget.titleText,
        color: themeProvider.primaryTextColor,
        fontWeight: FontWeight.bold,
        size: 22,
      ),
      centerTitle: true,
      actions: [
        /// Support Agent Icon
        widget.contactIcon
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MyIconContainer(
                  icon: Icons.support_agent_outlined,
                  iconColor: themeProvider.primaryTextColor,
                  iconSize: 30,
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, AppRoutes.contact);
                    });
                  },
                ),
              )
            : SizedBox(),

        /// Search Icon
        widget.searchIcon
            ? MyIconContainer(
                icon: openSearch ? Icons.close : Icons.search,
                iconColor: themeProvider.primaryTextColor,
                iconSize: 30,
                onTap: () {
                  setState(() {
                    openSearch = !openSearch;
                  });
                  widget.onSearchToggle?.call(openSearch); // 👈 notify parent
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
