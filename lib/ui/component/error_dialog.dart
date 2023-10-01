import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satorist/ui/component/progress.dart';

import '../design/text_styles.dart';

Future<void> showError(BuildContext context, dynamic error) async {
  var message = 'エラーが発生しました。';
  if (error is ArgumentError) {
    message = error.message as String;
  }
  OriginalProgress.showMessageDialog(
    context,
    message: message,
    onPressed: () => GoRouter.of(context).pop(),
  );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
  });

  factory ErrorDialog.standard({
    Key? key,
    required String message,
    VoidCallback? onPressed,
    required BuildContext context,
  }) {
    return ErrorDialog(
      key: key,
      message: message,
      buttonLabel: '確認',
      onPressed: onPressed ??
          () {
            GoRouter.of(context).pop();
          },
    );
  }

  final String? title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title!,
              style: textStyle(const [fontSize18, bold]),
            )
          : null,
      content: Text(
        message,
        style: textStyle(const [fontSize15]),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
