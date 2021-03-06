//
//  PKPayment.h
//  Wallet
//
//  Copyright (c) 2014 Apple, Inc. All rights reserved.
//

#import <AddressBook/ABRecord.h>
#import <PassKit/PKPaymentToken.h>

@class PKShippingMethod;

// PKPayment represents the result of a payment request.  Successful payments
// have a PKPaymentToken which contains a payment credential encrypted to the merchant
// identifier specified in the request, and when requested, the user's shipping address
// and chosen shipping method.
NS_CLASS_AVAILABLE(NA, 8_0)
@interface PKPayment : NSObject

// A PKPaymentToken which contains an encrypted payment credential.
@property (nonatomic, readonly) PKPaymentToken *token;

// The full billing address that the user selected for this transaction.  Fields are
// constrained to those specified in the requiredBillingAddressFields property of the original
// PKPaymentRequest object.  This property is only set when the application has set
// the requiredBillingAddressFields property of the PKPaymentRequest.
@property (nonatomic, readonly) ABRecordRef billingAddress;

// The full shipping address that the user selected for this transaction.  Fields are
// constrained to those specified in the requiredShippingAddressFields property of the original
// PKPaymentRequest object.  This property is only set when the application has set
// the requiredShippingAddressFields property of the PKPaymentRequest.
@property (nonatomic, readonly) ABRecordRef shippingAddress;

// The shipping method that the user chose.  This property is only set when the
// application has set the shippingMethods property of the PKPaymentRequest.
@property (nonatomic, readonly) PKShippingMethod *shippingMethod;

@end
