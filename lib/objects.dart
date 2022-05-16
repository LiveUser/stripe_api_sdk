// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'dart:convert';

class Funds{
  Funds({
    required this.amount,
    required this.currency,
    // ignore: non_constant_identifier_names
    required this.source_types,
  });
  ///Gross amount of the transaction, in cents.
  final int amount;
  ///Three-letter ISO currency code, in lowercase. Must be a supported currency.
  final String currency;
  // ignore: non_constant_identifier_names
  final Map<String,dynamic> source_types;
}
class Balance{
  Balance({
    required this.available,
    required this.pending,
    required this.livemode,
  });
  final List<Funds> available;
  final List<Funds> pending;
  final bool livemode;
  static Balance parse(String response){
    Map<String,dynamic> parsedJSON = jsonDecode(response);
    if(parsedJSON["object"] == "balance"){
      List<Funds> available = [];
      for(Map<String,dynamic> funds in parsedJSON["available"]){
          available.add(Funds(
            amount: funds["amount"], 
            currency: funds["currency"], 
            source_types: funds["source_types"],
          ),
        );
      }
      List<Funds> pending = [];
      for(Map<String,dynamic> pendingFunds in parsedJSON["available"]){
          available.add(Funds(
            amount: pendingFunds["amount"], 
            currency: pendingFunds["currency"], 
            source_types: pendingFunds["source_types"],
          ),
        );
      }
      return Balance(
        available: available,
        pending: pending,
        livemode: parsedJSON["livemode"],
      );
    }else{
      throw "It's not a balance object";
    }
  }
}
//Fee Details
class FeeDetails{
  FeeDetails({
    required this.amount,
    required this.application,
    required this.currency,
    required this.description,
    required this.type,
  });
  ///Amount of the fee, in cents.
  final int amount;
  ///ID of the Connect application that earned the fee.
  final String application;
  final String currency;
  ///An arbitrary string attached to the object. Often useful for displaying to users.
  final String description;
  ///Type of the fee, one of: application_fee, stripe_fee or tax.
  final String type;
}
// ignore: duplicate_ignore, duplicate_ignore
class BalanceTransaction{
  BalanceTransaction({
    required this.id,
    required this.amount,
    required this.currency,
    required this.description,
    required this.fee,
    // ignore: non_constant_identifier_names
    required this.fee_details,
    required this.net,
    required this.source,
    required this.status,
    required this.type,
    required this.available_on,
    required this.created,
    required this.exchange_rate,
    required this.object,
    required this.reporting_category,
  });
  final String id;
  ///Gross amount of the transaction, in cents.
  final int amount;
  final String currency;
  ///An arbitrary string attached to the object. Often useful for displaying to users.
  final String description;
  ///Fees (in cents) paid for this transaction.
  final int fee;
  // ignore: non_constant_identifier_names
  final List<FeeDetails> fee_details;
  ///Net amount of the transaction, in cents.
  final int net;
  ///The Stripe object to which this transaction is related.
  final String source;
  ///If the transaction’s net funds are available in the Stripe balance yet. Either available or pending.
  final String status;
  ///Transaction type: adjustment, advance, advance_funding, anticipation_repayment, application_fee, application_fee_refund, charge, connect_collection_transfer, contribution, issuing_authorization_hold, issuing_authorization_release, issuing_dispute, issuing_transaction, payment, payment_failure_refund, payment_refund, payout, payout_cancel, payout_failure, refund, refund_failure, reserve_transaction, reserved_funds, stripe_fee, stripe_fx_fee, tax_fee, topup, topup_reversal, transfer, transfer_cancel, transfer_failure, or transfer_refund.
  final String type;
  ///string, value is "balance_transaction"
  final String object;
  ///The date the transaction’s net funds will become available in the Stripe balance.
  final num available_on;
  ///Time at which the object was created. Measured in seconds since the Unix epoch.
  final num created;
  ///The exchange rate used, if applicable, for this transaction. Specifically, if money was converted from currency A to currency B, then the amount in currency A, times exchange_rate, would be the amount in currency B. For example, suppose you charged a customer 10.00 EUR. Then the PaymentIntent’s amount would be 1000 and currency would be eur. Suppose this was converted into 12.34 USD in your Stripe account. Then the BalanceTransaction’s amount would be 1234, currency would be usd, and exchange_rate would be 1.234.
  final num exchange_rate;
  ///Learn more about how reporting categories can help you understand balance transactions from an accounting perspective.
  // ignore: non_constant_identifier_names
  final String reporting_category;
  //Parse
  static BalanceTransaction parse(Map<String,dynamic> parsedJSON){
    List<FeeDetails> feeDetails = [];
    for(Map<String,dynamic> feeDetail in parsedJSON["fee_details"]){
      feeDetails.add(FeeDetails(
          amount: feeDetail["amount"], 
          application: feeDetail["application"], 
          currency: feeDetail["currency"], 
          description: feeDetail["description"], 
          type: feeDetail["type"],
        ),
      );
    }
    return BalanceTransaction(
      id: parsedJSON["id"], 
      amount: parsedJSON["amount"], 
      currency: parsedJSON["currency"], 
      description: parsedJSON["description"], 
      fee: parsedJSON["fee"], 
      fee_details: feeDetails, 
      net: parsedJSON["net"], 
      source: parsedJSON["source"], 
      status: parsedJSON["status"], 
      type: parsedJSON["type"], 
      available_on: parsedJSON["available_on"], 
      created: parsedJSON["created"], 
      exchange_rate: parsedJSON["exchange_rate"], 
      object: parsedJSON["object"], 
      reporting_category: parsedJSON["reporting_category"],
    );
  }
}
class BillingAddress{
  BillingAddress({
    required this.city,
    required this.country,
    required this.email,
    required this.line1,
    required this.line2, 
    required this.name,
    required this.phone,
    required this.postal_code,
    required this.state,
  });
  ///City, district, suburb, town, or village.
  final String city;
  ///Two-letter country code (ISO 3166-1 alpha-2).
  final String country;
  ///Address line 1 (e.g., street, PO Box, or company name).
  final String line1;
  ///Address line 2 (e.g., apartment, suite, unit, or building).
  final String line2;
  ///ZIP or postal code.
  final String postal_code;
  ///State, county, province, or region.
  final String state;
  ///Email address.
  final String email;
  ///Full name.
  final String name;
  ///Billing phone number (including extension).
  final String phone;
}
//Add properties
class BillingDetails{
  BillingDetails({
    required this.billing_details,
    required this.email,
    required this.name,
    required this.phone,
  });
  ///Billing address.
  final BillingAddress billing_details;
  final String email;
  //Full name.
  final String name;
  ///Billing phone number (including extension).
  final String phone;
}
//TODO: PaymentMethodDetails
class PaymentMethodDetails{

}
class ListOfBalanceTransactions{
  ListOfBalanceTransactions({
    required this.has_more,
    required this.url,
    required this.data,
  });
  final String url;
  final bool has_more;
  final List<BalanceTransaction> data;
}
enum ChargeStatus{
  succeeded,
  pending,
  failed,
}
//TODO: Create charge object and add all of its properties
class Charge{
  Charge({
    required this.id,
    required this.amount,
    required this.balance_transaction,
    required this.billing_details,
    required this.currency,
    required this.customer,
    required this.description,
    required this.disputed,
    required this.invoice,
    required this.metadata, 
    required this.payment_intent,
    required this.payment_method_details,
    required this.receipt_email,
    required this.refunded,
    required this.shipping,
    required this.statement_descriptor,
    required this.statement_descriptor_suffix,
    required this.status,
  });
  ///Unique identifier for the object.
  final String id;
  ///Amount intended to be collected by this payment. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
  final num amount;
  ///ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).
  final String balance_transaction;
  ///Billing information associated with the payment method at the time of the transaction.
  final BillingDetails billing_details;
  ///Three-letter ISO currency code, in lowercase. Must be a supported currency.
  final String currency;
  ///ID of the customer this charge is for if one exists.
  final String customer;
  ///An arbitrary string attached to the object. Often useful for displaying to users.
  final String description;
  ///Whether the charge has been disputed.
  final bool disputed;
  ///ID of the invoice this charge is for if one exists.
  final String invoice;
  ///Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
  final Map<String,dynamic> metadata;
  ///ID of the PaymentIntent associated with this charge, if one exists.
  final String payment_intent;
  ///Details about the payment method at the time of the transaction.
  ///https://stripe.com/docs/api/charges/object#charge_object-payment_method_details
  final Map<String,Map<String,String>> payment_method_details;
  ///This is the email address that the receipt for this charge was sent to.
  final String receipt_email;
  ///Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
  final bool refunded;
  ///Shipping information for the charge.
  final Map<String,dynamic> shipping;
  ///For card charges, use statement_descriptor_suffix instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
  final String statement_descriptor;
  ///Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
  final String statement_descriptor_suffix;
  final ChargeStatus status;
  static Charge parse(Map<String,dynamic> parsedJSON){
    return Charge(
      id: parsedJSON["id"], 
      amount: parsedJSON["amount"], 
      balance_transaction: parsedJSON["balance_transaction"], 
      billing_details: BillingDetails(
        billing_details: BillingAddress(
          city: parsedJSON["billing_details"]["city"],
          country: parsedJSON["billing_details"]["country"],
          email: parsedJSON["billing_details"]["email"],
          line1: parsedJSON["billing_details"]["line1"],
          line2: parsedJSON["billing_details"]["line2"],
          name: parsedJSON["billing_details"]["name"],
          phone: parsedJSON["billing_details"]["phone"],
          postal_code: parsedJSON["billing_details"]["postal_code"],
          state: parsedJSON["billing_details"]["state"],
        ),
        email: parsedJSON["billing_details"]["email"],
        name: parsedJSON["billing_details"]["name"],
        phone: parsedJSON["billing_details"]["phone"],
      ), 
      currency: parsedJSON["currency"], 
      customer: parsedJSON["customer"], 
      description: parsedJSON["description"], 
      disputed: parsedJSON["disputed"], 
      invoice: parsedJSON["invoice"], 
      metadata: parsedJSON["metadata"], 
      payment_intent: parsedJSON["payment_intent"], 
      payment_method_details: parsedJSON["payment_method_details"], 
      receipt_email: parsedJSON["receipt_email"], 
      refunded: parsedJSON["refunded"],
      shipping: parsedJSON["shipping"], 
      statement_descriptor: parsedJSON["statement_descriptor"], 
      statement_descriptor_suffix: parsedJSON["statement_descriptor_suffix"], 
      status: parsedJSON["status"],
    );
  }
}
//TODO: Create the customer object
class Customer{
  Customer({
    required this.id,
    required this.address,
    required this.balance,
    required this.currency,
    required this.default_source,
    required this.delinquent,
    required this.livemode,
    required this.discount,
    this.created,
    this.tax_exempt = "none",
    this.test_clock,
    required this.description,
    required this.email,
    required this.invoice_prefix,
    this.metadata,
    required this.invoice_settings,
    required this.name,
    required this.next_invoice_sequence,
    required this.phone,
    required this.preferred_locales,
    required this.shipping,
  });
    final String id;
    final object = "customer";
    final BillingAddress? address;
    final num balance;
    final num? created;
    final String? currency;
    final String? default_source;
    final bool delinquent;
    final String description;
    final Map<String,dynamic>? discount;
    final String email;
    final String invoice_prefix;
    final Map<String,dynamic>? invoice_settings;
    final bool livemode;
    final Map<String,dynamic>? metadata;
    final String name;
    final num next_invoice_sequence;
    final String phone;
    final List? preferred_locales;
    final Map<String,dynamic>? shipping;
    final String tax_exempt;
    final String? test_clock;
    static Customer parse(Map<String,dynamic> parsedJSON){
      return Customer(
        id: parsedJSON["id"], 
        address: null, 
        balance: parsedJSON["balance"], 
        currency: parsedJSON["currency"], 
        default_source: parsedJSON["default_source"], 
        delinquent: parsedJSON["delinquent"], 
        livemode: parsedJSON["livemode"], 
        discount: parsedJSON["discount"], 
        description: parsedJSON["description"], 
        email: parsedJSON["email"], 
        invoice_prefix: parsedJSON["invoice_prefix"], 
        invoice_settings: parsedJSON["invoice_settings"], 
        name: parsedJSON["name"], 
        next_invoice_sequence: parsedJSON["next_invoice_sequence"], 
        phone: parsedJSON["phone"], 
        preferred_locales: parsedJSON["preferred_locales"], 
        shipping: parsedJSON["shipping"],
      );
    }
}