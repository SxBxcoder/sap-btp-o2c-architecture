using vayu.o2c as db from '../db/schema';

service VayuO2CService @(path: '/odata/v4/o2c') {

  @readonly entity Customers        as projection on db.Customers {
    *, (CreditLimit - CurrentExposure) as CreditHeadroom : Decimal(15,2)
  };

  @readonly entity Materials        as projection on db.Materials;
  @readonly entity Inquiries        as projection on db.Inquiries;
  @readonly entity Quotations       as projection on db.Quotations;
  @readonly entity QuotationItems   as projection on db.QuotationItems;

  entity SalesOrders as projection on db.SalesOrders {
    *,
    Customer.Name            as CustomerName          : String,
    Customer.CreditLimit     as CustomerCreditLimit   : Decimal(15,2),
    Customer.CurrentExposure as CustomerExposure      : Decimal(15,2),
    Customer.GSTIN           as CustomerGSTIN         : String
  };

  entity SalesOrderItems as projection on db.SalesOrderItems {
    *,
    Material.Description    as MaterialDescription : String,
    Material.MovingAvgPrice as MAP                 : Decimal(15,2)
  };

  entity OutboundDeliveries as projection on db.OutboundDeliveries;

  entity BillingDocuments as projection on db.BillingDocuments {
    *,
    Customer.Name  as CustomerName  : String,
    Customer.GSTIN as CustomerGSTIN : String
  };

  entity Payments   as projection on db.Payments;

  @readonly entity GLEntries as projection on db.GLEntries;

  action createInquiry(
    CustomerID    : String(10),
    RequestedDate : Date,
    ValidFrom     : Date,
    ValidTo       : Date,
    Notes         : String(500)
  ) returns Inquiries;

  action createQuotation(
    InquiryID  : String(10),
    MaterialID : String(18),
    Quantity   : Decimal(13,3),
    ValidFrom  : Date,
    ValidTo    : Date
  ) returns Quotations;

  action createSalesOrder(
    QuotationID     : String(10),
    ReqDeliveryDate : Date
  ) returns SalesOrders;

  action createDelivery(
    OrderID       : String(10),
    PlannedGIDate : Date
  ) returns OutboundDeliveries;

  action confirmPGI(
    DeliveryID : String(10)
  ) returns OutboundDeliveries;

  action createInvoice(
    DeliveryID : String(10)
  ) returns BillingDocuments;

  action postPayment(
    BillingID      : String(10),
    AmountReceived : Decimal(15,2),
    PaymentDate    : Date
  ) returns Payments;

  function getCreditStatus(CustomerID : String(10)) returns {
    CustomerID      : String(10);
    CustomerName    : String(100);
    CreditLimit     : Decimal(15,2);
    CurrentExposure : Decimal(15,2);
    CreditHeadroom  : Decimal(15,2);
    RiskStatus      : String(20);
  };

  function getO2CSummary(OrderID : String(10)) returns {
    OrderID      : String(10);
    CustomerName : String(100);
    NetValue     : Decimal(15,2);
    GrossValue   : Decimal(15,2);
    OrderStatus  : String(20);
    DeliveryID   : String(10);
    GIStatus     : String(20);
    BillingID    : String(10);
    ARStatus     : String(20);
    PaymentID    : String(10);
    ARCleared    : Boolean;
  };
}
