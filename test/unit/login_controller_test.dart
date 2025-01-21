import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/data/model/remote/auth/login_response.dart';
import 'package:getx_clean_arch/domain/repo/auth_repo.dart';
import 'package:getx_clean_arch/domain/usecase/login/login_controller.dart';
import 'package:mocktail/mocktail.dart';

// class MockSomeClassConstructor implements SomeClassConstructor{
// get override methods here
// }

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late LoginController sut; //sut >> System under test
  late MockAuthRepo mockAuthRepo;

  // Initial setUp
  setUp(() {
    // Initialize the mock object
    mockAuthRepo = MockAuthRepo();
    // Inject the mock object into the GetX dependency system
    Get.put<AuthRepo>(mockAuthRepo);

    // Initialize the LoginController
    sut = LoginController();

    /*Suppose LoginController had a dependency like LoginController(SomeClassConstructor())
    * And SomeClassConstructor had some function that changes dynamically,
    * Direct access to SomeClassConstructor() will create flakiness(lack of reliability) due to dynamic changes of input data
    * So what to do in this case? Answer is create mock class
    * example in Comments above
    * Best alternate way is Mocktail that we are using for AuthRepo as MockAuthRepo
    * */
  });

  tearDown(() {
    // Reset GetX after each test
    Get.reset();
  });


  group("LoginController : onSubmit", (){

    test("onSubmit set usernameError when username is empty ", () {
      sut.getLoginData.setUsername("");
      sut.getLoginData.setPassword("password");

      // call the method
      sut.onSubmit();

      expect(sut.getUserNameError, "Username is Empty");
    });

    test("onSubmit set passwordError when password is empty ", () {
      sut.getLoginData.setUsername("username");
      sut.getLoginData.setPassword("");

      // do the action
      sut.onSubmit();

      // write expected result comparison
      expect(sut.getPasswordError, 'Password is Empty');
    });

    test('onSubmit calls _callLoginApi when both fields are filled', () {
      sut.getLoginData.setUsername("username");
      sut.getLoginData.setPassword("password");

      //fake Call of API with successful response LoginResponse
      //This is needed as we are mocking it
      when(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData'))).thenAnswer((_) async {
        return LoginResponse(token: "token");
      });

      // do the action
      sut.onSubmit();

      // Assert =>
      //verify => that checks if a specific method call happened on the mock object.
      //.called(1); -> 1 denotes that it should be called once
      verify(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData'))).called(1);
      expect(sut.getStatus, STATUS.LOADING);
    });

    test('onSubmit called and status sets to SUCCESS when login is successful', () async {
      sut.getLoginData.setUsername("username");
      sut.getLoginData.setPassword("password");

      //fake Call of API with successful response of LoginResponse
      //This is needed as we are mocking it
      when(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData'))).thenAnswer((_) async {
        return LoginResponse(token: "token");
      });

      // do the action
      sut.onSubmit();
      ///It is needed to check asynchronous call is happening or not
      ///as we are using await so we are using until called
      await untilCalled(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData')));

      // Assert
      expect(sut.getStatus, STATUS.SUCCESS);
    });

    test('onSubmit sets status to ERROR when login fails', () async {
      // Arrange
      sut.getLoginData.setUsername("username");
      sut.getLoginData.setPassword("password");

      when(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData')))
          .thenThrow(Exception('Fake Login failed'));

      // Act
      sut.onSubmit();
      await untilCalled(() => mockAuthRepo.postLogin(requestData: any(named: 'requestData')));

      // Assert
      expect(sut.getStatus, STATUS.ERROR);
    });
  });

  ///comment navigation to acheive test cases
}
