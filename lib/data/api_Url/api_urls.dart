class ApiUrl {
  //local url
  // static const baseUrl = "http://192.168.1.44:8000/";
  // live url
  static const baseUrl = "http://54.204.229.131/";
  static const registerApi = "${baseUrl}api/signup";
  static const loginApi = "${baseUrl}api/login";
  static const socialLoginApi = "${baseUrl}api/social-login";

  static const privacyPolicy = "${baseUrl}api/privacy-policy";
  static const termsAndConditions = "${baseUrl}api/terms-conditions";
  static const aboutUs = "${baseUrl}api/about-us";
  static const changePassword = "${baseUrl}api/change-password";
  static const forgetPassword = "${baseUrl}api/forgot-password";
  static const updateProfile = "${baseUrl}api/update-profile";

  // * HOME
  static const homeCategory = "${baseUrl}api/categories";
  static const hoByEventsbyCategory = "${baseUrl}api/events";
  static const contact_Us = "${baseUrl}api/contact-us";
  static const deleteAccount = "${baseUrl}api/delete-account";
  static const favEvent = "${baseUrl}api/favorite";
  static const removeFavEvent = "${baseUrl}api/favorite";
  static const payAtCheckOutScreen = "${baseUrl}api/make-payment";
  static const reservationBooking = "${baseUrl}api/reservation";
  // * CARDS
  static const addCard = "${baseUrl}api/save-card";
  static const deleteCard = "${baseUrl}api/delete-card";
  static const listCard = "${baseUrl}api/get-saved-cards";
  // * Tickets
  static const listTickets = "${baseUrl}api/tickets";
  static const ticketUpdate = "${baseUrl}api/tickets-update";
  // * Favourite
  static const listFavourite = "${baseUrl}api/favorite";
}
