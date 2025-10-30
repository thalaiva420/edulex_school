import 'package:flutter/material.dart';
import 'dart:math';

class Student {
  final String name;
  final String imageUrl;
  final int totalDays;
  int presentDays;
  bool? isPresent;

  Student({
    required this.name,
    required this.imageUrl,
    required this.totalDays,
    required this.presentDays,
    this.isPresent,
  });
}

class StudentAttendancePage extends StatefulWidget {
  final String className;
  final String section;

  const StudentAttendancePage({
    super.key,
    required this.className,
    required this.section,
  });

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage>
    with SingleTickerProviderStateMixin {
  final List<Student> students = [
    Student(
        name: "Aarav Sharma",
        imageUrl: "https://i.pravatar.cc/150?img=1",
        totalDays: 20,
        presentDays: 15),
    Student(
        name: "Riya Patel",
        imageUrl: "https://i.pravatar.cc/150?img=2",
        totalDays: 20,
        presentDays: 14),
    Student(
        name: "Kabir Singh",
        imageUrl: "https://i.pravatar.cc/150?img=3",
        totalDays: 20,
        presentDays: 18),
    Student(
        name: "Ananya Das",
        imageUrl: "https://i.pravatar.cc/150?img=4",
        totalDays: 20,
        presentDays: 16),
    Student(
        name: "Anaya Das",
        imageUrl: "https://images.pexels.com/photos/1391499/pexels-photo-1391499.jpeg",
        totalDays: 20,
        presentDays: 16),
  ];

  int currentIndex = 0;
  bool allDone = false;

  // card dragging state
  Offset _cardOffset = Offset.zero;
  double _rotation = 0.0;

  // animation controller for returning/exit animation
  late final AnimationController _animController;
  Animation<Offset>? _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animController.addListener(() {
      if (_animation != null) {
        setState(() {
          _cardOffset = _animation!.value;
          _rotation = _cardOffset.dx / 300;
        });
      }
    });

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // If we were animating an exit (off-screen), the caller already handled index increment.
        // If we animated back to center, just clear animation flags.
        _isAnimating = false;
        _animation = null;
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Class ${widget.className} ${widget.section}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor:  Color(0xFFECB495),
        centerTitle: true,
      ),
      body: allDone ? _buildSummaryView() : _buildSwipeView(),
    );
  }

  Widget _buildSwipeView() {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // compute overlay color & opacity based on drag
    Color overlayColor = Colors.transparent;
    double overlayOpacity = 0.0;
    final dx = _cardOffset.dx;
    final dxAbs = dx.abs();
    // maximum opacity cap
    const maxOpacity = 0.55;
    final computedOpacity = (dxAbs / screenWidth).clamp(0.0, 1.0) * maxOpacity;

    if (dx > 0) {
      overlayColor = Colors.green.withOpacity(computedOpacity);
      overlayOpacity = computedOpacity;
    } else if (dx < 0) {
      overlayColor = Colors.red.withOpacity(computedOpacity);
      overlayOpacity = computedOpacity;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background base
        Positioned.fill(
          child: Container(color: Colors.grey.shade100),
        ),

        // Full-screen overlay color hint (green or red) - centered effect
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: overlayColor.withOpacity(overlayOpacity),
            ),
          ),
        ),

        // Center column for vertical centering
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Optional header or spacing if you want
              const SizedBox(height: 8),

              // Stack of cards (peek + top)
              SizedBox(
                height: 420,
                width: screenWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Next card peeking below
                    if (currentIndex + 1 < students.length)
                      Positioned(
                        top: 24,
                        child: _buildStudentCard(
                          students[currentIndex + 1],
                          scale: 0.95,
                          opacity: 0.85,
                        ),
                      ),

                    // Current draggable card
                    if (currentIndex < students.length)
                      GestureDetector(
                        onPanStart: (_) {
                          if (_isAnimating) return;
                        },
                        onPanUpdate: (details) {
                          if (_isAnimating) return;
                          setState(() {
                            _cardOffset += details.delta;
                            _rotation = _cardOffset.dx / 300;
                          });
                        },
                        onPanEnd: (details) {
                          if (_isAnimating) return;
                          final threshold = screenWidth * 0.25;
                          if (_cardOffset.dx > threshold) {
                            // animate off to right
                            _animateCardOff(isRight: true);
                          } else if (_cardOffset.dx < -threshold) {
                            // animate off to left
                            _animateCardOff(isRight: false);
                          } else {
                            // animate back to center
                            _animateCardToCenter();
                          }
                        },
                        child: Transform.translate(
                          offset: _cardOffset,
                          child: Transform.rotate(
                            angle: _rotation * pi / 12,
                            child: _buildStudentCard(students[currentIndex]),
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Hint text centered
              const Text(
                "Swipe → Present | Swipe ← Absent",
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _animateCardToCenter() {
    _isAnimating = true;
    _animation = Tween<Offset>(begin: _cardOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.reset();
    _animController.forward().then((_) {
      _isAnimating = false;
      _cardOffset = Offset.zero;
      _rotation = 0.0;
      _animation = null;
    });
  }

  void _animateCardOff({required bool isRight}) {
    // set present/absent now (so summary reflects it)
    final student = students[currentIndex];
    setState(() {
      student.isPresent = isRight;
      if (isRight) student.presentDays++;
    });

    _isAnimating = true;
    final screenWidth = MediaQuery.of(context).size.width;
    final endOffset = Offset(isRight ? screenWidth : -screenWidth, 0);

    _animation = Tween<Offset>(begin: _cardOffset, end: endOffset)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
    _animController.reset();
    _animController.forward().then((_) {
      // after exit animation, advance index and reset states
      _isAnimating = false;
      _animation = null;
      setState(() {
        _cardOffset = Offset.zero;
        _rotation = 0.0;
        currentIndex++;
        if (currentIndex >= students.length) {
          allDone = true;
        }
      });
    });
  }

  // 🔹 Card UI (reusable for top & peek card)
  Widget _buildStudentCard(Student student,
      {double scale = 1.0, double opacity = 1.0}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = min(screenWidth * 0.85, 520.0);

    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          height: 380,
          width: cardWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(student.imageUrl),
                backgroundColor: Colors.grey.shade200,
              ),
              const SizedBox(height: 20),
              Text(
                student.name,
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Present: ${student.presentDays}/${student.totalDays}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const Text(
                "Swipe → Present | Swipe ← Absent",
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Summary screen (unchanged behavior but null-safety guarded)
  Widget _buildSummaryView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final s = students[index];
              final presentFlag = s.isPresent ?? false;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: presentFlag
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading:
                  CircleAvatar(backgroundImage: NetworkImage(s.imageUrl)),
                  title: Text(s.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Present: ${s.presentDays}/${s.totalDays}"),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      presentFlag ? Colors.red : Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        s.isPresent = !(s.isPresent ?? false);
                        // If toggled to present and not already counted, adjust presentDays
                        if ((s.isPresent ?? false)) {
                          // avoid double increment if already counted earlier
                          // We can't know original state before this session here; keep simple toggle effect:
                          s.presentDays++;
                        } else {
                          // if marking absent, decrement if > 0
                          if (s.presentDays > 0) s.presentDays--;
                        }
                      });
                    },
                    child: Text(
                      presentFlag ? "Mark Absent" : "Mark Present",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B352A),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submitAttendance,
            child: const Text(
              "Submit Attendance",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _submitAttendance() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Attendance Submitted!"),
        content: const Text("All attendance records have been saved successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Return to attendance list
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
