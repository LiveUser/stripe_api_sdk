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
  final String? city;
  ///Two-letter country code (ISO 3166-1 alpha-2).
  final String? country;
  ///Address line 1 (e.g., street, PO Box, or company name).
  final String? line1;
  ///Address line 2 (e.g., apartment, suite, unit, or building).
  final String? line2;
  ///ZIP or postal code.
  final String? postal_code;
  ///State, county, province, or region.
  final String? state;
  ///Email address.
  final String? email;
  ///Full name.
  final String? name;
  ///Billing phone number (including extension).
  final String? phone;
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
  final String? email;
  //Full name.
  final String name;
  ///Billing phone number (including extension).
  final String? phone;
}
class CardChecks{
  CardChecks({
    required this.address_line1_check,
    required this.address_postal_code_check,
    this.cvc_check = "unchecked",
  });
  final String? address_line1_check;
  final String? address_postal_code_check;
  final String cvc_check;
}
class Card{
  Card({
    required this.brand,
    required this.checks,
  });
  final String brand;
  final CardChecks checks;
}
//TODO: PaymentMethodDetails
class PaymentMethodDetails{
  PaymentMethodDetails({
    required this.card,
    required this.country,
    required this.exp_month,
    required this.exp_year,
    required this.fingerprint,
    required this.funding,
    required this.installments,
    required this.last4,
    required this.mandate,
    required this.moto,
    required this.network,
    required this.three_d_secure,
    required this.wallet,
    required this.type,
  });
  final Card card;
  final String country;
  final int exp_month;
  final int exp_year;
  final String fingerprint;
  final String funding;
  //TODO: Installments in detail
  final Map<String,dynamic>? installments;
  final String last4;
  final String? mandate;
  //Made up this data type. Docs don't specify.
  final String? moto;
  final String network;
  //Supposed to be an enum but creating it takes too much time
  final String? three_d_secure;
  //Not sure about this one. Docs say type hash but they have children like objects
  final Map<String,dynamic>? wallet;
  final String type;
  static PaymentMethodDetails parse(Map<String,dynamic> object){
    return PaymentMethodDetails(
      card: object["card"], 
      country: object["country"], 
      exp_month: object["exp_month"], 
      exp_year: object["exp_year"], 
      fingerprint: object["fingerprint"], 
      funding: object["funding"], 
      installments: object["installments"], 
      last4: object["last4"], 
      mandate: object["mandate"], 
      moto: object["moto"], 
      network: object["network"], 
      three_d_secure: object["three_d_secure"], 
      wallet: object["wallet"],
      type: object["type"],
    );
  }
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
    required this.payment_method,
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
  final String? invoice;
  ///Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
  final Map<String,dynamic> metadata;
  ///ID of the PaymentIntent associated with this charge, if one exists.
  final String? payment_intent;
  final String payment_method;
  ///Details about the payment method at the time of the transaction.
  ///https://stripe.com/docs/api/charges/object#charge_object-payment_method_details
  final PaymentMethodDetails payment_method_details;
  ///This is the email address that the receipt for this charge was sent to.
  final String? receipt_email;
  ///Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
  final bool refunded;
  ///Shipping information for the charge.
  final Map<String,dynamic>? shipping;
  ///For card charges, use statement_descriptor_suffix instead. Otherwise, you can use this value as the complete description of a charge on your customers’ statements. Must contain at least one letter, maximum 22 characters.
  final String? statement_descriptor;
  ///Provides information about the charge that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
  final String? statement_descriptor_suffix;
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
      payment_method: parsedJSON["payment_method"],
      payment_method_details: PaymentMethodDetails.parse(parsedJSON["payment_method_details"]), 
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
    this.id,
    this.address,
    this.balance = 0,
    this.currency,
    this.default_source,
    this.delinquent = false,
    this.livemode,
    this.discount,
    this.created,
    this.tax_exempt = "none",
    this.test_clock,
    required this.description,
    required this.email,
    this.invoice_prefix,
    this.metadata,
    this.invoice_settings,
    this.name,
    this.next_invoice_sequence,
    this.phone,
    this.preferred_locales,
    this.shipping,
  });
    final String? id;
    final object = "customer";
    final BillingAddress? address;
    final num balance;
    final num? created;
    final String? currency;
    final String? default_source;
    final bool delinquent;
    final String? description;
    final Map<String,dynamic>? discount;
    final String? email;
    final String? invoice_prefix;
    final Map<String,dynamic>? invoice_settings;
    final bool? livemode;
    final Map<String,dynamic>? metadata;
    final String? name;
    final num? next_invoice_sequence;
    final String? phone;
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
class AllCustomersList{
  AllCustomersList({
    required this.has_more,
    required this.customers,
  });
  final bool has_more;
  final List<Customer> customers;
}
class PaymentIntent{
  PaymentIntent({
    required this.id,
    required this.amount,
    this.automatic_payment_methods,
    required this.charges,
    required this.client_secret,
    required this.currency,
    required this.customer,
    required this.description,
    this.last_payment_error,
    this.metadata,
    required this.payment_method,
    this.next_action,
    required this.payment_method_types,
    required this.receipt_email,
    this.setup_future_usage,
    this.shipping,
    this.statement_descriptor,
    this.statement_descriptor_suffix,
    required this.status,
  });
  ///Unique identifier for the object.
  final String id;
  ///Amount intended to be collected by this PaymentIntent. A positive integer representing how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or equivalent in charge currency. The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
  final int amount;
  ///Settings to configure compatible payment methods from the Stripe Dashboard
  final Map<String,dynamic>? automatic_payment_methods;
  ///Charges that were created by this PaymentIntent, if any.
  final Map<String,dynamic> charges;
  ///The client secret of this PaymentIntent. Used for client-side retrieval using a publishable key.
  ///The client secret can be used to complete a payment from your frontend. It should not be stored, logged, or exposed to anyone other than the customer. Make sure that you have TLS enabled on any page that includes the client secret.
  ///Refer to our docs to accept a payment and learn about how client_secret should be handled.
  final String client_secret;
  ///Three-letter ISO currency code, in lowercase. Must be a supported currency.
  final String currency;
  ///ID of the Customer this PaymentIntent belongs to, if one exists.
  ///Payment methods attached to other Customers cannot be used with this PaymentIntent.
  ///If present in combination with setup_future_usage, this PaymentIntent’s payment method will be attached to the Customer after the PaymentIntent has been confirmed and any required actions from the user are complete.
  final String? customer;
  ///An arbitrary string attached to the object. Often useful for displaying to users.
  final String? description;
  ///The payment error encountered in the previous PaymentIntent confirmation. It will be cleared if the PaymentIntent is later updated for any reason.
  final Map<String,dynamic>? last_payment_error;
  ///Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. For more information, see the documentation.
  final Map<String,dynamic>? metadata;
  ///If present, this property tells you what actions you need to take in order for your customer to fulfill a payment using the provided source.
  final Map<String,dynamic>? next_action;
  ///ID of the payment method used in this PaymentIntent.
  final String? payment_method;
  ///The list of payment method types (e.g. card) that this PaymentIntent is allowed to use.
  final List<String> payment_method_types;
  ///Email address that the receipt for the resulting payment will be sent to. If receipt_email is specified for a payment in live mode, a receipt will be sent regardless of your email settings.
  final String? receipt_email;
  ///Indicates that you intend to make future payments with this PaymentIntent’s payment method.
  ///Providing this parameter will attach the payment method to the PaymentIntent’s Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete. If no Customer was provided, the payment method can still be attached to a Customer after the transaction completes.
  ///When processing card payments, Stripe also uses setup_future_usage to dynamically optimize your payment flow and comply with regional legislation and network rules, such as SCA.
  final String? setup_future_usage;
  ///Shipping information for this PaymentIntent.
  final Map<String,dynamic>? shipping;
  ///For non-card charges, you can use this value as the complete description that appears on your customers’ statements. Must contain at least one letter, maximum 22 characters.
  final String? statement_descriptor;
  ///Provides information about a card payment that customers see on their statements. Concatenated with the prefix (shortened descriptor) or statement descriptor that’s set on the account to form the complete statement descriptor. Maximum 22 characters for the concatenated descriptor.
  final String? statement_descriptor_suffix;
  ///Status of this PaymentIntent, one of requires_payment_method, requires_confirmation, requires_action, processing, requires_capture, canceled, or succeeded. Read more about each PaymentIntent status.
  final String status;
  static PaymentIntent parse(Map<String,dynamic> parsedJSON){
    return PaymentIntent(
      id: parsedJSON["id"], 
      amount: parsedJSON["amount"], 
      automatic_payment_methods: parsedJSON["automatic_payment_methods"],
      charges: parsedJSON["charges"], 
      client_secret: parsedJSON["client_secret"], 
      currency: parsedJSON["currency"], 
      customer: parsedJSON["customer"], 
      description: parsedJSON["description"],
      last_payment_error: parsedJSON["last_payment_error"], 
      metadata: parsedJSON["metadata"],
      next_action: parsedJSON["next_action"],
      payment_method: parsedJSON["payment_method"], 
      payment_method_types: parsedJSON["payment_method_types"].cast<String>(), 
      receipt_email: parsedJSON["receipt_email"], 
      setup_future_usage: parsedJSON["setup_future_usage"],
      shipping: parsedJSON["shipping"],
      statement_descriptor: parsedJSON["statement_descriptor"],
      statement_descriptor_suffix: parsedJSON["statement_descriptor_suffix"],
      status: parsedJSON["status"],
    );
  }
}