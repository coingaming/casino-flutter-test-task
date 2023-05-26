import 'package:casino_test/src/shared/styles/appColors.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String title;
  final Function(String) onSubmitedCallBack;
  final Function(String) onClearCallback;
  CustomAppBarWidget({
    required this.searchController,
    required this.title,
    required this.onSubmitedCallBack,
    required this.onClearCallback,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return _appBar2(context);
  }

  Widget _appBar2(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(preferredSize.height),
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
                onSubmitted: onSubmitedCallBack,
                controller: searchController,
                cursorColor: AppColors.secondary,
                decoration: InputDecoration(
                  suffix: IconButton(
                    onPressed: () {
                      searchController.clear();
                      onClearCallback(searchController.text);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.secondary,
                    ),
                  ),
                  hintText: title,
                  hintStyle: TextStyle(color: AppColors.secondary),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // suffixIcon: Icon(
                  //   Icons.search,
                  //   color: AppColors.secondary,
                  // ),
                )),
          ),
        ),
      ),
    );
  }
}
