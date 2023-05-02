import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomErrorCard extends StatelessWidget {
  const BottomErrorCard({Key? key, this.title, this.description, this.onPressed})
      : super(key: key);

  final String? title;
  final String? description;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: ListBody(
        children: <Widget>[
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.sp,
          ),
          Container(
            width: 50.sp,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text('Reload'),
            ),
          )
        ],
      ),
    );
  }
}
