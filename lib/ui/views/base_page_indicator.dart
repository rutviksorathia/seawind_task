import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_corner/smooth_corner.dart';

class BasePageIndicator extends StatefulWidget {
  final List<dynamic> indicatorList;
  final int activeIndicatorIndex;
  final Color activeIndicatorColor;
  final Color indicatorColor;
  final double size;
  final Duration duration;
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;

  const BasePageIndicator({
    super.key,
    required this.indicatorList,
    required this.activeIndicatorIndex,
    this.activeIndicatorColor = Colors.black,
    this.indicatorColor = Colors.grey,
    this.size = 10,
    this.duration = const Duration(milliseconds: 150),
    this.padding = const EdgeInsets.symmetric(horizontal: 3),
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  State<BasePageIndicator> createState() => _BasePageIndicatorState();
}

class _BasePageIndicatorState extends State<BasePageIndicator> {
  @override
  Widget build(BuildContext context) {
    return widget.indicatorList.length.isGreaterThan(1)
        ? SizedBox(
            height: widget.size,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: widget.indicatorList.map(
                (e) {
                  var index = widget.indicatorList.indexOf(e);
                  bool isSelected = index == widget.activeIndicatorIndex;
                  return Padding(
                    padding: widget.padding,
                    child: AnimatedContainer(
                      duration: widget.duration,
                      decoration: ShapeDecoration(
                        shape: SmoothRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(widget.size * 0.5),
                          smoothness: 1,
                        ),
                        color: isSelected
                            ? widget.activeIndicatorColor
                            : widget.indicatorColor,
                      ),
                      height: isSelected ? widget.size : widget.size * 0.6,
                      width: isSelected ? widget.size : widget.size * 0.6,
                    ),
                  );
                },
              ).toList(),
            ),
          )
        : Container();
  }
}
