import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      scrolledUnderElevation: 0,
      backgroundColor: kPrimaryColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            kLogo,
            height: 60,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            'Chat',
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
