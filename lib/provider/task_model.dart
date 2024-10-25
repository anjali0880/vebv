class Task {
  final String taskName;
  final String taskId;
  final double? perStatus;
  final String? userId;
  final String? userName;
  final List<Ticket> tickets;

  Task({required this.taskName,required this.taskId, this.perStatus, required this.tickets, required this.userId,required this.userName});

  factory Task.fromJson(Map<String, dynamic> json) {
    var ticketsList = json['tickets'] as List;
    List<Ticket> tickets = ticketsList.map((ticket) => Ticket.fromJson(ticket)).toList();
    return Task(
      taskName: json['taskName'],
      taskId: json['_id'],
      perStatus: json['perStatus'],
      userId: json['userId'],
      userName: json['userName'],
      tickets: tickets,
    );
  }
}

class Ticket {
  final String ticketName;
  final double latitude;
  final double longitude;
  final String? status;

  Ticket({
    required this.ticketName,
    required this.latitude,
    required this.longitude,
    this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketName: json['ticketName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
    );
  }
}
