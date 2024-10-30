class EmployeeTask {
  final String taskName;
  final String orgId;
  final String userName;
  final int perStatus;

  EmployeeTask({
    required this.taskName,
    required this.orgId,
    required this.userName,
    required this.perStatus,
  });

  // Add a factory constructor for JSON parsing if needed
  factory EmployeeTask.fromJson(Map<String, dynamic> json) {
    return EmployeeTask(
      taskName: json['taskName'] ?? 'N/A',
      orgId: json['orgId'] ?? 'N/A',
      userName: json['userName'] ?? 'N/A',
      perStatus: json['perStatus'] ?? 0,
    );
  }
}
