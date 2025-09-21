import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/features/user/domain/enitities/user_profile_entity.dart';
import 'package:share_blog/features/user/presentation/bloc/user_bloc.dart';
import 'package:share_blog/services/token/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with AutomaticKeepAliveClientMixin {
  late Future<String?> _getAccessToken;

  void getAccessToken() {}

  @override
  void initState() {
    super.initState();
    _getAccessToken = TokenStorage.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String?>(
          future: _getAccessToken,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error");
            } else if (snapshot.hasData && snapshot.data != null) {
              context.read<UserBloc>().add(
                GetCurrentProfileEvent(accessToken: snapshot.data!),
              );
              return BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserFaile) {
                    return Text("Get user error ${state.failure}");
                  } else if (state is UserSucessfuly) {
                    return userProfile(state.userProfileEntity);
                  } else {
                    return Text("User not found");
                  }
                },
              );
            }
            return Text("Token null");
          },
        ),
      ),
    );
  }

  Widget userProfile(UserProfileEntity userProfile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),

          // Avatar
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/300", // placeholder image
            ),
          ),
          const SizedBox(height: 15),

          // Name
          Text(
            "${userProfile.firstName} ${userProfile.lastName}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Email
          Text(userProfile.email, style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 20),

          // Info Cards
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.face, color: Colors.deepPurple),
                    title: const Text("User Name"),
                    subtitle: Text(userProfile.username),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.face, color: Colors.deepPurple),
                    title: const Text("Facebook"),
                    subtitle: Text(userProfile.facebook ?? "Add link Facebook"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                    ),
                    title: const Text("Instagram"),
                    subtitle: Text(
                      userProfile.instagram ?? "Add link Instagram",
                    ),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                    ),
                    title: const Text("Website"),
                    subtitle: Text(userProfile.webSite ?? "Add link Website"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                    ),
                    title: const Text("X"),
                    subtitle: Text(userProfile.x ?? "Add link X"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                    ),
                    title: const Text("Youtube"),
                    subtitle: Text(userProfile.youtube ?? "Add link Youtube"),
                    trailing: const Icon(Icons.edit),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Logout Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.errorColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout, color: AppPallete.backgroundColor),
            label: const Text(
              "Logout",
              style: TextStyle(color: AppPallete.backgroundColor),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
