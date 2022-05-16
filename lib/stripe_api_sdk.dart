library stripe_api_sdk;

import 'package:sexy_api_client/sexy_api_client.dart';
import 'dart:convert';
import 'package:stripe_api_sdk/objects.dart';
import 'package:raw_encoder/raw_encoder.dart';
import 'functions.dart';

const String _baseUrl = "https://api.stripe.com";

class Stripe{
  Stripe({
    required this.secretKey,
  }){
    _encodedKey = base64Encode("$secretKey:".codeUnits);
  }
  //completely unecessary
  //final String publishableKey;
  final String secretKey;
  late final String _encodedKey;
  Future<Balance> getMyBalance()async{
    String response = await SexyAPI(
      url: _baseUrl,
      path: "/v1/balance",
      parameters: {},
    ).get(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      },
    );
    errorThrower(response);
    //try to parse the object
    return Balance.parse(response);
  }
  //TODO: Check how to add parameters later
  Future<ListOfBalanceTransactions> listAllBalanceTransactions(/*{
    int limit = 50,
    int starting_after = 0,
  }*/)async{
    String response = await SexyAPI(
      url: _baseUrl,
      path: "/v1/balance_transactions",
      parameters: {},
    ).get(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      },
    );
    errorThrower(response);
    List<BalanceTransaction> allTransactions = [];
    Map<String,dynamic> parsedJSON = jsonDecode(response);
    for(Map<String,dynamic> transaction in parsedJSON["data"]){
      allTransactions.add(BalanceTransaction.parse(transaction));
    }
    return ListOfBalanceTransactions(
      has_more: parsedJSON["has_more"], 
      url: parsedJSON["url"], 
      data: allTransactions,
    );
  }
  //Retrieve a balance transaction
  Future<BalanceTransaction> getBalanceTransaction({
    required String balanceTransactionID,
  })async{
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/balance_transactions/$balanceTransactionID",
      parameters: {},
    ).get();
    errorThrower(response);
    return BalanceTransaction.parse(jsonDecode(response));
  }
  //TODO: Charges API
  Future<Charge> charge({
    ///Amount intended to be collected by this payment. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    required int amount,
    ///Three-letter ISO currency code, in lowercase. Must be a supported currency.
    required String currency,
    ///The ID of an existing customer that will be charged in this request.
    required String? customer,
    ///An arbitrary string which you can attach to a Charge object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the description of the charge(s) that they are describing.
    required String? description,
    ///The email address to which this charge’s receipt will be sent. The receipt will not be sent until the charge is paid, and no receipts will be sent for test mode charges. If this charge is for a Customer, the email address specified here will override the customer’s email address. If receipt_email is specified for a charge in live mode, a receipt will be sent regardless of your email settings.
    // ignore: non_constant_identifier_names
    String receipt_email = "",
  })async{
    Map<String,dynamic> parameters = {
      "amount" : amount,
      "currency" : currency,
      "customer" : customer ?? "",
      "description" : description,
      "receipt_email" : receipt_email,
    };
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/charges",
      parameters: {},
    ).post(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      },
      body: parameters,
    );
    errorThrower(response);
    return Charge.parse(jsonDecode(response));
  }
  //TODO: Customers API
  Future<Customer> createACustomer({
    required String email,
    required String description,
    required String phone,
    ///The customer’s full name or business name.
    required String name,
    int balance = 0,
    String currency = "usd",
  })async{
    Map<String,dynamic> parameters = {
      //Miliseconds to seconds
      "description": description,
      "email": email,
      "name": name,
      "phone": phone,
      "tax_exempt": "none",
    };
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/customers",
      parameters: {},
    ).post(
      headers: {
        "Authorization" : "Basic $_encodedKey",
        "Content-Type" : "application/x-www-form-urlencoded",
      },
      body: toApplicationX_Www_Form_Urlencoded(parameters),
    );
    errorThrower(response);
    Map<String,dynamic> parsedJSON = jsonDecode(response);
    return Customer.parse(parsedJSON);
  }
}
