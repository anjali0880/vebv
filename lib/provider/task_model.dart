// class Task {
//   final String taskName;
//   final String taskId;
//   final double? perStatus;
//   final String? userId;
//   final String? userName;
//   final List<Ticket> tickets;
//
//   Task({required this.taskName,required this.taskId, this.perStatus, required this.tickets, required this.userId,required this.userName});
//
//   factory Task.fromJson(Map<String, dynamic> json) {
//     var ticketsList = json['tickets'] as List;
//     List<Ticket> tickets = ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();
//     return Task(
//       taskName: json['taskName'],
//       taskId: json['_id'],
//       perStatus: json['perStatus'],
//       userId: json['userId'],
//       userName: json['userName'],
//       tickets: tickets,
//     );
//   }
// }
//
// class Ticket {
//   final String ticketName;
//   final double latitude;
//   final double longitude;
//   final String? status;
//
//   Ticket({
//     required this.ticketName,
//     required this.latitude,
//     required this.longitude,
//     this.status,
//   });
//
//   factory Ticket.fromJson(Map<String, dynamic> json) {
//     return Ticket(
//       ticketName: json['ticketName'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       status: json['status'],
//     );
//   }
// }

// class Task {
//   final String taskName;
//   final String taskId;
//   final double? perStatus;
//   final String? userId;
//   final String? userName;
//   final List<Ticket> tickets;
//
//   Task({
//     required this.taskName,
//     required this.taskId,
//     this.perStatus,
//     required this.userId,
//     required this.userName,
//     required this.tickets,
//   });
//
//   factory Task.fromJson(Map<String, dynamic> json) {
//     var ticketsList = json['tickets'] as List;
//     List<Ticket> tickets = ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();
//     return Task(
//       taskName: json['taskName'] ?? 'Default Task Name', // Provide default value if null
//       taskId: json['_id'] ?? 'Default ID', // Provide default value if null
//       perStatus: json['perStatus'],
//       userId: json['userId'],
//       userName: json['userName'],
//       tickets: tickets,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Task(taskName: $taskName, taskId: $taskId, perStatus: $perStatus, userId: $userId, userName: $userName, tickets: $tickets)';
//   }
// }
//
// class Ticket {
//   final String ticketName;
//   final double latitude;
//   final double longitude;
//   String? status;
//   final String createdAt;
//   final String updatedAt;
//
//   Ticket({
//     required this.ticketName,
//     required this.latitude,
//     required this.longitude,
//     this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Ticket.fromJson(Map<String, dynamic> json) {
//     return Ticket(
//       ticketName: json['ticketName'] ?? '', // Provide default value if null
//       latitude: json['latitude']?.toDouble() ?? 0.0, // Ensure latitude is not null
//       longitude: json['longitude']?.toDouble() ?? 0.0, // Ensure longitude is not null
//       status: json['status']??'', // Status can remain nullable
//       createdAt: json['createdAt'] ?? '', // Provide default date if null
//       updatedAt: json['updatedAt'] ?? '', // Provide default date if null
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Ticket(ticketName: $ticketName, latitude: $latitude, longitude: $longitude, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
//   }
// }

class Task {
  final String taskName;
  final String taskId;
  final double? perStatus;
  final String? userId;
  final String? userName;
  final List<Ticket> tickets;

  Task({
    required this.taskName,
    required this.taskId,
    this.perStatus,
    this.userId, // Nullable with default if necessary
    this.userName,
    required this.tickets,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    var ticketsList = json['tickets'] as List? ?? []; // Default to empty list if null
    List<Ticket> tickets = ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();

    return Task(
      taskName: json['taskName'] ?? 'Default Task Name',
      taskId: json['_id'] ?? 'Default ID',
      perStatus: json['perStatus'],
      userId: json['userId'], // Null-safe since userId is nullable
      userName: json['userName'],
      tickets: tickets,
    );
  }

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskId: $taskId, perStatus: $perStatus, userId: $userId, userName: $userName, tickets: $tickets)';
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
