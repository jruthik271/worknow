import 'package:flutter/material.dart';
import 'package:worknow/job.dart';
import 'package:worknow/job_detail.dart';

class MainScreen extends StatefulWidget {
  final List<Application> appliedJobs;
  final Function(Application) onApply;
  final List<JobCreated> createdJobs;

  const MainScreen({
    super.key,
    required this.appliedJobs,
    required this.onApply,
    required this.createdJobs,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedLocation = "All Locations";

  final List<String> locations = [
    "All Locations",
    "Kakinada",
    "Rajahmundry",
    "Amalapuram",
    "Surampalem",
    "Hyderabad"
  ];

  final List<Job> predefinedJobs = [
    Job(
      id: 1,
      title: "Catering",
      company: "No of  members : 5",
      location: "peddapuram",
      amount: "₹400",
      timings: "8:00 AM - 12:00 PM",
      about: "planning, preparing, delivering, and serving food and beverages for special events and clients at various locations. ",
    ),
    Job(
      id: 2,
      title: "House shifting",
      company: "No of  members : 2",
      location: "Kakinada",
      amount: "₹600",
      timings: "10:00 AM - 7:00 PM",
      about: "Shifting the home appliances and things to the new house.",
    ),
    Job(
      id: 3,
      title: "Tuition for 10th student",
      company: "No of p members : 1",
      location: "Rajahmundry",
      amount: "₹2000/month",
      timings: "5:00 AM - 8:30 PM",
      about: "To teach and boubts clarification for 10th class student.",
    ),
    Job(
      id: 4,
      title: "Server for restaurant",
      company: " No of members : 2",
      location: "pithapuram",
      amount: "₹3000/month",
      timings: "5:00 PM - 11:00 PM",
      about: "Take orders and Serve to customers.",
    ),
    Job(
      id: 5,
      title: "Catering",
      company: "No of  members : 6",
      location: "Surampalem",
      amount: "₹700",
      timings: "9:00 AM - 6:00 PM",
      about: "planning, preparing, delivering, and serving food and beverages for special events and clients at various locations.",
    ),
    Job(
      id: 6,
      title: "Helper for fancy store",
      company: "No of members : 1",
      location: "peddapuram",
      amount: "₹4000/month",
      timings: "9:30 AM - 6:30 PM",
      about: "Offering dedicated help to manage and grow your fancy store smoothly and efficiently.",
    ),
    Job(
      id: 7,
      title: "Catering",
      company: "No of persond : 6",
      location: "Kakinada",
      amount: "₹700",
      timings: "9:00 AM - 6:00 PM",
      about: "planning, preparing, delivering, and serving food and beverages for special events and clients at various locations.",
    ),
    Job(
      id: 8,
      title: "Content Writer",
      company: "No of persond : 1",
      location: "Rajahmundry",
      amount: "₹1200",
      timings: "10:00 AM - 7:00 PM",
      about: "Create engaging content for websites and blogs.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Combine predefined and created jobs
    final allJobs = [...predefinedJobs, ...widget.createdJobs.map((cj) => cj.job)];

    // Filter jobs by selected location
    final filteredJobs = selectedLocation == "All Locations"
        ? allJobs
        : allJobs.where((job) => job.location == selectedLocation).toList();

    // Check if a job is applied
    bool isJobApplied(Job job) {
      return widget.appliedJobs.any((app) => app.job.id == job.id);
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and location dropdown
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "WORKNOW",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedLocation,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.location_on, color: Colors.blue),
                      items: locations
                          .map((location) => DropdownMenuItem(
                                value: location,
                                child: Text(location),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Jobs count text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${filteredJobs.length} jobs found",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Job list or empty state
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: filteredJobs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.work_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No jobs found in $selectedLocation",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Try selecting a different location",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = filteredJobs[index];
                          final applied = isJobApplied(job);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailsPage(
                                    job: job,
                                    onApply: widget.onApply,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.work,
                                          color: Colors.blue,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              job.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              job.company,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (applied)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            "Applied",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      else
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[400],
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    job.about,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "Full-time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          job.location,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.orange[700],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        job.amount,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}