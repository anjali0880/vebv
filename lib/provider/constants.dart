class AdminApiConstants {
  static const String baseUrl =
      'http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9003';
  static const String getAllTasksEndpoint = '$baseUrl/field/getAllTasks';
  static const String createEmployeeAccount = '$baseUrl/account/add';
  static const String deleteTicket = '$baseUrl/field/deleteTicket';
  static const String deleteTask = '$baseUrl/field/deletetask';
  static const String assignTask = '$baseUrl/field/assigntask';
  static const String updateTask = '$baseUrl/field/updateTask';
  static const String latestUpdate =
      'http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9004/liveTrack/updates/latestTask';
}

class AuthApiConstants {
  static const String adminLogin = 'https://v1.dhundhoo.com/auth/signin';
  static const String employeeAuth = 'https://v1.dhundhoo.com/v2/account/my';
  static const String adminAuthorization =
      'https://v1.dhundhoo.com/auth/authorize';
  static const String adminInfo =
      'http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9004/account/my';
}

class EmployeeApiConstant {
  static const String baseUrl =
      'http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9003';
  static const String getAllEmployeeTasks = '$baseUrl/field/gettask/8208452243';
  static const String taskCompletion = '$baseUrl/field/executeticket';
  static const String liveDataUpdate =
      'https://v2.dhundhoo.com/mobile/live/save';
}
