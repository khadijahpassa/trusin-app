import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class RoleDropdown extends StatefulWidget {
  final String? roleSelection;
  final ValueChanged<String?> onChanged;

  const RoleDropdown({
    super.key,
    required this.roleSelection,
    required this.onChanged,
  });

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  final List<String> roleList = ['Supervisor', 'Manager', 'Owner'];
  String? selectedRole;
  bool isDropdownOpen = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedRole = widget.roleSelection;
    _controller.text = selectedRole ?? '';
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => isDropdownOpen = false);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            readOnly: true, 
            onTap: _toggleDropdown,
            validator: (value) => value == null || value.isEmpty ? 'Pilih role dulu' : null,
            decoration: InputDecoration(
              hintText: "Pilih Role",
              hintStyle: TextStyle(color: text200, fontSize: body),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/icons/customer.svg', 
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(primary500, BlendMode.srcIn),
                ),
              ),
              suffixIcon: IconButton(
                icon: AnimatedRotation(
                  turns: isDropdownOpen ? 0.5 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down, color: text400),
                ),
                onPressed: _toggleDropdown,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              filled: true,
              fillColor: secondary200,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: text200),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: text200),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            style: TextStyle(fontSize: body),
          ),
          if (isDropdownOpen)
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150),
              child: Container(
                decoration: BoxDecoration(
                  color: secondary200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: roleList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        roleList[index],
                        style: TextStyle(fontSize: body, color: text400),
                      ),
                      onTap: () {
                        setState(() {
                          selectedRole = roleList[index];
                          _controller.text = selectedRole!;
                          isDropdownOpen = false;
                        });
                        widget.onChanged(selectedRole);
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
