
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/viewModel/homeViewModel.dart';
import 'package:voice_changer/viewModel/services/StripeApiService.dart';
import 'package:voice_changer/viewModel/userViewModel.dart';

// +++++++++++++++++++++++++++++++++++
// ++ STRIPE PAYMENT INITIALIZATION ++
// +++++++++++++++++++++++++++++++++++

Future<void> init(var price,var priceTempId,var customerName,var customerEmail,subscriptionTypeId,context) async {

  Map<String, dynamic> customer = await createCustomer(customerName, customerEmail);
  Map<String, dynamic> paymentIntent = await createPaymentIntent(
    customer['id'],
  );
  await createCreditCard(customer['id'], paymentIntent['client_secret'],price);
  Map<String, dynamic> customerPaymentMethods =
      await getCustomerPaymentMethods(customer['id']);
  // print("pppppppppppp: ${priceTempId}");

 

 var subscriptionsResponse= await createSubscription(
    customer['id'],
    customerPaymentMethods['data'][0]['id'],
    priceTempId
  );
  // print("sub: ${subscriptionsResponse}");
//  SharedPreferences sp=await SharedPreferences.getInstance();
 var subscriptionId=subscriptionsResponse["id"].toString();
 var customerId=subscriptionsResponse["customer"].toString();
 var priceId=subscriptionsResponse['items']['data'][0]['plan']['id'].toString();
 var sDate=subscriptionsResponse["current_period_end"];
 var eDate=subscriptionsResponse["current_period_end"];
 var amount=subscriptionsResponse["items"]["data"][0]["plan"]["amount"];
  var provider=Provider.of<UserViewModel>(context,listen: false);
  //  DateTime now = DateTime.now();
  // String formattedDateTimeNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
// Current date and time
  // DateTime currentDate = DateTime.now();
  // // Calculate 3 months later
  // DateTime endDate = currentDate.add(Duration(days: 90));


// Convert timestamps to DateTime objects
DateTime startDate = DateTime.fromMillisecondsSinceEpoch(sDate * 1000);
DateTime endDate = DateTime.fromMillisecondsSinceEpoch(eDate * 1000);

// Format DateTime objects as strings
String formattedStartDate = startDate.toIso8601String();
String formattedEndDate = endDate.toIso8601String();

// print("formattedEndDate: ${formattedEndDate}");
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${provider.logintoken}',
};

var data = {
  "userId": provider.userId,
  "subscriptionType": subscriptionTypeId,
  "subscriptionStripeId": subscriptionId,
  "customerId": customerId,
  "price": amount,
  "startDate": formattedStartDate,
  "endDate": formattedEndDate,
};

HomeViewModel().createSubscritonAPI(data, headers, context);
}

// +++++++++++++++++++++
// ++ CREATE CUSTOMER ++
// +++++++++++++++++++++

Future<Map<String, dynamic>> createCustomer(customerName,customerEmail) async {

  final customerCreationResponse = await apiService(
    endpoint: 'customers',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'name': customerName,
      'email': customerEmail,
      'description': 'AI Voice Changer',
    },
  );

  return customerCreationResponse!;
}

// ++++++++++++++++++++++++++
// ++ SETUP PAYMENT INTENT ++
// ++++++++++++++++++++++++++

Future<Map<String, dynamic>> createPaymentIntent(String customerId) async {
  final paymentIntentCreationResponse = await apiService(
    requestMethod: ApiServiceMethodType.post,
    endpoint: 'setup_intents',
    requestBody: {
      'customer': customerId,
      'automatic_payment_methods[enabled]': 'true',
    },
  );

  return paymentIntentCreationResponse!;
}

// ++++++++++++++++++++++++
// ++ CREATE CREDIT CARD ++
// ++++++++++++++++++++++++

Future<void> createCreditCard(
  String customerId,
  String paymentIntentClientSecret,
  String price,
) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      primaryButtonLabel: 'Subscribe $price',
      style: ThemeMode.light,
      merchantDisplayName: 'UZR Ai Voice',
      customerId: customerId,
      setupIntentClientSecret: paymentIntentClientSecret,
    ),
  );

  await Stripe.instance.presentPaymentSheet();
}

// +++++++++++++++++++++++++++++++++
// ++ GET CUSTOMER PAYMENT METHOD ++
// +++++++++++++++++++++++++++++++++

Future<Map<String, dynamic>> getCustomerPaymentMethods(
  String customerId,
) async {
  final customerPaymentMethodsResponse = await apiService(
    endpoint: 'customers/$customerId/payment_methods',
    requestMethod: ApiServiceMethodType.get,
  );

  return customerPaymentMethodsResponse!;
}

// +++++++++++++++++++++++++
// ++ CREATE SUBSCRIPTION ++
// +++++++++++++++++++++++++

Future<Map<String, dynamic>> createSubscription(
  String customerId,
  String paymentId,
  String priceTemplateId,
) async {
  final subscriptionCreationResponse = await apiService(
    endpoint: 'subscriptions',
    requestMethod: ApiServiceMethodType.post,
    requestBody: {
      'customer': customerId,
      'items[0][price]': priceTemplateId,
      'default_payment_method': paymentId,
    },
  );
  return subscriptionCreationResponse!;
}

// ++++++++++++++++++++++++++++++
// ++ UPGRADE SUBSCRIPTION ++
// ++++++++++++++++++++++++++++++

Future<void> upgradeSubscription(
  String customerId,
  String currentSubscriptionId,
  String newPriceTemplateId,
) async {
  // First, cancel the current subscription
  await cancelSubscription(currentSubscriptionId, "id", "context");

  // Create a new payment intent and credit card
  Map<String, dynamic> paymentIntent = await createPaymentIntent(customerId);
  await createCreditCard(customerId, paymentIntent['client_secret'], newPriceTemplateId);

  // Get the new payment method
  Map<String, dynamic> customerPaymentMethods =
      await getCustomerPaymentMethods(customerId);

  // Create the new subscription with the updated price
 var upgradeResponse= await createSubscription(
    customerId,
    customerPaymentMethods['data'][0]['id'],
    newPriceTemplateId,
  );
  print("Upgrade Response: ${upgradeResponse}");
   SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString("subscriptionId", upgradeResponse["id"].toString());
  sp.setString("customerId", upgradeResponse["customer"].toString());
  sp.setString("priceId", upgradeResponse['items']['data'][0]['plan']['id'].toString());
}

// +++++++++++++++++++++++++++
// ++ CANCEL SUBSCRIPTION ++
// +++++++++++++++++++++++++++

Future<void> cancelSubscription(String subscriptionId,id,context) async {
  await apiService(
    endpoint: 'subscriptions/$subscriptionId',
    requestMethod: ApiServiceMethodType.delete,
  ).then((value) => HomeViewModel().cancelSubscriptionAPI(id, context)
  );

  // .then((value) => utils().toastMethod("Your current subscription has been permanently unsubscribed."));
}


