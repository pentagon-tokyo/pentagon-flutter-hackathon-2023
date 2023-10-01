// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter/material.dart';

class RippleEffect extends StatefulWidget {
  const RippleEffect({
    this.onTap,
    required this.child,
    this.radius = 0,
    this.delaySeconds = 1,
    this.onLongPress,
    super.key,
  });
  final VoidCallback? onTap;
  final Widget child;
  final double radius;
  final int delaySeconds;
  final GestureLongPressCallback? onLongPress;

  @override
  // ignore: library_private_types_in_public_api
  _RippleEffectState createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect> {
  bool _isDisabled = false;
  CancelableOperation<void>? _cancelableOperation;

  @override
  void dispose() {
    _cancelableOperation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        onTap: _isDisabled
            ? null
            : () {
                setState(() => _isDisabled = true);
                if (widget.onTap != null) {
                  widget.onTap!();
                }
                _cancelableOperation = CancelableOperation<void>.fromFuture(
                  Future<void>.delayed(Duration(seconds: widget.delaySeconds)),
                );
                setState(() => _isDisabled = false);
              },
        onLongPress: widget.onLongPress,
        child: widget.child,
      ),
    );
  }
}
