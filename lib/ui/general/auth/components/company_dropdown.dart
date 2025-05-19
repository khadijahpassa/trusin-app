import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';

class CompanyDropdown extends StatefulWidget {
  final String? selectedCompany;
  final ValueChanged<String?> onChanged;
  final bool isSupervisor;
  final ValueChanged<bool> onNewCompanySelected;

  const CompanyDropdown({
    super.key,
    required this.selectedCompany,
    required this.onChanged,
    required this.isSupervisor,
    required this.onNewCompanySelected,
  });

  @override
  State<CompanyDropdown> createState() => _CompanyDropdownState();
}

class _CompanyDropdownState extends State<CompanyDropdown> {
  List<String> companyList = [];
  List<String> filteredList = [];
  bool isLoading = true;
  bool isDropdownOpen = false;
  String? selectedCompany;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedCompany = widget.selectedCompany;
    _controller.text = selectedCompany ?? '';
    _fetchCompanies();
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

  Future<void> _fetchCompanies() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (widget.isSupervisor) {
        // Supervisor bisa lihat banyak perusahaan
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'supervisor')
            .where('status', isEqualTo: 'approved')
            .get();

        final companies = snapshot.docs
            .map((doc) => doc['company'] as String)
            .toSet()
            .toList();

        companies.insert(0, "Perusahaan Belum Terdaftar");
        companies.sort();

        setState(() {
          companyList = companies;
          filteredList = companies.take(5).toList();
          isLoading = false;
        });
      } else {
        // CS, hanya tampilkan company user login
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (!userDoc.exists || !userDoc.data()!.containsKey('company')) {
          setState(() => isLoading = false);
          return;
        }

        final userCompany = userDoc['company'] as String;
        setState(() {
          companyList = [userCompany];
          filteredList = [userCompany];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error: $e");
    }
  }

  void _filterCompanies(String input) {
    setState(() {
      filteredList = companyList
          .where(
              (company) => company.toLowerCase().contains(input.toLowerCase()))
          .toList();
      isDropdownOpen = true;
    });
  }

  void _toggleDropdown() {
    setState(() => isDropdownOpen = !isDropdownOpen);
  }

  void _onCompanySelected(String company) {
    _controller.text = company;
    setState(() {
      selectedCompany = company;
      isDropdownOpen = false;
    });
    widget.onChanged(company);
    widget.onNewCompanySelected(company == "Perusahaan Belum Terdaftar");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _filterCompanies,
            onTap: () => setState(() => isDropdownOpen = true),
            validator: (value) =>
                value == null || value.isEmpty ? 'Pilih perusahaan dulu' : null,
            readOnly: false,
            decoration: InputDecoration(
              hintText: "Pilih Perusahaan",
              hintStyle: TextStyle(color: text200, fontSize: body),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  'assets/icons/building.svg',
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
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
            ),
            style: TextStyle(fontSize: body),
          ),
          if (isDropdownOpen && filteredList.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: secondary200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final company = filteredList[index];
                    return ListTile(
                      title: Text(
                        company,
                        style: TextStyle(
                          fontSize: body,
                          color:
                              selectedCompany == company ? primary500 : text400,
                        ),
                      ),
                      onTap: () => _onCompanySelected(company),
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