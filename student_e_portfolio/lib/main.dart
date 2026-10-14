import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Student E-Portfolio',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
    home: const LoginPage(),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();
  final roll = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() { roll.dispose(); password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420),
        child: Form(key: form, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircleAvatar(radius: 52, backgroundColor: Color(0xFFE8EAF6), child: Icon(Icons.person, size: 58, color: Colors.indigo)),
          const SizedBox(height: 18),
          Text('Student E-Portfolio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          TextFormField(controller: roll, decoration: const InputDecoration(labelText: 'Roll Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.badge_outlined)), validator: (v) => v == null || v.trim().isEmpty ? 'Enter your roll number' : null),
          const SizedBox(height: 14),
          TextFormField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock_outline)), validator: (v) => v == null || v.isEmpty ? 'Enter a password' : null),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () {
            if (form.currentState!.validate()) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
          }, child: const Text('Login'))),
          const SizedBox(height: 8),
          const Text('Demo only: any non-empty roll number and password work.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ])),
      ),
    )),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int index = 0;
  final titles = const ['Academic Details', 'Certifications', 'Activities', 'Achievements'];
  final pages = const [AcademicsPage(), CertificatesPage(), ActivitiesPage(), AchievementsPage()];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titles[index]), actions: [IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())), icon: const Icon(Icons.logout), tooltip: 'Logout')]),
    body: pages[index],
    bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v), destinations: const [
      NavigationDestination(icon: Icon(Icons.school_outlined), label: 'Academics'),
      NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Certificates'),
      NavigationDestination(icon: Icon(Icons.interests_outlined), label: 'Activities'),
      NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Achievements'),
    ]),
  );
}

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      ['B.Tech CSE', 'BVRIT Hyderabad College of Engineering for Women', '2024–2028', 'CGPA 9.43*'],
      ['Intermediate', 'Resonance Junior College', '2022–2024', '98.60%'],
      ['Secondary Education', 'Pragathi Central School', '2021–2022', '95.80%'],
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Education', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        const Text('*CGPA reported up to IV semester.'),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(
          columnSpacing: 18, dataRowMinHeight: 64, dataRowMaxHeight: 92,
          columns: const [
            DataColumn(label: SizedBox(width: 105, child: Text('Course'))),
            DataColumn(label: SizedBox(width: 180, child: Text('Institution'))),
            DataColumn(label: SizedBox(width: 105, child: Text('Year'))),
            DataColumn(label: SizedBox(width: 95, child: Text('Score'))),
          ],
          rows: data.map((r) => DataRow(cells: [
            DataCell(SizedBox(width: 105, child: Text(r[0]))),
            DataCell(SizedBox(width: 180, child: Text(r[1], softWrap: true))),
            DataCell(SizedBox(width: 105, child: Text(r[2]))),
            DataCell(SizedBox(width: 95, child: Text(r[3]))),
          ])).toList(),
        )),
      ]))),
      const Card(child: ListTile(leading: Icon(Icons.code), title: Text('Technical Skills'), subtitle: Text('Java, Python, C, MySQL, HTML, CSS, basic JavaScript'))),
      const Card(child: ListTile(leading: Icon(Icons.computer), title: Text('Tools'), subtitle: Text('MS Word, Excel, PowerPoint'))),
    ]);
  }
}

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});
  static const items = [
    ['Generative AI for Beginners', 'Udemy · June 2026'],
    ['OOP Through Java', 'CodeChef · November 2025'],
    ['Python Course for Beginners: Mastering the Essentials', 'Scaler · May 2025'],
    ['Python Course for Beginners', 'Simplilearn · May 2025'],
  ];
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    for (final item in items) Card(child: ListTile(
      leading: const CircleAvatar(child: Icon(Icons.workspace_premium_outlined)),
      title: Text(item[0]), subtitle: Text(item[1]),
      trailing: IconButton(icon: const Icon(Icons.open_in_new), tooltip: 'View certificate', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add the certificate URL to enable this button.')))),
    )),
  ]);
}

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});
  static const items = [
    ['Organizing Committee Member – Industry Academia Conclave 2026', 'SWE Chapter'],
    ['Agentic AI Workshop', 'Four-week workshop'],
    ['UI/UX Design Workshop', 'HCL workshop at BVRITH'],
    ['Winter Coding Contest 5.0', 'ACM Student Chapter, VNR VJIET'],
    ['Bug Bounty in C Programs', 'BVRITH'],
    ['Cybersecurity and Safe Internet Practices', 'Seminar'],
    ['Carnatic Vocal Music', 'Three years of training'],
    ['Throwball', 'Second prize in an intraschool competition'],
    ['Cultural Events', 'Anchored school events'],
  ];
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    for (final item in items) Card(child: ListTile(leading: const Icon(Icons.stars_outlined), title: Text(item[0]), subtitle: Text(item[1]))),
    const Padding(padding: EdgeInsets.all(8), child: Text('Music training is listed as an activity; audio playback is not configured.', style: TextStyle(color: Colors.grey, fontSize: 12))),
  ]);
}

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});
  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}
class _AchievementsPageState extends State<AchievementsPage> {
  final controller = PageController();
  Timer? timer;
  int current = 0;
  final items = const [
    ['Merit Medal', 'Merit Medal for Outstanding Performance in TSBIE Board Examinations.', Icons.military_tech],
    ['Mackathon – Second Prize', 'Second prize for a Missing Person Surveillance System.', Icons.emoji_events],
    ['Research Paper Presentation', 'Co-presented a paper at ICSMET 2025 on AI-powered lithium-ion battery recycling.', Icons.science],
    ['R&D Showcase', 'Presented a battery recycling project at the R&D Showcase.', Icons.lightbulb],
  ];
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (controller.hasClients) controller.animateToPage((current + 1) % items.length, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }
  @override
  void dispose() { timer?.cancel(); controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Column(children: [
    Expanded(child: PageView.builder(controller: controller, itemCount: items.length, onPageChanged: (v) => setState(() => current = v), itemBuilder: (context, i) => Padding(
      padding: const EdgeInsets.all(20),
      child: Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(items[i][2] as IconData, size: 82, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text(items[i][0] as String, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 14),
        Text(items[i][1] as String, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
      ]))),
    ))),
    Padding(padding: const EdgeInsets.only(bottom: 18), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(items.length, (i) => Container(
      width: i == current ? 22 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(color: i == current ? Theme.of(context).colorScheme.primary : Colors.grey.shade400, borderRadius: BorderRadius.circular(8)),
    )))),
  ]);
}
