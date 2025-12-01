# Flutter Tax Integration Documentation

## Overview

The FoodBank backend now supports restaurant-specific tax calculations. This document provides guidance for the Flutter app team on how to properly display tax information to customers.

## Backend Tax Implementation

### Tax Fields Available

The following tax-related fields are available in the Order model:

```json
{
  "tax_rate": 17.0, // Tax rate as decimal (e.g., 17.00 for 17%)
  "tax_amount": 1.7, // Calculated tax amount in currency
  "formatted_tax_rate": "17.00%", // Human-readable tax rate with % symbol
  "formatted_tax_amount": "$1.70" // Human-readable tax amount with currency
}
```

### Order Calculation Structure

```json
{
  "sub_total": 10.0, // Items total before tax and delivery
  "delivery_charge": 0.0, // Delivery fee (0 for pickup orders)
  "tax_rate": 17.0, // Restaurant's tax rate percentage
  "tax_amount": 1.7, // Tax calculated on subtotal
  "total": 11.7 // Final total (sub_total + delivery_charge + tax_amount)
}
```

## Required API Updates

### 1. Update OrderApiResource

The API resource needs to include tax fields. Add these to `app/Http/Resources/v1/OrderApiResource.php`:

```php
'tax_rate' => $this->tax_rate,
'tax_amount' => $this->tax_amount,
'formatted_tax_rate' => $this->formatted_tax_rate,
'formatted_tax_amount' => $this->formatted_tax_amount,
```

### 2. Cart/Checkout API Response

Ensure cart calculations return tax information:

```json
{
  "subtotal": 10.0,
  "delivery_charge": 0.0,
  "tax_rate": 17.0,
  "tax_amount": 1.7,
  "total": 11.7,
  "restaurant": {
    "tax_rate": 17.0
  }
}
```

## Flutter Implementation Guidelines

### 1. Order Summary Display

Display tax breakdown in order summary screens:

```dart
// Order Summary Widget
Column(
  children: [
    _buildSummaryRow('Subtotal', currencyFormat(order.subTotal)),

    // Show delivery charge only for delivery orders
    if (order.orderType == OrderType.delivery && order.deliveryCharge > 0)
      _buildSummaryRow('Delivery Charge', currencyFormat(order.deliveryCharge)),

    // Show tax only when applicable
    if (order.taxAmount > 0)
      _buildSummaryRow('Tax (${order.formattedTaxRate})', currencyFormat(order.taxAmount)),

    Divider(),
    _buildSummaryRow('Total', currencyFormat(order.total), isTotal: true),
  ],
)
```

### 2. Cart Screen

Show real-time tax calculations in cart:

```dart
// Cart Total Section
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        _summaryRow('Subtotal', cart.subtotal),

        if (selectedOrderType == OrderType.delivery)
          _summaryRow('Delivery', cart.deliveryCharge),

        if (cart.restaurant.taxRate > 0)
          _summaryRow('Tax (${cart.restaurant.taxRate}%)', cart.taxAmount),

        Divider(thickness: 2),
        _summaryRow('Total', cart.total, bold: true),
      ],
    ),
  ),
)
```

### 3. Order History

Display tax in order history items:

```dart
// Order History Card
ListTile(
  title: Text('Order #${order.orderCode}'),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('${order.restaurant.name}'),
      if (order.taxAmount > 0)
        Text('Includes ${order.formattedTaxRate} tax',
             style: TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  ),
  trailing: Text(currencyFormat(order.total)),
)
```

### 4. Receipt/Invoice View

Comprehensive breakdown for receipts:

```dart
// Receipt Widget
Column(
  children: [
    // Order items list...

    Divider(),

    // Summary section
    _receiptRow('Subtotal', order.subTotal),

    if (order.deliveryCharge > 0)
      _receiptRow('Delivery Charge', order.deliveryCharge),

    if (order.taxAmount > 0)
      _receiptRow('Tax (${order.formattedTaxRate})', order.taxAmount),

    Divider(thickness: 2),
    _receiptRow('Total', order.total, bold: true),
  ],
)
```

## Data Models

### Order Model (Dart)

