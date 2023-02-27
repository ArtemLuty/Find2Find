import 'package:find_me/app/locator.dart';
import 'package:find_me/app/logger.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/data/services/registration_service.dart';
import 'package:find_me/domain/models/registration_model.dart';
import 'package:find_me/domain/responses/school_response.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/registration_student/conponents/content_widgets.dart';
import 'package:find_me/ui/registration_student/conponents/school_content.dart';
import 'package:find_me/ui/utils/regexp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class RegStudentController extends GetxController {
  Preferences preferences = locator<Preferences>();
  RegistrationService _regService = locator<RegistrationService>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var logger = getLogger("Registration Controller");

  GlobalKey<FormState> formKeyFirstName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLastName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPostcode = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySchool = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyVerifyPhone = GlobalKey<FormState>();

  double progressPercent = 0.1;

  TextEditingController nameFirstSController = TextEditingController();
  TextEditingController nameLastSController = TextEditingController();
  TextEditingController dateSController = TextEditingController();
  TextEditingController postCodeSController = TextEditingController();
  TextEditingController schoolSController = TextEditingController();
  TextEditingController phoneSController = TextEditingController();
  TextEditingController verifyPhoneSController = TextEditingController();
  TextEditingController emailSController = TextEditingController();

  int? indexContent;
  String? image;
  String? title;
  String? keyboardValue = '';
  double? stepValue;
  ScreenRegStudentType? backRoute;
  late Widget content;

  List<SchoolResponse> _schools = [];
  List<String>? keyboardValues = [];

  List<SchoolResponse> get schools => _schools;

  set schools(List<SchoolResponse> schools) {
    _schools = schools;
    update();
  }

  SchoolResponse? _selectedSchool;

  SchoolResponse? get selectedSchool => _selectedSchool;

  set selectedSchool(SchoolResponse? selectedSchool) {
    _selectedSchool = selectedSchool;
    update();
  }

  RegistrationModel _regModel = RegistrationModel();

  RegistrationModel get regModel => _regModel;

  set regModel(RegistrationModel studentRegModel) {
    _regModel = studentRegModel;
    update();
  }

  bool isFirstNameValid() {
    return nameFirstSController.text.trim().isNotEmpty &&
        nameFirstSController.text.trim().length > 1;
  }

  bool isLastNameValid() {
    return nameLastSController.text.trim().isNotEmpty &&
        nameLastSController.text.trim().length > 1;
  }

  bool isSchoolValid() {
    return schoolSController.text.trim().isNotEmpty;
  }

  bool isEmailValid() {
    if (emailSController.text.trim().isNotEmpty) {
      return emailRegexp.hasMatch(emailSController.text.trim());
    }
    return true;
  }

  bool isPhoneValid() {
    return phoneSController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(phoneSController.text.trim()) &&
        phoneSController.text.trim().length > 9 &&
        phoneSController.text.trim().length < 15;
  }

  bool isVerifyPhoneValid() {
    return verifyPhoneSController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(verifyPhoneSController.text.trim()) &&
        verifyPhoneSController.text.length == 4;
  }

  bool isPostCodeValid() {
    return postCodeSController.text.trim().isNotEmpty &&
        numberRegexp.hasMatch(postCodeSController.text.trim()) &&
        postCodeSController.text.trim().length == 5;
  }

  bool isValid() {
    return isLastNameValid() &&
        isFirstNameValid() &&
        isPostCodeValid() &&
        isPhoneValid() &&
        isEmailValid() &&
        isSchoolValid();
  }

  List<String> testListSchool = [
    'Berlin British School',
    'Berlin Cosmopolitan School',
    'Berlin International School',
    'Berlin Metropolitan School',
    'Canisius-Kolleg Berlin',
    'Emanuel-Lasker-Oberschule',
    'Ernst-Abbe-Gymnasium',
    'Evangelisches Gymnasium zum...'
  ];

  @override
  void onInit() {
    changePage(ScreenRegStudentType.firstName);
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOs = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    super.onInit();
  }

  Future onSelectNotification(String? payload) async {}

  void changePage(ScreenRegStudentType type) {
    switch (type) {
      case ScreenRegStudentType.firstName:
        backRoute = ScreenRegStudentType.firstName;
        indexContent = 0;
        image = icRegHeader1;
        title = 'What’s your first name?';
        content = buildFirstNameSContent();
        update();
        break;
      case ScreenRegStudentType.lastName:
        backRoute = ScreenRegStudentType.firstName;
        indexContent = 1;
        image = icRegHeader2;
        title = 'What’s your last name?';
        content = buildLastNameSContent();
        update();
        break;
      case ScreenRegStudentType.dateOfBirth:
        backRoute = ScreenRegStudentType.lastName;
        indexContent = 2;
        image = icRegHeader1;
        title = 'What’s your date of birth?';
        content = buildDateSContent();
        update();
        break;
      case ScreenRegStudentType.postCode:
        backRoute = ScreenRegStudentType.dateOfBirth;
        indexContent = 3;
        image = icRegHeader3;
        title = 'What’s your postcode?';
        content = buildPostCodeSContent();
        update();
        break;
      case ScreenRegStudentType.school:
        backRoute = ScreenRegStudentType.postCode;
        indexContent = 4;
        image = icRegHeader4;
        title = 'What school do you go to?';
        content = buildSchoolContent();
        update();
        break;
      case ScreenRegStudentType.phoneNumber:
        backRoute = ScreenRegStudentType.school;
        indexContent = 5;
        image = icRegHeader1;
        title = 'What’s your phone number?';
        content = buildPhoneNumberSContent();
        update();
        break;
      case ScreenRegStudentType.verifyPhone:
        backRoute = ScreenRegStudentType.phoneNumber;
        indexContent = 6;
        image = icRegHeader1;
        title = 'Verify your phone number';
        content = buildVerifyPhoneSContent();
        update();
        break;
      case ScreenRegStudentType.email:
        backRoute = ScreenRegStudentType.verifyPhone;
        indexContent = 7;
        image = icRegHeader3;
        title = 'What’s your email address?';
        content = buildEmailSContent();
        update();
        break;
    }
  }

  Future<bool> sendOtpSms() async {
    bool result = false;
    try {
      result = await _regService.sendOtpSms(phoneSController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<bool> checkOtpSms() async {
    bool result = false;
    try {
      result = await _regService.checkOtpSms(
          phoneSController.text.trim(), verifyPhoneSController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<List<SchoolResponse>> getSchoolsByPostcode() async {
    List<SchoolResponse> result = [];
    try {
      result = await _regService
          .getSchoolsByPostcode(postCodeSController.text.trim());
    } catch (err) {
      print(err.toString());
    }
    return result;
  }

  Future<void> registerStudent() async {
    try {
      if (isValid()) {
        setStudentRegModelData();
        var result = await _regService.register(regModel, "student");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void setStudentRegModelData() {
    regModel.email = emailSController.text.trim();
    regModel.firstName = nameFirstSController.text.trim();
    regModel.lastName = nameLastSController.text.trim();
    regModel.password = verifyPhoneSController.text.trim();
    regModel.schoolId = selectedSchool?.id;
    regModel.username = phoneSController.text.trim().replaceAll(" ", "");
    regModel.dob = dateSController.text.trim().replaceAll("/", "-");
  }

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  onKeyboardTap(String v) {
    keyboardValue = keyboardValue! + v;
    final updated = ((progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    progressPercent = updated.round() / 100;
    v.isNotEmpty ? changePage(ScreenRegStudentType.email) : null;
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
