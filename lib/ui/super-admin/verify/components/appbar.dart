import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/verify_controller.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(53);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Kelola Pendaftaran',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final controller = Get.find<VerifyController>();
            await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(1000, 80, 16, 0), // posisinya
              items: [
                _buildCheckboxMenuItem('pending', controller),
                _buildCheckboxMenuItem('rejected', controller),
              ],
              elevation: 0,
            );
          },
          icon: SvgPicture.asset('assets/icons/filter.svg'),
        )
      ],
    );
  }
}

PopupMenuItem<String> _buildCheckboxMenuItem(String status, VerifyController controller) {
  return PopupMenuItem<String>(
    enabled: false,
    child: StatefulBuilder(
      builder: (context, setState) {
        final isSelected = controller.selectedStatuses.containsKey(status);
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              controller.selectedStatuses.remove(status);
            } else {
              controller.selectedStatuses[status] = status;
            }
            setState(() {}); // update UI checkbox
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status.capitalizeFirst!,
                style: const TextStyle(
                  color: primary500, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 16
                ),
              ),
              Checkbox(
                value: isSelected,
                onChanged: (_) {
                  if (isSelected) {
                    controller.selectedStatuses.remove(status);
                  } else {
                    controller.selectedStatuses[status] = status;
                  }
                  setState(() {});
                },
              )
            ],
          ),
        );
      },
    ),
  );
}