```dart
class Order {
  final int id;
  final String orderCode;
  final double subTotal;
  final double deliveryCharge;
  final double taxRate;        // Add this
  final double taxAmount;      // Add this
  final double total;
  final String formattedTaxRate;    // Add this (e.g., "17.00%")
  final String formattedTaxAmount;  // Add this (e.g., "$1.70")

  // ... other fields

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderCode = json['order_code'],
        subTotal = double.parse(json['sub_total'].toString()),
        deliveryCharge = double.parse(json['delivery_charge'].toString()),
        taxRate = double.parse(json['tax_rate']?.toString() ?? '0'),
        taxAmount = double.parse(json['tax_amount']?.toString() ?? '0'),
        total = double.parse(json['total'].toString()),
        formattedTaxRate = json['formatted_tax_rate'] ?? '0%',
        formattedTaxAmount = json['formatted_tax_amount'] ?? '\$0.00';
}
```

### Restaurant Model (Dart)

```dart
class Restaurant {
  final int id;
  final String name;
  final double taxRate;        // Add this
  final String formattedTaxRate; // Add this

  // ... other fields

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        taxRate = double.parse(json['tax_rate']?.toString() ?? '17.0'),
        formattedTaxRate = json['formatted_tax_rate'] ?? '17.00%';
}
```

## Tax Display Rules

### When to Show Tax

- **Always show** when `tax_amount > 0`
- **Include tax rate** in parentheses: "Tax (17.00%)"
- **Show as separate line item** before total

### When NOT to Show Tax

- When `tax_amount` is 0 or null
- For tax-exempt restaurants (rare case)

### Formatting Guidelines

1. **Tax Rate**: Display with 2 decimal places and % symbol (e.g., "17.00%")
2. **Tax Amount**: Use the same currency formatting as other amounts
3. **Position**: Always between subtotal/delivery and total
4. **Styling**: Use normal text weight (not bold) for tax line

## Cart Calculations

### Real-time Updates

When cart contents change:

1. Calculate subtotal from items
2. Add delivery charge (if delivery order)
3. Calculate tax on subtotal: `tax_amount = subtotal * (tax_rate / 100)`
4. Calculate total: `total = subtotal + delivery_charge + tax_amount`

### Example Calculation

```dart
double calculateTax(double subtotal, double taxRate) {
  return subtotal * (taxRate / 100);
}

double calculateTotal(double subtotal, double deliveryCharge, double taxAmount) {
  return subtotal + deliveryCharge + taxAmount;
}
```

## Testing Scenarios

### Test Cases

1. **Pickup Order**: Subtotal + Tax (no delivery charge)
2. **Delivery Order**: Subtotal + Delivery + Tax
3. **Zero Tax**: Restaurant with 0% tax rate
4. **Different Tax Rates**: Restaurants with 5%, 10%, 17%, 20% tax rates

### Sample Data

```json
// Pickup Order with Tax
{
  "sub_total": 25.00,
  "delivery_charge": 0.00,
  "tax_rate": 17.00,
  "tax_amount": 4.25,
  "total": 29.25
}

// Delivery Order with Tax
{
  "sub_total": 25.00,
  "delivery_charge": 2.50,
  "tax_rate": 17.00,
  "tax_amount": 4.25,
  "total": 31.75
}
```

## Error Handling

### Null Safety

```dart
// Safe tax display
if (order.taxAmount != null && order.taxAmount > 0) {
  _buildTaxRow(order.formattedTaxRate ?? '0%', order.taxAmount);
}
```

### Fallback Values

- Default tax rate: 17.00%
- Default tax amount: 0.00
- Handle missing formatted values gracefully

## UI/UX Recommendations

### Visual Hierarchy

1. Subtotal (normal weight)
2. Delivery charge (normal weight, if applicable)
3. Tax with rate (normal weight, slightly muted color)
4. **Total (bold, emphasized)**

### Color Coding

- Subtotal, delivery, tax: Default text color
- Total: Primary/accent color, bold
- Tax rate in parentheses: Slightly muted

### Spacing

- Add consistent spacing between line items
- Use divider before total
- Align amounts to the right

This implementation ensures customers have full transparency about tax calculations while maintaining a clean, professional appearance in the app.
