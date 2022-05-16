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
      email: "valentin.radames@outlook.com", 
      description: "Radames account", 
      phone: "1234567890", 
      name: "Radamés Valentín",
    );
    print(customer);
  });
  /*
  test("Charge test", ()async{
    //Get customer ID
    String custumerID = "";
    //Charge 100 cents(usd).
    Charge charge = await stripe.charge(
      amount: 100, 
      currency: "usd", 
      customer: custumerID, 
      description: "Test transaction",
      receipt_email: "valentin.radames@outlook.com",
    );
    print(charge);
  });*/
}
