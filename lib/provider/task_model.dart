

class Task {
  final String taskName;
  final String taskId;
  final double? perStatus;
  final String? userId;
  final String? userName;
  final String? createdAt;
  final List<Ticket> tickets;

  Task({
    required this.taskName,
    required this.taskId,
    this.perStatus,
    this.userId,
    this.userName,
    this.createdAt,
    required this.tickets,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    var ticketsList = json['tickets'] as List? ?? [];
    List<Ticket> tickets = ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();

    return Task(
      taskName: json['taskName'] ?? 'Default Task Name',
      taskId: json['_id'] ?? 'Default ID',
      perStatus: json['perStatus'],
      userId: json['userId'], // Null-safe since userId is nullable
      userName: json['userName'],
      createdAt: json['createdAt'],
      tickets: tickets,
    );
  }

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskId: $taskId, perStatus: $perStatus, userId: $userId, userName: $userName, createdAt: $createdAt, tickets: $tickets)';
  }
}

class Ticket {
  final String ticketName;
  final double latitude;
  final double longitude;
  String? status;
  // final String createdAt;
  // final String updatedAt;

  Ticket({
    required this.ticketName,
    required this.latitude,
    required this.longitude,
    this.status,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketName: json['ticketName'] ?? 'Unnamed Ticket',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      status: json['status'] ?? '', // Default status if null
      // createdAt: json['createdAt'] ?? 'Not Available', // Default date if null
      // updatedAt: json['updatedAt'] ?? 'Not Available',
    );
  }

  @override
  String toString() {
    return 'Ticket(ticketName: $ticketName, latitude: $latitude, longitude: $longitude, status: $status)';
  }
}
