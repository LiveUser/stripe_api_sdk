# Stripe API SDK
Unofficial Stripe API SDK(under development)
---------------------------------------------------
Hecho en 🇵🇷 por Radamés J. Valentín Reyes
---------------------------------------------------

## Import

~~~dart
import 'package:stripe_api_sdk/stripe_api_sdk.dart';
import 'package:stripe_api_sdk/objects.dart';
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
~~~dart

~~~

### Create a Customer
~~~dart
Customer customer = await stripe.createACustomer(
  customer: Customer(
    description: "Radamés account", 
    email: "valentin.radames@outlook.com", 
    name: "Radamés Valentín", 
    phone: "1234567890", 
  ),
);
~~~

### Retrieve a customer
~~~dart
Customer retrievedCustomer = await stripe.retrieveCustomer(
  customerId: "customerId",
);
~~~
### Update a customer

### Delete a customer
~~~dart
bool deleted = await stripe.deleteCustomer(customerId: customer.id!);
~~~
### List all customers
~~~dart
AllCustomersList allCustomersList = await stripe.listAllCustomers();
~~~
### List all customers(next page)
~~~dart
AllCustomersList allCustomersList = await stripe.listAllCustomers();
AllCustomersList nextPage = await stripe.listAllCustomers(
  startingAfter: allCustomersList.customers.last.id,
);
~~~
### Search customers


------------------------------------------------------------
## Contribute/donate by tapping on the Pay Pal logo/image

<a href="https://www.paypal.com/paypalme/onlinespawn"><img src="https://www.paypalobjects.com/webstatic/mktg/logo/pp_cc_mark_74x46.jpg"/></a>

------------------------------------------------------------
# References

- https://stripe.com/docs/api
- https://stripe.com/docs/api/balance
- https://stripe.com/docs/api/balance_transactions/object
- https://stripe.com/docs/api/charges
- https://stripe.com/docs/api/charges/object#charge_object-billing_details
- https://stripe.com/docs/api/charges/object#charge_object-billing_details-address
- https://stripe.com/docs/api/customers