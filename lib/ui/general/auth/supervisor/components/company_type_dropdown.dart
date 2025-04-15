import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class CompanyTypeDropdown extends StatefulWidget {
  final String? companyTypeSelection;
  final ValueChanged<String?> onChanged;

  const CompanyTypeDropdown({
    super.key,
    required this.companyTypeSelection,
    required this.onChanged,
  });

  @override
  _CompanyTypeDropdownState createState() => _CompanyTypeDropdownState();
}

class _CompanyTypeDropdownState extends State<CompanyTypeDropdown> {
  final List<String> roleList = [
    'Lainnya',
    'PT (Perseroan Terbatas)',
    'CV (Commanditaire Vennootschap)',
    'Perusahaan Perseorangan',
    'Firma',
    'Koperasi',
    'BUMN (Badan Usaha Milik Negara)',
    'BUMD (Badan Usaha Milik Daerah)'  ];
  String? selectedCompanyType;
  bool isDropdownOpen = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedCompanyType = widget.companyTypeSelection;
    _controller.text = selectedCompanyType ?? '';
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
            validator: (value) => value == null || value.isEmpty ? 'Pilih jenis perusahaan dulu' : null,
            decoration: InputDecoration(
              hintText: "Pilih Jenis Perusahaan",
              hintStyle: TextStyle(color: text200, fontSize: body),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/icons/business_category.svg', 
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
                          selectedCompanyType = roleList[index];
                          _controller.text = selectedCompanyType!;
                          isDropdownOpen = false;
                        });
                        widget.onChanged(selectedCompanyType);
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

