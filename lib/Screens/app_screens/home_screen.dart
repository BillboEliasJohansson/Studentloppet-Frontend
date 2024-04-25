import 'package:flutter/material.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildTopbar(context),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profileScreen);
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: Center(
          child: Image.network(
        'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3JyczlqOHhibzEwNGh5c3hwcWo3MmVnZzEzZWpkYjJpMG1jNTdicyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/etOX3h7ApZuDe7Fc5w/giphy-downsized-large.gif',
        fit: BoxFit.cover,
      )),
    );
  }

  /// Section Widget
  Widget _buildTopbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 0.v,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Midnattsloppet  \n",
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
