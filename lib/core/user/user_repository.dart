class UserRepository {
  static final UserRepository _userRepository = UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();
}