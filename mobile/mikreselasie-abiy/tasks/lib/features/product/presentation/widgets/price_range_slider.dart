import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues initialRange;
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.initialRange,
    required this.onChanged,
  });

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = widget.initialRange;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: const Color(0xFF3F51F3), // Blue track
        inactiveTrackColor: Colors.grey.shade300, // Grey background
        thumbColor: Colors.white, // White thumbs
        overlayColor: const Color(
          0x333F51F3,
        ), // Slightly transparent when pressed
        trackHeight: 10,

        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 2),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 6,
        ),
      ),
      child: RangeSlider(
        values: _currentRange,
        min: widget.min,
        max: widget.max,
        divisions: ((widget.max - widget.min) / 10).round(),

        onChanged: (values) {
          setState(() {
            _currentRange = values;
          });
          widget.onChanged(values);
        },
      ),
    );
  }
}
