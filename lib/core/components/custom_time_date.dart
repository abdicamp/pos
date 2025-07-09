import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core.dart';

class CustomDatePickerTime extends StatefulWidget {
  final void Function(DateTime selectedDate)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? beforeDate;
  final Widget? prefix;
  final String label;
  final bool showLabel;
  final bool? readOnly;
  final FormFieldValidator<String>? validator;

  const CustomDatePickerTime({
    super.key,
    required this.label,
    this.readOnly = false,
    this.showLabel = true,
    this.beforeDate,
    this.initialDate,
    this.onDateSelected,
    this.prefix,
    this.validator,
  });

  @override
  State<CustomDatePickerTime> createState() => _CustomDatePickerTimeState();
}

class _CustomDatePickerTimeState extends State<CustomDatePickerTime> {
  late TextEditingController controller;
  late DateTime selectedDate;
  late DateTime selectedDateBefore;

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.initialDate?.toFormattedDateWithTime(),
    );
    selectedDateBefore = widget.beforeDate ?? DateTime.now();
    selectedDate = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          controller.text = selectedDate.toFormattedDateWithTime();
        });

        if (widget.onDateSelected != null) {
          widget.onDateSelected!(selectedDate);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12.0),
        ],
        TextFormField(

          validator: widget.validator,
          controller: controller,
          onTap: () => widget.readOnly == true ? Null : _selectDateTime(context),
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Assets.icons.calendar.svg(),
            ),
            hintText: widget.initialDate != null
                ? selectedDate.toFormattedDateWithTime()
                : widget.label,
          ),
        ),
      ],
    );
  }
}

extension DateTimeExt on DateTime {
  String toFormattedDateWithTime() {
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(this);
    String formattedTime = DateFormat('HH:mm').format(this);

    return '$formattedDate $formattedTime';
  }
}
