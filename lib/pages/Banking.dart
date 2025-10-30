import 'package:flutter/material.dart';

const double defaultPadding = 16.0;

// --- App Theme Colors ---
const Color kBaseColor = Color(0xFFECB495);
const Color kHighlightColor = Color(0xFFD99B7B);
const Color kActiveColor = Color(0xFFE6A777);
const Color kAccentColor = Color(0xFFDC8E67);
const Color kTextDark = Color(0xFF4B352A);

class Banking extends StatelessWidget {
  const Banking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECB495).withOpacity(0.2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Summary Card ----
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFCDFCF).withOpacity(0.95), Color(
                      0xFFEAE7E6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: kTextDark.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Balance Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kTextDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem(
                        "Paid",
                        "₹ 35,000",
                        kActiveColor,
                        Icons.check_circle_outline,
                      ),
                      _buildSummaryItem(
                        "Pending",
                        "₹ 8,500",
                        kAccentColor,
                        Icons.hourglass_bottom,
                      ),
                      _buildSummaryItem(
                        "Total",
                        "₹ 43,500",
                        kHighlightColor,
                        Icons.account_balance_wallet_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: defaultPadding * 1.5),

            // ---- Fee Status Section ----
            const Text(
              "Your Fee Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 10),

            _buildFeeCard(
              title: "Tuition Fee",
              amount: "₹ 25,000",
              status: "Paid",
              color: kActiveColor,
              date: "Paid on: 10 Oct 2025",
              icon: Icons.school,
            ),
            _buildFeeCard(
              title: "Bus Fee",
              amount: "₹ 3,000",
              status: "Pending",
              color: kAccentColor,
              date: "Due on: 10 Nov 2025",
              icon: Icons.directions_bus,
            ),
            _buildFeeCard(
              title: "Library Fine",
              amount: "₹ 300",
              status: "Paid",
              color: kActiveColor,
              date: "Paid on: 28 Sep 2025",
              icon: Icons.menu_book,
            ),
            _buildFeeCard(
              title: "Exam Fee",
              amount: "₹ 5,200",
              status: "Pending",
              color: kAccentColor,
              date: "Due on: 5 Dec 2025",
              icon: Icons.edit_document,
            ),
            _buildFeeCard(
              title: "Sports Fee",
              amount: "₹ 2,000",
              status: "Paid",
              color: kActiveColor,
              date: "Paid on: 12 Aug 2025",
              icon: Icons.sports_soccer,
            ),

            const SizedBox(height: defaultPadding * 2),

            // ---- Upcoming Payments ----
            const Text(
              "Upcoming / Pending Payments",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 12),

            _buildUpcomingPaymentCard(
              title: "Bus Fee (Term 2)",
              dueDate: "Due in 10 days",
              amount: "₹ 3,000",
            ),
            _buildUpcomingPaymentCard(
              title: "Exam Fee (Mid Term)",
              dueDate: "Due in 25 days",
              amount: "₹ 5,200",
            ),

            const SizedBox(height: defaultPadding * 1.5),

            // ---- Support / Help ----
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kHighlightColor, kBaseColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Need Help?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: kTextDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Contact the school’s accounts department for any billing or payment issues.",
                    style: TextStyle(fontSize: 13, color: kTextDark),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.support_agent, color: Colors.white),
                    label: const Text(
                      "Contact Support",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Summary Card Item ----
  static Widget _buildSummaryItem(
      String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 24,
          child: Icon(icon, color: kTextDark, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: kTextDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---- Fee Card ----
  static Widget _buildFeeCard({
    required String title,
    required String amount,
    required String status,
    required Color color,
    required String date,
    required IconData icon,
  }) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          radius: 24,
          child: Icon(icon, color: kTextDark, size: 26),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: kTextDark,
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(fontSize: 13, color: kTextDark),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Upcoming Payment Card ----
  static Widget _buildUpcomingPaymentCard({
    required String title,
    required String dueDate,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kTextDark.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading:
        const Icon(Icons.payment_rounded, color: kHighlightColor, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: kTextDark,
          ),
        ),
        subtitle: Text(
          dueDate,
          style: const TextStyle(color: kAccentColor, fontSize: 13),
        ),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: kTextDark,
          ),
        ),
      ),
    );
  }
}
