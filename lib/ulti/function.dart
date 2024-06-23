import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
  const backgroundColor = Color(0xFF292929);
  const textColor = Colors.white;
  const accentColor = Colors.redAccent;

  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_forever, color: accentColor, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Xóa mục này?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bạn không thể hoàn tác hành động này.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DialogButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  text: 'Hủy',
                  color: Colors.grey[800]!,
                  textColor: textColor,
                ),
                _DialogButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  text: 'Xóa',
                  color: accentColor,
                  textColor: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showCustomToast({
  required BuildContext context,
  required String message,
  required String imagePath,
  Color backgroundColor = Colors.black54,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 2),
}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 24.0,
          height: 24.0,
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: duration,
  );
}

class _DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;

  const _DialogButton({
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text),
    );
  }
}