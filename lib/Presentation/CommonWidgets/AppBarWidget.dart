import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/ChangeModeProvider.dart';
import '../Elements/CustomContainer.dart';
import '../Elements/CustomText.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String titleText;
  final bool searchIcon;
  const AppBarWidget({super.key, required this.titleText, required this.searchIcon});

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
      leading: MyIconContainer(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icons.menu,
        iconSize: 30,
        iconColor:
        themeProvider.isNightMode ? Colors.white70 : Colors.black54,
      ),
      title: MyText(
        text: widget.titleText,
        color: themeProvider.primaryTextColor,
        fontWeight: FontWeight.bold,
        size: 22,
      ),
      centerTitle: true,
      actions: [
        widget.searchIcon ? MyIconContainer(
          icon: openSearch ? Icons.close : Icons.search,
          iconColor: themeProvider.primaryTextColor,
          iconSize: 30,
          onTap: () {
            setState(() {
              openSearch = !openSearch;
            });
          },
        ) : SizedBox(),
      ],
    );
  }
}
