import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';

class ButtonAddCs extends StatelessWidget {
  const ButtonAddCs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius:BorderRadius.circular(12),
        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftarin akun untuk Customer Service!',
                    style: TextStyle(
                      fontSize: body,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () {
                      Get.toNamed('/register-cs');
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(color: secondary100, fontSize: caption),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/images/customer_service.png')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
