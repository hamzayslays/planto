class AppUrl{

  static var baseUrl = 'https://eb-project-backend-kappa.vercel.app';

  static var moviesBaseUrl = 'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static var loginEndPoint = baseUrl + '/api/v0/user/loginUser';

  static var registerEndPointUrl  = baseUrl + '/api/v0/user/createUser';

  static var forgotPasswordEndPointUrl  = baseUrl + '/api/v0/user/forgotPassword';

  static var verifyOtpEndPointUrl  = baseUrl + '/api/v0/user/verifyOtp';

  static var changePasswordEndPointUrl  = baseUrl + '/api/v0/user/resetPassword';

  static var addToCartEndPointUrl  = "$baseUrl/api/v0/plants/addToCart";

  static var getCartEndPointUrl = baseUrl + '/api/v0/plants/getCart';

  static var  deleteCartEndPointUrl = baseUrl + '/api/v0/plants/removeFromCart/{userId}/{plantId}';


}