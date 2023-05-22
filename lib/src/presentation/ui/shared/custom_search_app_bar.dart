import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _appBarHeight;
  final String _title;
  final TextEditingController _searchController;
  final Function(String) _onSearchChanged;
  final Widget _trailing;

  const CustomSearchAppBar({
    super.key,
    double appBarHeight = 60,
    required String title,
    required TextEditingController searchController,
    required Function(String) onSearchChanged,
    required Widget trailing,
  })  : _appBarHeight = appBarHeight,
        _title = title,
        _searchController = searchController,
        _onSearchChanged = onSearchChanged,
        _trailing = trailing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchBar(
            controller: _searchController,
            hintText: "Search",
            constraints: BoxConstraints(maxHeight: _appBarHeight - 10),
            leading: const Icon(MdiIcons.magnify),
            onChanged: _onSearchChanged,
            trailing: [_trailing],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight + kToolbarHeight);
}
