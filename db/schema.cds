namespace vayu.o2c;
using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

entity Customers : managed {
  key CustomerID        : String(10);
      Name              : String(100) @mandatory;
      City              : String(60);
      Region            : String(60);
      Country           : String(3) default 'IN';
      GSTIN             : String(15);
      AccountGroup      : String(4) default 'KUNA';
      SalesOrg          : String(4) default 'VD01';
      DistChannel       : String(2) default '10';
      Division          : String(2) default 'DR';
      Incoterms         : String(3) default 'CIF';
      PaymentTerms      : String(4) default 'ZN30';
      CreditControlArea : String(4) default 'VAYU';
      CreditLimit       : Decimal(15,2);
      CurrentExposure   : Decimal(15,2) default 0;
      ReconciliationGL  : String(10) default '140000';
      CreditHeadroom    : Decimal(15,2);
      orders            : Association to many SalesOrders on orders.Customer = $self;
}

entity Materials : managed {
  key MaterialID        : String(18);
      Description       : String(200) @mandatory;
      MaterialType      : String(4) default 'FERT';
      IndustrySector    : String(1) default 'M';
      BaseUOM           : String(3) default 'EA';
      Plant             : String(4) default 'VDP1';
      StorageLocation   : String(4) default 'SL01';
      ValuationClass    : String(4) default '7920';
      MovingAvgPrice    : Decimal(15,2);
      UnrestrictedStock : Decimal(13,3) default 0;
      MinOrderQty       : Decimal(13,3) default 1;
      LoadingGroup      : String(4) default '0001';
}

entity Inquiries : managed {
  key InquiryID         : String(10);
      Customer          : Association to Customers;
      SalesOrg          : String(4) default 'VD01';
      DistChannel       : String(2) default '10';
      Division          : String(2) default 'DR';
      RequestedDate     : Date;
      ValidFrom         : Date;
      ValidTo           : Date;
      Status            : String(20) default 'OPEN';
      Notes             : String(500);
      quotation         : Association to one Quotations on quotation.Inquiry = $self;
}

entity Quotations : managed {
  key QuotationID       : String(10);
      Inquiry           : Association to Inquiries;
      Customer          : Association to Customers;
      ValidFrom         : Date;
      ValidTo           : Date;
      NetValue          : Decimal(15,2);
      GrossValue        : Decimal(15,2);
      TaxAmount         : Decimal(15,2);
      Currency          : String(3) default 'INR';
      Status            : String(20) default 'OPEN';
      salesOrder        : Association to one SalesOrders on salesOrder.Quotation = $self;
      items             : Composition of many QuotationItems on items.Quotation = $self;
}

entity QuotationItems : managed {
  key ItemID            : UUID;
      Quotation         : Association to Quotations;
      Material          : Association to Materials;
      Quantity          : Decimal(13,3);
      UOM               : String(3) default 'EA';
      BasePrice         : Decimal(15,2);
      DiscountPct       : Decimal(5,2) default 0;
      FreightAmount     : Decimal(15,2) default 0;
      TaxRate           : Decimal(5,2) default 18;
      TaxAmount         : Decimal(15,2);
      NetItemValue      : Decimal(15,2);
      GrossItemValue    : Decimal(15,2);
}

entity SalesOrders : managed {
  key OrderID           : String(10);
      Quotation         : Association to Quotations;
      Customer          : Association to Customers @mandatory;
      OrderType         : String(4) default 'OR';
      SalesOrg          : String(4) default 'VD01';
      DistChannel       : String(2) default '10';
      Division          : String(2) default 'DR';
      ReqDeliveryDate   : Date;
      NetValue          : Decimal(15,2);
      GrossValue        : Decimal(15,2);
      TaxAmount         : Decimal(15,2);
      Currency          : String(3) default 'INR';
      PricingProcedure  : String(6) default 'ZVDTPR';
      CreditCheckPassed : Boolean default false;
      ATPConfirmed      : Boolean default false;
      Status            : String(20) default 'OPEN';
      items             : Composition of many SalesOrderItems on items.Order = $self;
      delivery          : Association to one OutboundDeliveries on delivery.Order = $self;
}

entity SalesOrderItems : managed {
  key ItemID            : UUID;
      Order             : Association to SalesOrders;
      Material          : Association to Materials @mandatory;
      ItemNumber        : String(6);
      Quantity          : Decimal(13,3);
      ConfirmedQty      : Decimal(13,3) default 0;
      UOM               : String(3) default 'EA';
      Plant             : String(4) default 'VDP1';
      BasePrice         : Decimal(15,2);
      DiscountPct       : Decimal(5,2) default 0;
      FreightAmount     : Decimal(15,2) default 0;
      TaxRate           : Decimal(5,2) default 18;
      TaxAmount         : Decimal(15,2);
      NetItemValue      : Decimal(15,2);
      GrossItemValue    : Decimal(15,2);
}

entity OutboundDeliveries : managed {
  key DeliveryID        : String(10);
      Order             : Association to SalesOrders;
      ShippingPoint     : String(4) default 'SP01';
      ShipToParty       : String(10);
      PlannedGIDate     : Date;
      ActualGIDate      : Date;
      GIStatus          : String(20) default 'PENDING';
      DeliveryQty       : Decimal(13,3);
      Plant             : String(4) default 'VDP1';
      StorageLocation   : String(4) default 'SL01';
      billing           : Association to one BillingDocuments on billing.Delivery = $self;
}

entity BillingDocuments : managed {
  key BillingID         : String(10);
      Delivery          : Association to OutboundDeliveries;
      BillingType       : String(4) default 'F2';
      BillingDate       : Date;
      Customer          : Association to Customers;
      NetAmount         : Decimal(15,2);
      TaxAmount         : Decimal(15,2);
      GrossAmount       : Decimal(15,2);
      Currency          : String(3) default 'INR';
      ARStatus          : String(20) default 'OPEN';
      ARGLAccount       : String(10) default '140000';
      RevenueGLAccount  : String(10) default '800000';
      TaxGLAccount      : String(10) default '220100';
      FIDocumentNumber  : String(10);
      payment           : Association to one Payments on payment.Billing = $self;
}

entity Payments : managed {
  key PaymentID         : String(10);
      Billing           : Association to BillingDocuments;
      Customer          : Association to Customers;
      PaymentDate       : Date;
      AmountReceived    : Decimal(15,2);
      Currency          : String(3) default 'INR';
      BankGLAccount     : String(10) default '113000';
      ARGLAccount       : String(10) default '140000';
      ARClearedFlag     : Boolean default false;
      ClearingDocument  : String(10);
}

entity GLEntries : managed {
  key EntryID           : UUID;
      DocumentNumber    : String(10);
      DocumentType      : String(4);
      PostingDate       : Date;
      GLAccount         : String(10);
      AccountDescription: String(100);
      DebitAmount       : Decimal(15,2) default 0;
      CreditAmount      : Decimal(15,2) default 0;
      Currency          : String(3) default 'INR';
      AssignmentRef     : String(20);
      Narration         : String(200);
}