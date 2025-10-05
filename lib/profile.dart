import 'package:flutter/material.dart';
import 'package:worknow/job.dart';

class WorkerProfileApp extends StatelessWidget {
  final List<JobCreated> createdJobs;
  final String currentUserId;

  const WorkerProfileApp({
    super.key,
    required this.createdJobs,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: WorkerProfileScreen(
        createdJobs: createdJobs,
        currentUserId: currentUserId,
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Widget trailing;

  const ProfileSection({
    super.key,
    required this.title,
    required this.items,
    this.trailing = const Icon(Icons.add_circle_outline, color: Colors.blue),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: trailing,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline,
                          size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('No $title added yet.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey[600])),
              ),
          ],
        ),
      ),
    );
  }
}

class WorkerProfileScreen extends StatelessWidget {
  final List<JobCreated> createdJobs;
  final String currentUserId;

  const WorkerProfileScreen({
    super.key,
    required this.createdJobs,
    required this.currentUserId,
  });

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final userCreatedJobs = createdJobs.where((job) => job.creatorId == currentUserId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 16),
          ProfileSection(
            title: 'Skills',
            items: const [
              'Expert Mathematics',
              'Proficient in 3 Different languages (English,Telugu,Hindi)',
              'Customer Service and conflict resolution'
            ],
          ),
          ProfileSection(
            title: 'Experience',
            items: const [
              'Denim Cloth Showroom (2023 - Present)',
              'Home Tution (2024-Present)',
              'Barista - Local Coffee Shop (2021 - 2023)',
            ],
          ),
          ProfileSection(
            title: 'Availability',
            items: const [
              'Mondays: 8:00 PM - 10:00 PM',
              'Wednesdays: 5:00 PM - 8:00 PM',
              'Weekends: Fully Available',
            ],
          ),
          const SizedBox(height: 20),
          if (userCreatedJobs.isNotEmpty)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Jobs Created (${userCreatedJobs.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Icon(Icons.work_history, color: Colors.blue),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    ...userCreatedJobs.map((jobCreated) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobCreated.job.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${jobCreated.job.company} - ${jobCreated.job.location}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "Created on: ${_formatDate(jobCreated.createdDate)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (jobCreated.receivedApplications.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Applicants (${jobCreated.receivedApplications.length}):",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                ...jobCreated.receivedApplications.map((app) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                    child: Text(
                                      "- ${app.name} (${app.email}) - Applied: ${_formatDate(app.appliedDate)}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            )
                          else
                            Text(
                              "No applicants yet.",
                              style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            )
          else
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jobs Created',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1),
                    Text(
                      'No jobs created yet. Click the "+" button to create one!',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.blue[400],
          child: const Icon(Icons.person, size: 70, color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Text(
          'Ram_271',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Reliable and energetic worker seeking part-time shifts in retail or food service.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}