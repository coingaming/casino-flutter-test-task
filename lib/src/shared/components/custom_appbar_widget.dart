import 'package:casino_test/src/shared/styles/appColors.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final String title;
  final Function(String) onSubmitedCallBack;
  final Function(String) onClearCallback;
  final bool hasConnection;
  CustomAppBarWidget({
    required this.searchController,
    required this.title,
    required this.onSubmitedCallBack,
    required this.onClearCallback,
    required this.hasConnection,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return _appBar(context);
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(preferredSize.height),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              SizedBox(
                child: hasConnection
                    ? Icon(
                        Icons.wifi,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.wifi_off,
                        color: Colors.red,
                      ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
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
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppColors.secondary,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
