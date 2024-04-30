import 'package:flutter/material.dart';
import 'package:simple_login_app/repos/role_repo.dart';
import 'package:simple_login_app/repos/user_repo.dart';
import 'package:simple_login_app/widget/user_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key, required this.currentUsername, required this.title})
      : super(key: key);

  final String title;
  final String currentUsername;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? userList = [];
  List? filteredUserList = [];
  List<dynamic> roleItem = [];
  String role = "";
  String dropdownValue = "";
  @override
  void initState() {
    super.initState();
    _getUserRoles();
    _getRolesItem();
  }

  void _getUserList() async {
    userList = await getUserList();
    if (userList == null) {
      filteredUserList = null;
    } else {
      filteredUserList = List.from(userList!);
    }
    setState(() {
      dropdownValue = "0";
    });
  }

  void _getUserRoles() async {
    role = await getUserRoles(widget.currentUsername);
    setState(() {});
  }

  void _getRolesItem() async {
    roleItem = await getRoles();
    roleItem.insert(0, {"id": 0, "role": "All"});
    dropdownValue = roleItem.first["id"].toString();
    setState(() {});
  }

  Widget _buildUserList(List<dynamic>? listData) {
    if (listData != null) {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 12.0,
        ),
        itemBuilder: ((context, index) {
          Map<String, dynamic> data = listData[index];
          return UserTile(
              imagePath: "lib/assets/resources/${data["image"]}",
              username: data["name"],
              role: (data["role_id"] == 1) ? "Employee" : "Manager");
        }),
        itemCount: listData.length,
      );
    } else {
      return Text("Invalid Role");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello ${widget.currentUsername}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Role : $role"),
                  ],
                ),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: _getUserList,
                  child: const Text("Get User List"),
                ),
              ],
            ),
          ),
          if (role == "Manager")
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                children: [
                  const Text("Filter"),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        if (dropdownValue == 0.toString()) {
                          filteredUserList = List.from(userList!);
                        } else {
                          filteredUserList = userList!
                              .where((element) =>
                                  element["role_id"] ==
                                  int.parse(dropdownValue))
                              .toList();
                        }
                      });
                    },
                    items: roleItem.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value["id"].toString(),
                        child: Text(value["role"].toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: _buildUserList(filteredUserList),
            ),
          ),
        ],
      ),
    );
  }
}
