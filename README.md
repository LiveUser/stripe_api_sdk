# Stripe API SDK
Unofficial Stripe API SDK(under development)
---------------------------------------------------
Hecho en 🇵🇷 por Radamés J. Valentín Reyes
---------------------------------------------------

## Import

~~~dart
import 'package:stripe_api_sdk/stripe_api_sdk.dart';
~~~

## Get Started

Create an instance of Stripe

~~~dart
Stripe stripe = Stripe(
  secretKey: secretKey,
);
~~~

## API Functions

### Get my balance

~~~dart
Balance myBalance = await stripe.getMyBalance();
~~~

### List all balance transactions

~~~dart
ListOfBalanceTransactions balanceTransactions = await stripe.listAllBalanceTransactions();
~~~

### Get balance transaction

~~~dart
BalanceTransaction balanceTransaction = await getBalanceTransaction(
  balanceTransactionID : balanceTransactionID,
);
~~~

### Create Charge

### Create a Customer
~~~dart
Customer customer = await stripe.createACustomer(
  email: "valentin.radames@outlook.com", 
  description: "Radames account", 
  phone: "1234567890", 
  name: "Radamés Valentín",
);
~~~

# References

- https://stripe.com/docs/api
- https://stripe.com/docs/api/balance
- https://stripe.com/docs/api/balance_transactions/object
- https://stripe.com/docs/api/charges
- https://stripe.com/docs/api/charges/object#charge_object-billing_details
- https://stripe.com/docs/api/charges/object#charge_object-billing_details-address
- https://stripe.com/docs/api/customers