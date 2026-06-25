class RegisterCustomerRequest {
  final String username;
  final String password;

  RegisterCustomerRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class RegisterRestaurantRequest {
  final String username;
  final String password;
  final String name;

  RegisterRestaurantRequest({
    required this.username,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'name': name,
  };
}

class RegisterRestaurantDetailRequest {
  final String username;
  final String password;
  final String name;
  final String workTime;
  final List<int> typeIdList;

  RegisterRestaurantDetailRequest({
    required this.username,
    required this.password,
    required this.name,
    required this.workTime,
    required this.typeIdList,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'name': name,
    'workTime': workTime,
    'typeIdList': typeIdList,
  };
}