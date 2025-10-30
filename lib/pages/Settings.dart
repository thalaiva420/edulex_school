import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFECB495).withOpacity(0.2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildProfileCard(),
          const SizedBox(height: 20),
          _buildSectionTitle("General"),
          const SizedBox(height: 8),
          _buildTile(
            icon: Icons.notifications_active_outlined,
            title: "Notifications",
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
              },
              activeColor: const Color(0xFF4B352A),
            ),
          ),
          _buildTile(
            icon: Icons.account_circle_outlined,
            title: "My Profile",
            onTap: () {
              // Navigate to Profile Page
            },
          ),
          _buildTile(
            icon: Icons.assignment_outlined,
            title: "Attendance Reports",
            onTap: () {
              // Navigate to Attendance Reports
            },
          ),
          _buildTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              // Navigate to Change Password screen
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Appearance"),
          const SizedBox(height: 8),
          _buildTile(
            icon: isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
            title: "Dark Mode",
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() => isDarkMode = value);
              },
              activeColor: const Color(0xFF4B352A),
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Support"),
          const SizedBox(height: 8),
          _buildTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {
              // Navigate to Help & Support
            },
          ),
          _buildTile(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () {
              // Show About info
              showAboutDialog(
                context: context,
                applicationName: 'School Management App',
                applicationVersion: '1.0.0',
                children: [
                  const Text("Manage attendance, performance, and reports seamlessly."),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  // 🔹 Profile Card
  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFECB495), const Color(0xFFD99B7B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/150?img=12",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Ashutosh Kumar",
                  style: TextStyle(
                    color: Color(0xFF4B352A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Class Teacher - X B",
                  style: TextStyle(
                    color: Color(0xFF4B352A),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to profile edit
            },
            icon: const Icon(Icons.edit, color: Color(0xFF4B352A)),
          ),
        ],
      ),
    );
  }

  // 🔹 Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF4B352A),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  // 🔹 Setting Tile
  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE3CA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF4B352A)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF4B352A),
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF4B352A)),
        onTap: onTap,
      ),
    );
  }

  // 🔹 Logout Button
  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add logout confirmation
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("Logout", style: TextStyle(color: Color(0xFF4B352A))),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel", style: TextStyle(color: Color(0xFF4B352A))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  // Add logout logic here
                },
                child: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFECB495), Color(0xFFD99B7B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: const Center(
          child: Text(
            "Logout",
            style: TextStyle(
              color: Color(0xFF4B352A),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
