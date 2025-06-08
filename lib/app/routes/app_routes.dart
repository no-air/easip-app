class Routes {
  static const splash = '/splash';
  static const home = '/home';
  static const onboarding = '/onboarding';
  static const signin = '/sign-in';
  static const survey = '/survey';
  static const map = '/house-map';

  static const surveyLivingArea = '$survey/living-area';
  static const surveyIncome = '$survey/income';
  static const surveyHousehold = '$survey/household';
  static const surveyAssets = '$survey/assets';
  static const surveyInterestAreas = '$survey/interest-areas';
  static const surveyMarriageStatus = '$survey/marriage-status';
  static const surveyCarOwnership = '$survey/car-ownership';
  static const surveyTotalAsset = '$survey/total-asset';
  static const surveyCarAsset = '$survey/car-asset';
  static const surveyCompletion = '$survey/completion';
  static const post = '/post/:postId';
  static const my = '/my';
  static const alarmRegistered = '/alarm-registered';
  static const house = '/house/:houseId';
}

class AppRoutes {
  static const initial = Routes.splash;
  static const home = Routes.home;
}
