import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-details';

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)!.settings.arguments) as Map<String, dynamic>;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.32,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.32,
                // child: ,
                color: Colors.red,
                child: Image(
                  // width: double.infinity,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    args['userimage'],
                  ),
                ),
              ),
              title: Text(
                args['username'],
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 800,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
