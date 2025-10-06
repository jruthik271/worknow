import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:worknow/applications.dart';
import 'package:worknow/home_screen.dart';
import 'package:worknow/job.dart';
import 'package:worknow/page_2.dart';
import 'package:worknow/profile.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int BTNindex = 0;
  List<Application> appliedJobs = [];
  List<JobCreated> createdJobs = [];
  String currentUserId = 'user123';

  void addApplication(Application application) {
    setState(() {
      appliedJobs.add(application);
      
      final createdJobIndex = createdJobs.indexWhere(
          (cj) => cj.job.id == application.job.id && cj.creatorId == currentUserId);

      if (createdJobIndex != -1) {
        createdJobs[createdJobIndex] =
            createdJobs[createdJobIndex].addApplication(application);
      }
    });
  }

  void _showCreateJobDialog() {
    
    final titleController = TextEditingController();
    final requirementController = TextEditingController();
    final locationController = TextEditingController();
    final amountController = TextEditingController();
    final timingsController = TextEditingController();
    final aboutController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Create New Job'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    
                    labelText: 'Job Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  
                  controller: requirementController,
                  decoration: const InputDecoration(
                    labelText: 'requirement',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: 'Salary/Amount',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: timingsController,
                  decoration: const InputDecoration(
                    labelText: 'Timings',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: aboutController,
                  decoration: const InputDecoration(
                    labelText: 'Job Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newJob = Job(
                  id: createdJobs.length + 100,
                  title: titleController.text,
                  requirement: requirementController.text,
                  location: locationController.text,
                  amount: amountController.text,
                  timings: timingsController.text,
                  about: aboutController.text,
                  creatorId: currentUserId,
                );
                
                setState(() {
                  createdJobs.add(JobCreated(
                    job: newJob,
                    creatorId: currentUserId,
                    createdDate: DateTime.now(),
                  ));
                });
                
                Navigator.pop(context);
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 60,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Job Created Successfully!",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                
                              ],
                            ),
                            actions: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      MainScreen(
        appliedJobs: appliedJobs,
        onApply: addApplication,
        createdJobs: createdJobs,
      ),
      Applicants(appliedJobs: appliedJobs),
      Workers(),
      WorkerProfileApp(
        createdJobs: createdJobs,
        currentUserId: currentUserId,
      )
    ];

    final iconList = <IconData>[
      Icons.work,
      Icons.assignment_turned_in_rounded,
      Icons.group_add_rounded,
      Icons.person,
    ];

    return Scaffold(
      body: pages[BTNindex],
      floatingActionButton: FloatingActionButton(
        
        onPressed: _showCreateJobDialog,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: pages.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.white : Colors.grey;
          final icon = iconList[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon, size: 30, color: color)],
          );
        },
        backgroundColor: Colors.blue.shade900,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: BTNindex,
        onTap: (index) => setState(() => BTNindex = index),
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}