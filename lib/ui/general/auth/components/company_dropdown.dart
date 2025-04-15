import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  _CompanyDropdownState createState() => _CompanyDropdownState();
}

class _CompanyDropdownState extends State<CompanyDropdown> {
  List<String> companyList = [];
  List<String> filteredList = [];
  bool isLoading = true;
  bool isError = false;
  String? selectedCompany;
  bool isDropdownOpen = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
    selectedCompany = widget.selectedCompany;
    _controller.text = selectedCompany ?? '';
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
    // await Future.delayed(Duration(seconds: 1));
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Supervisor')
          .where('status', isEqualTo: 'approved')
          .get();

      // Ambil nama-nama perusahaan unik dari supervisor yg udah disetujui
      final companies = snapshot.docs
          .map((doc) => doc['company'] as String)
          .toSet()
          .toList();

      // Masukin ke companyList
      companyList = [...companies];

      // Kalau yang login itu Supervisor, tambahin pilihan "Perusahaan Belum Terdaftar"
      if (widget.isSupervisor) {
        companyList.insert(0, "Perusahaan Belum Terdaftar");
      }

      // Sort hanya elemen selain "Perusahaan Belum Terdaftar"
      if (widget.isSupervisor) {
        companyList = [companyList.first, ...companyList.sublist(1)..sort()];
      } else {
        companyList.sort();
      }

      setState(() {
        isLoading = false;
        isError = false;
        filteredList = companyList.take(3).toList(); // ⬅ Ambil 3 data pertama aja
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      print("Error fetching companies: $e");
    }  
  }

  void _filterCompanies(String input) {
    setState(() {
      filteredList = companyList
          .where((company) => company.toLowerCase().contains(input.toLowerCase()))
          .toList();
      isDropdownOpen = true;
    });
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
            onChanged: _filterCompanies,
            onTap: () => setState(() => isDropdownOpen = true),
            validator: (value) => value == null || value.isEmpty ? 'Pilih perusahaan dulu' : null,
            decoration: InputDecoration(
              hintText: "Pilih Perusahaan",
              hintStyle: TextStyle(color: text200, fontSize: body),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    return ListTile(
                      title: Text(
                        filteredList[index],
                        style: TextStyle(fontSize: body, color: text400),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCompany = filteredList[index];
                          _controller.text = selectedCompany!;
                          isDropdownOpen = false;
                        });
                        bool isNewCompany = selectedCompany == "Perusahaan Belum Terdaftar";
                        widget.onChanged(selectedCompany);
                        widget.onNewCompanySelected(isNewCompany);
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
