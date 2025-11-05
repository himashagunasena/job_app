import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CommonSearchBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(String) onchange;
  final String? searchHint;
  final FocusNode? focusNode;
  const CommonSearchBar(
      {super.key,
      required this.textEditingController,
      required this.onchange,
      this.searchHint,
      this.focusNode});

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      style: TextStyle(color: AppColors().primaryColor(context)),
      decoration: InputDecoration(
          hintText: widget.searchHint ?? "Search your dream jobs",
          hintStyle: TextStyle(color: AppColors().primaryColor(context)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
      autofocus: false,
      onChanged: (value) {
        widget.onchange(value);
      },
    );
  }
}
