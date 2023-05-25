import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String title;
  final Function(String) onSubmitedCallBack;
  final Function() onClear;
  CustomAppBar({
    required this.searchController,
    required this.title,
    required this.onSubmitedCallBack,
    required this.onClear,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return _appBar2(context);
  }

  Widget _appBar2(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(preferredSize.height),
        child: TextField(
          onSubmitted: onSubmitedCallBack,
          controller: searchController,
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () {
                searchController.clear();
                onClear();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.amber,
              ),
            ),
            hintText: title,
            hintStyle: TextStyle(color: Colors.amber),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
