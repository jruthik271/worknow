import 'dart:math';
import 'package:flutter/material.dart';

class Workers extends StatefulWidget {
  const Workers({super.key});

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  final List<Map<String, String>> profiles = [
    {
      "name": "Vamsi Boddu",
      "role": "Student",
      "age": "20",
      "location": "Rayavaram",
      "status": "available",
      "phone": "9876543210",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg0i5ClQLFDhg4UHZ0ZxbItAD4rSmeRmeriQ&s",
    },
    {
      "name": "Jaggu Relangi",
      "role": "Daily Wages Worker",
      "age": "22",
      "location": "Vizag",
      "status": "inwork",
      "phone": "9876543222",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg0i5ClQLFDhg4UHZ0ZxbItAD4rSmeRmeriQ&s",
    },
    {
      "name": "Suresh",
      "role": "Student",
      "age": "21",
      "location": "Pithapuram",
      "status": "available",
      "phone": "9876543333",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQg0i5ClQLFDhg4UHZ0ZxbItAD4rSmeRmeriQ&s",
    },
  ];

  int rating() {
    final random = Random();
    return random.nextInt(5) + 1;
  }

  void _showAddProfileForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController roleController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    String status = 'available';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Add New Worker'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter role' : null,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter age' : null,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter location' : null,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter phone number' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(
                        value: 'available', child: Text('Available')),
                    DropdownMenuItem(value: 'inwork', child: Text('In Work')),
                  ],
                  onChanged: (value) => status = value!,
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                      labelText: 'Image URL (optional)'),
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
                setState(() {
                  profiles.add({
                    "name": nameController.text,
                    "role": roleController.text,
                    "age": ageController.text,
                    "location": locationController.text,
                    "phone": phoneController.text,
                    "status": status,
                    "image": imageController.text.isNotEmpty
                        ? imageController.text
                        : "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("New profile added successfully!")),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "PROFILES",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.blue, size: 30),
            onPressed: () => _showAddProfileForm(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final ratingValue = rating();
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(profile["image"]!),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile["name"]!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(profile["role"]!,
                                style: TextStyle(color: Colors.grey[700])),
                            Row(
                              children: [
                                const Icon(Icons.phone,
                                    size: 16, color: Colors.teal),
                                const SizedBox(width: 4),
                                Text(profile["phone"] ?? ""),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 16, color: Colors.red),
                                const SizedBox(width: 4),
                                Text(profile["location"]!),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < ratingValue
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: profile["status"] == "available"
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            profile["status"]!,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Calling ${profile['phone']}..."),
                            ),
                          );
                        },
                        icon: const Icon(Icons.call, color: Colors.green),
                        label: const Text("Call"),
                      ),
                      const SizedBox(width: 15),
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Messaging ${profile['phone']}..."),
                            ),
                          );
                        },
                        icon: const Icon(Icons.message, color: Colors.blue),
                        label: const Text("Message"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
