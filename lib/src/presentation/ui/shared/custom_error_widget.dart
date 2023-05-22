import 'package:flutter/material.dart';

class CustomErrorWidget extends StatefulWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorTitle,
    this.errorDescription,
    required this.errorActionButtons,
  });
  final String errorTitle;
  final String? errorDescription;
  final ErrorActionBtn errorActionButtons;

  @override
  State<CustomErrorWidget> createState() => _CustomErrorWidgetState();
}

class _CustomErrorWidgetState extends State<CustomErrorWidget> {
  final ValueNotifier<bool> progressIndicatorNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: progressIndicatorNotifier,
      builder: (context, value, child) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/icons8-rick-sanchez-400.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: FittedBox(
                  child: Text(
                    widget.errorTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              if (widget.errorDescription != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Text(
                    maxLines: 5,
                    widget.errorDescription!,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 34, bottom: 16),
                child: _getActionWidget(),
              ),
              SizedBox(
                height: 16,
                child: value ? const CircularProgressIndicator.adaptive() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getActionWidget() {
    if (widget.errorActionButtons is DualErrorActionButtons) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var item in (widget.errorActionButtons as DualErrorActionButtons).buttons)
            ElevatedButton(onPressed: () => _addDelayTo(item.action), child: Text(item.text)),
        ],
      );
    } else if (widget.errorActionButtons is SingleErrorActionButton) {
      final item = widget.errorActionButtons as SingleErrorActionButton;
      return ElevatedButton(onPressed: () => _addDelayTo(item.action), child: Text(item.text));
    } else {
      throw UnsupportedError("Unsupported button type, should be type of ErrorActionBtn");
    }
  }

  void _addDelayTo(Function() action) {
    if (mounted) {
      progressIndicatorNotifier.value = !progressIndicatorNotifier.value;
      Future.delayed(const Duration(milliseconds: 500)).then(
        (_) {
          action.call();
          progressIndicatorNotifier.value = !progressIndicatorNotifier.value;
        },
      );
    } else {
      return;
    }
  }

  @override
  void dispose() {
    progressIndicatorNotifier.dispose();
    super.dispose();
  }
}

class SingleErrorActionButton extends ErrorActionBtn {
  final String text;
  final VoidCallback action;

  SingleErrorActionButton({required this.text, required this.action});
}

class DualErrorActionButtons extends ErrorActionBtn {
  final List<SingleErrorActionButton> buttons;

  DualErrorActionButtons({required this.buttons});
}

class ErrorActionBtn {}
