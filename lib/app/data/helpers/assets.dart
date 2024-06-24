import 'package:green_campus_app/app/data/models/facility_model.dart';

const img_carousel_1 = "assets/images/carousel_1.png";
const img_carousel_2 = "assets/images/carousel_2.png";
const img_carousel_3 = "assets/images/carousel_3.png";
const img_carousel_4 = "assets/images/carousel_4.png";
const img_carousel_5 = "assets/images/carousel_5.png";
const img_carousel_6 = "assets/images/carousel_6.png";

const img_bg_pattern = "assets/images/bg_pattern.png";
const img_challenge_bike = "assets/images/challenge_bike.png";
const img_challenge_recycle = "assets/images/challenge_recycle.png";
const img_challenge_drink = "assets/images/challenge_drink.png";
const img_green_challenge = "assets/images/greenChallenge.png";

const img_placeholder = "assets/images/placeholder.png";
const img_logo = "assets/images/logo.png";
const img_langId = "assets/images/lang_id.png";
const img_langUK = "assets/images/lang_uk.png";

const img_map_bike = "assets/images/map_bike.png";
const img_map_compost = "assets/images/map_compost.png";
const img_map_drink = "assets/images/map_drink.png";
const img_map_eco = "assets/images/map_eco.png";
const img_map_park = "assets/images/map_park.png";
const img_map_recycle = "assets/images/map_recycle.png";
const img_map_trash = "assets/images/map_trash.png";

const svg_auth_bg = "assets/svg/auth_bg.svg";
const svg_bg_pattern = "assets/svg/bg_pattern.svg";
const svg_logo = "assets/svg/logo.svg";
const svg_logo_text = "assets/svg/logo_text.svg";
const svg_gp = "assets/svg/GP.svg";
const svg_logo_google = "assets/svg/logo_google.svg";
const svg_verification = "assets/svg/email.svg";
const svg_confirmation = "assets/svg/confirmation.svg";
const svg_instruction = "assets/svg/instruction.svg";

const svg_ic_home = "assets/svg/Home.svg";
const svg_ic_home_a = "assets/svg/Home Active.svg";
const svg_ic_challenge = "assets/svg/Challenge.svg";
const svg_ic_challenge_a = "assets/svg/Challenge Active.svg";
const svg_ic_map = "assets/svg/Sustainability Map.svg";
const svg_ic_map_a = "assets/svg/Sustainability Map Active.svg";
const svg_ic_bike = "assets/svg/Bike Rent.svg";
const svg_ic_bike_a = "assets/svg/Bike Rent Active.svg";
const svg_ic_profile = "assets/svg/Profile.svg";
const svg_ic_profile_a = "assets/svg/Profile Active.svg";

String getMapIcon(String value) {
  switch (value) {
    case FacilityType.drinkingFountain:
      return img_map_drink;
    case FacilityType.recycleCenter:
      return img_map_recycle;
    case FacilityType.compostingFacility:
      return img_map_compost;
    case FacilityType.bikeStation:
      return img_map_bike;
    case FacilityType.greenPark:
      return img_map_park;
    case FacilityType.wasteProcessingSite:
      return img_map_trash;
    default:
      return img_map_eco;
  }
}
