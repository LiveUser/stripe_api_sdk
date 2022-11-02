import 'package:stripe_api_sdk/objects.dart';
import 'package:test/test.dart';
import 'package:stripe_api_sdk/stripe_api_sdk.dart';

const String secretKey = "sk_test_51KpLqfGIVzzJK0zBrJMC6F7QflgAf1Smd1tROtbrUp0fxrmEQn2zsMCXOizpjaeZxt2A5NpQDvnu8056OcTEceZW003xCWzkug";
void main() {
  Stripe stripe = Stripe(
    secretKey: secretKey,
  );
  test("Get my balance", ()async{
    Balance myBalance = await stripe.getMyBalance();
    print(myBalance.available.first.amount);
  });
  test("List balance transactions", ()async{
    ListOfBalanceTransactions balanceTransactions = await stripe.listAllBalanceTransactions();
    print(balanceTransactions.data);
  });
  
  test("Create account test", ()async{
    Customer customer = await stripe.createACustomer(
      customer: Customer(
        description: "Radamés account", 
        email: "valentin.radames@outlook.com", 
        name: "Radamés Valentín", 
        phone: "1234567890", 
      ),
    );
    print(customer.id);
  });
  test("Retrieve a customer", ()async{
    Customer customer = await stripe.createACustomer(
      customer: Customer(
        description: "Radamés account", 
        email: "valentin.radames@outlook.com", 
        name: "Radamés Valentín", 
        phone: "1234567890", 
      ),
    );
    Customer retrievedCustomer = await stripe.retrieveCustomer(
      customerId: customer.id!,
    );
    print(retrievedCustomer.name);
  });
  test("Delete  customer", ()async{
    Customer customer = await stripe.createACustomer(
      customer: Customer(
        description: "Radamés account", 
        email: "valentin.radames@outlook.com", 
        name: "Radamés Valentín", 
        phone: "1234567890", 
      ),
    );
    bool deleted = await stripe.deleteCustomer(customerId: customer.id!);
    print("${deleted ? "Deleted" : "Did not delete"} customer ${customer.id}");
  });
  test("List all customers", ()async{
    AllCustomersList allCustomersList = await stripe.listAllCustomers();
    print("There are currently ${allCustomersList.customers.length} in this list");
    print("There are more pages equals ${allCustomersList.has_more}");
  });
  test("Next page", ()async{
    AllCustomersList allCustomersList = await stripe.listAllCustomers();
    AllCustomersList nextPage = await stripe.listAllCustomers(
      startingAfter: allCustomersList.customers.last.id,
    );
    print("There are currently ${nextPage.customers.length} in this list");
    print("There are more pages equals ${nextPage.has_more}");
  });
  test("Charge test", ()async{
    //TODO: Get customer
    AllCustomersList allCustomersList = await stripe.listAllCustomers();
    Customer customer = allCustomersList.customers.first;
    //TODO: Add active card to customer
    
    //Charge 100 cents(usd).
    String charge = await stripe.charge(
      charge: Charge(
        id: "ch_3LyKfF2eZvKYlo2C0LrMeOvc", 
        amount: 100, 
        balance_transaction: "txn_1032HU2eZvKYlo2CEPtcnUvl", 
        billing_details: BillingDetails(
          billing_details: BillingAddress(
            city: null,
            country: null,
            line1: null,
            line2: null,
            postal_code: null,
            state: null, 
            email: null, 
            name: null, 
            phone: null,
          ),
          email: null,
          phone: null,
          name: "Jenny Rosen",
        ), 
        currency: "usd", 
        //TODO: Get customer id
        customer: customer.id!, 
        description: "My First Test Charge (created for API docs)", 
        disputed: false, 
        invoice: null, 
        metadata: {}, 
        payment_intent: null, 
        payment_method: "card_19yUNL2eZvKYlo2CNGsN6EWH", 
        payment_method_details: PaymentMethodDetails(
          card: Card(
            brand: "visa",
            checks: CardChecks(
              address_line1_check: null,
              address_postal_code_check: null,
              cvc_check: "unchecked",
            ),
          ),
          country: "US",
          exp_month: 12,
          exp_year: 2020,
          fingerprint: "Xt5EWLLDS7FJjR1c",
          funding: "credit",
          installments: null,
          last4: "4242",
          mandate: null,
          moto: null,
          network: "visa",
          three_d_secure: null,
          wallet: null, 
          type: "card",
        ), 
        receipt_email: null, 
        refunded: false, 
        shipping: null, 
        statement_descriptor: null, 
        statement_descriptor_suffix: null, 
        status: ChargeStatus.succeeded,
      ),
    );
    print(charge);
  });
}