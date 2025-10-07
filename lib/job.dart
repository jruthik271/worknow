
class Job {
  final int id;
  final String title;
  final String requirement;
  final String location;
  final String amount;
  final String timings;
  final String about;
  final String? creatorId;

  const Job({
    required this.id,
    required this.title,
    required this.requirement,
    required this.location,
    required this.amount,
    required this.timings,
    required this.about,
    this.creatorId,
  });
}

class Application {
  final Job job;
  final String name;
  final String email;
  final String phone;
  final String experience;
  final DateTime appliedDate;

  const Application({
    required this.job,
    required this.name,
    required this.email,
    required this.phone,
    required this.experience,
    required this.appliedDate,
  });
}

class JobCreated {
  final Job job;
  final String creatorId;
  final DateTime createdDate;
  final List<Application> receivedApplications;

  JobCreated({
    required this.job,
    required this.creatorId,
    required this.createdDate,
    this.receivedApplications = const [],
  });

  JobCreated addApplication(Application application) {
    return JobCreated(
      job: job,
      creatorId: creatorId,
      createdDate: createdDate,
      receivedApplications: List.from(receivedApplications)..add(application),
    );
  }
}