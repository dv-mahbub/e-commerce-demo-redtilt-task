class ApiEndpoints {
  static String baseUrl = 'https://apptest.dokandemo.com/wp-json';

  static String registration = '$baseUrl/wp/v2/users/register'; //POST
  static String login = '$baseUrl/jwt-auth/v1/token'; // POST
  static String getUserData = '$baseUrl/wp/v2/users/me'; //GET
  static String updateProfile =
      '$baseUrl/wp/v2/users'; //GET //userId needed at the end
}
