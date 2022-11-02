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
  Future<String> charge({
    required Charge charge,
    bool livemode = false,
  })async{
    Map<String,dynamic> parameters = {
      "id": charge.id,
      "object": "charge",
      "amount": charge.amount,
      "amount_captured": 0,
      "amount_refunded": 0,
      "application": null,
      "application_fee": null,
      "application_fee_amount": null,
      "balance_transaction": charge.balance_transaction,
      "billing_details": {
        "address": {
          "city": charge.billing_details.billing_details.city,
          "country": charge.billing_details.billing_details.country,
          "line1": charge.billing_details.billing_details.line1,
          "line2": charge.billing_details.billing_details.line2,
          "postal_code": charge.billing_details.billing_details.postal_code,
          "state": charge.billing_details.billing_details.state,
        },
        "email": charge.billing_details.email,
        "name": charge.billing_details.name,
        "phone": charge.billing_details.phone,
      },
      "calculated_statement_descriptor": null,
      "captured": false,
      "created": 1667071553,
      "currency": charge.currency,
      "customer": charge.customer,
      "description": charge.description,
      "disputed": charge.disputed,
      "failure_balance_transaction": null,
      "failure_code": null,
      "failure_message": null,
      "fraud_details": {},
      "invoice": charge.invoice,
      "livemode": livemode,
      "metadata": charge.metadata,
      "on_behalf_of": null,
      "outcome": null,
      "paid": true,
      "payment_intent": charge.payment_intent,
      "payment_method": charge.payment_method,
      "payment_method_details": {
        "card": {
          "brand": charge.payment_method_details.card.brand,
          "checks": {
            "address_line1_check": charge.payment_method_details.card.checks.address_line1_check,
            "address_postal_code_check": charge.payment_method_details.card.checks.address_postal_code_check,
            "cvc_check": charge.payment_method_details.card.checks.cvc_check,
          },
          "country": charge.payment_method_details.country,
          "exp_month": charge.payment_method_details.exp_month,
          "exp_year": charge.payment_method_details.exp_year,
          "fingerprint": charge.payment_method_details.fingerprint,
          "funding": charge.payment_method_details.funding,
          "installments": charge.payment_method_details.installments,
          "last4": charge.payment_method_details.last4,
          "mandate": charge.payment_method_details.mandate,
          "moto": charge.payment_method_details.moto,
          "network": charge.payment_method_details.network,
          "three_d_secure": charge.payment_method_details.three_d_secure,
          "wallet": charge.payment_method_details.wallet,
        },
        "type": charge.payment_method_details.type,
      },
      "receipt_email": charge.receipt_email,
      "receipt_number": null,
      "receipt_url": "https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xMDMyRDgyZVp2S1lsbzJDKMH89ZoGMgYY33nubCk6LBa4yA8R0PzzLLqT207RF_v7D9VTkQGBjUh7kjPHiWCANvSICeGSgq5khnk4",
      "redaction": null,
      "refunded": charge.refunded,
      "refunds": {
        "object": "list",
        "data": [],
        "has_more": false,
        "url": "/v1/charges/ch_3LyKfF2eZvKYlo2C0LrMeOvc/refunds"
      },
      "review": null,
      "shipping": charge.shipping,
      "source_transfer": null,
      "statement_descriptor": charge.statement_descriptor,
      "statement_descriptor_suffix": charge.statement_descriptor_suffix,
      "status": enumToString(charge.status),
      "transfer_data": null,
      "transfer_group": null
    };
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/charges",
      parameters: {},
    ).post(
      headers: {
        "Authorization" : "Basic $_encodedKey",
        "Content-Type" : "application/x-www-form-urlencoded",
      },
      body: toApplicationX_Www_Form_Urlencoded(parameters),
    );
    errorThrower(response);
    //return Charge.parse(jsonDecode(response));
    return response;
  }
  //Customers API
  Future<Customer> createACustomer({
    required Customer customer,
  })async{
    Map<String,dynamic> parameters = {
      //"id": "cus_9BoKyB2Km2T7TE",
      "balance": customer.balance,
      "description": customer.description,
      "email": customer.email,
      "name": customer.name,
      "phone": "+995315324234",
      "tax_exempt": customer.tax_exempt,
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
  Future<Customer> retrieveCustomer({
    required String customerId,
  })async{
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/customers/$customerId",
      parameters: {},
    ).get(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      }
    );
    errorThrower(response);
    Map<String,dynamic> parsedJSON = jsonDecode(response);
    return Customer.parse(parsedJSON);
  }
  //TODO: Update a customer

  //Delete a customer
  Future<bool> deleteCustomer({
    required String customerId,
  })async{
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/customers/$customerId",
      parameters: {},
    ).delete(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      },
      body: null,
    );
    errorThrower(response);
    Map<String,dynamic> parsedResponse = jsonDecode(response);
    return parsedResponse["deleted"];
  }
  //List all customers
  Future<AllCustomersList> listAllCustomers({
    ///A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    int limit = 10,
    ///A cursor for use in pagination. starting_after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include starting_after=obj_foo in order to fetch the next page of the list.
    String? startingAfter,
  })async{
    Map<String,dynamic> parameters = {
      "limit" : limit,
    };
    if(startingAfter != null){
      parameters.addAll({
        "starting_after": startingAfter,
      });
    }
    String response = await SexyAPI(
      url: _baseUrl, 
      path: "/v1/customers",
      parameters: parameters,
    ).get(
      headers: {
        "Authorization" : "Basic $_encodedKey",
      }
    );
    errorThrower(response);
    Map<String,dynamic> parsedJSON = jsonDecode(response);
    List<Customer> customers = [];
    for(Map<String,dynamic> customer in parsedJSON["data"]){
      customers.add(Customer.parse(customer));
    }
    return AllCustomersList(
      has_more: parsedJSON["has_more"], 
      customers: customers,
    );
  }
  //TODO: Search customers
}
