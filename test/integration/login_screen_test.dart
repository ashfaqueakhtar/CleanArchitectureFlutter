import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/config/network/status.dart';
import 'package:getx_clean_arch/domain/usecase/login/login_controller.dart';
import 'package:getx_clean_arch/presentation/customWidget/input_field.dart';
import 'package:getx_clean_arch/presentation/pages/login/login_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginController extends GetxController with Mock implements LoginController {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginController mockLoginController;

  setUp(() {
    mockLoginController = MockLoginController();
    Get.put<LoginController>(mockLoginController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Login screen renders correctly and handles input and submit', (WidgetTester tester) async {

    // Start the app with LoginScreen
    await tester.pumpWidget(const GetMaterialApp(
      home: LoginScreen(),
    ));
    await tester.pumpAndSettle();

    // Verify the login screen is displayed
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(InputField), findsNWidgets(2)); // Two input fields

    // Enter username and password
    await tester.enterText(find.byType(InputField).first, 'test_user');
    await tester.enterText(find.byType(InputField).last, 'test_pass');

    // Trigger the button press
    mockLoginController.onSubmit();

    await tester.tap(find.text('Submit'));
    await tester.pump(); // Start the loading animation
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that the loading state is shown
    expect(mockLoginController.getStatus, STATUS.LOADING);

    // Verify that the success state has been reached after submit
    expect(mockLoginController.getStatus, STATUS.SUCCESS);

    // Clean up the mock
   // verify(mockLoginController.onSubmit()).called(1);

  });


}
