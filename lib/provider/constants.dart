class ApiConstants {
  static const String baseUrl = 'http://ec2-3-6-16-102.ap-south-1.compute.amazonaws.com:9003';
  static const String getAllTasksEndpoint = '$baseUrl/field/getAllTasks';
  static const String createEmployeeAccount= '$baseUrl/account/add';
  static const String deleteTicket= '$baseUrl/field/deleteTicket';
  static const String deleteTask= '$baseUrl/field/deletetask';

}
class
AuthApiConstants
{
  static const String adminLogin= 'https://v1.dhundhoo.com/auth/signin';
  static const String adminAuthorization= 'https://v1.dhundhoo.com/auth/authorize';
}