import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';

class ShowAlertDailogWidget extends StatefulWidget {
  ShowAlertDailogWidget({super.key});

  @override
  State<ShowAlertDailogWidget> createState() => _ShowAlertDailogWidgetState();
}

class _ShowAlertDailogWidgetState extends State<ShowAlertDailogWidget> {
  bool isSelected = false;
  int selectedIndex = 1;

  List<int> priorityIndex = List.generate(10, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            "Task Priority",
            style: TextStyle(
              fontSize: FontSize.labelAndFontButton,
              fontWeight: FontWeight.w700,
              color: AppColor.titleOfAlartDailog,
            ),
          ),
          Divider(indent: 7),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: priorityIndex.map((e) {
            return ItemPiriorty(
              index: e,
              isSelected: selectedIndex == e,
              onTap: () {
                setState(() {
                  selectedIndex = e;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ItemPiriorty extends StatelessWidget {
  const ItemPiriorty({
    super.key,
    required this.index,
    required this.onTap,
    required this.isSelected,
  });

  final bool isSelected;
  final int index;
  final VoidCallback? onTap;
   

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.parimerayColor
              : AppColor.colorTextInButton,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(IconModel.flag), Text(index.toString())],
        ),
      ),
    );
  }
}
