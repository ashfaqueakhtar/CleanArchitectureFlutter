import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/routes/routes.dart';
import 'package:getx_clean_arch/domain/repo/auth_repo.dart';
import 'package:getx_clean_arch/domain/usecase/splash/splash_controller.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main(){
  late SplashController sut; //sut >> System under test
  late MockAuthRepo mockAuthRepo;

  setUp((){
    Get.testMode = true;
    mockAuthRepo = MockAuthRepo();
    Get.put<AuthRepo>(mockAuthRepo);

    sut = SplashController();
  });

  tearDown((){
    Get.reset();
  });

  test("_setTimerNavigation navigates to login when token is empty", () async {
    //mock the api scenario // WHere token is empty
    //Environment condition for api
    when(() => mockAuthRepo.getToken()).thenAnswer((_) async => '');

    //Action
    sut.onInit();

    // Wait for the timer to complete
    await Future.delayed(const Duration(seconds: 3));

    //// Assert
    verify(() => mockAuthRepo.getToken()).called(1);
    expect(Get.currentRoute, Routes.kLogin);
  });
}