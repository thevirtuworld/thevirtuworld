import 'package:flutter/material.dart';
import 'dart:math' as math;

class JoystickControl extends StatefulWidget {
  final void Function(Offset) onDirectionChanged;
  final double size;

  const JoystickControl({
    Key? key,
    required this.onDirectionChanged,
    this.size = 150,
  }) : super(key: key);

  @override
  State<JoystickControl> createState() => _JoystickControlState();
}

class _JoystickControlState extends State<JoystickControl> {
  Offset _position = Offset.zero;
  final double _maxDistance = 50.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onDragStart,
      onPanUpdate: _onDragUpdate,
      onPanEnd: _onDragEnd,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
        ),
        child: Center(
          child: Transform.translate(
            offset: _position,
            child: Container(
              width: widget.size * 0.4,
              height: widget.size * 0.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final delta = details.localPosition - center;
    _updatePosition(delta);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final delta = details.localPosition - center;
    _updatePosition(delta);
  }

  void _onDragEnd(DragEndDetails details) {
    _position = Offset.zero;
    widget.onDirectionChanged(Offset.zero);
    setState(() {});
  }

  void _updatePosition(Offset delta) {
    double distance = delta.distance;

    if (distance > _maxDistance) {
      delta = delta * (_maxDistance / distance);
      distance = _maxDistance;
    }

    _position = delta;

    // Normalize to get direction vector
    final normalizedDelta =
        distance > 0
            ? Offset(delta.dx / _maxDistance, delta.dy / _maxDistance)
            : Offset.zero;

    widget.onDirectionChanged(normalizedDelta);
    setState(() {});
  }
}
