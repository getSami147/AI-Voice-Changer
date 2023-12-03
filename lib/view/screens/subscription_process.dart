import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_maker/utils/widget.dart';
import 'package:voice_maker/viewModel/services/StripeApiService.dart';

// +++++++++++++++++++++++++++++++++++
// ++ STRIPE PAYMENT INITIALIZATION ++
// +++++++++++++++++++++++++++++++++++

Future<void> init(var price,var priceTempId,var customerName,var customerEmail) async {

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
 SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString("subscriptionId", subscriptionsResponse["id"].toString());
  sp.setString("customerId", subscriptionsResponse["customer"].toString());
  sp.setString("priceId", subscriptionsResponse['items']['data'][0]['plan']['id'].toString());

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
  await cancelSubscription(currentSubscriptionId);

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

Future<void> cancelSubscription(String subscriptionId) async {
  await apiService(
    endpoint: 'subscriptions/$subscriptionId',
    requestMethod: ApiServiceMethodType.delete,
  ).then((value) => utils().toastMethod("Your have parmanty UnSubscribed"));
}


