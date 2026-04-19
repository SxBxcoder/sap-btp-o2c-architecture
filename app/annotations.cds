using VayuO2CService as service from '../srv/service';

annotate service.SalesOrders with @(
  UI.SelectionFields: [ OrderID, Customer_CustomerID, Status, ReqDeliveryDate, Currency ],

  UI.LineItem: [
    { $Type: 'UI.DataField', Value: OrderID,          Label: 'Sales Order',        @UI.Importance: #High   },
    { $Type: 'UI.DataField', Value: CustomerName,     Label: 'Customer',           @UI.Importance: #High   },
    { $Type: 'UI.DataField', Value: ReqDeliveryDate,  Label: 'Req. Delivery Date', @UI.Importance: #Medium },
    { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#GrossValue', Label: 'Gross Value (INR)', @UI.Importance: #High },
    { $Type: 'UI.DataField', Value: TaxAmount,        Label: 'IGST (INR)',         @UI.Importance: #Medium },
    { $Type: 'UI.DataField', Value: Status,           Label: 'Order Status', Criticality: Status, @UI.Importance: #High },
    { $Type: 'UI.DataField', Value: CreditCheckPassed,Label: 'Credit OK',          @UI.Importance: #Medium },
    { $Type: 'UI.DataField', Value: ATPConfirmed,     Label: 'ATP OK',             @UI.Importance: #Medium }
  ],

  UI.HeaderInfo: {
    TypeName:       'Sales Order',
    TypeNamePlural: 'Sales Orders',
    Title:       { $Type: 'UI.DataField', Value: OrderID },
    Description: { $Type: 'UI.DataField', Value: CustomerName }
  },

  UI.HeaderFacets: [
    { $Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#GrossValue', Label: 'Gross Value'   },
    { $Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#NetValue',   Label: 'Net Value'     },
    { $Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#Status',     Label: 'Status'        },
    { $Type: 'UI.ReferenceFacet', Target: '@UI.DataPoint#CreditLimit',Label: 'Credit Limit'  }
  ],

  UI.Facets: [
    { $Type: 'UI.CollectionFacet', ID: 'GeneralInfo', Label: 'General Information',
      Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'OrderDetails',    Target: '@UI.FieldGroup#OrderDetails',    Label: 'Order Details'    },
        { $Type: 'UI.ReferenceFacet', ID: 'CustomerDetails', Target: '@UI.FieldGroup#CustomerDetails', Label: 'Customer Details' }
      ]
    },
    { $Type: 'UI.CollectionFacet', ID: 'PricingTax', Label: 'Pricing & Tax',
      Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'PricingDetails', Target: '@UI.FieldGroup#PricingDetails', Label: 'Pricing Details' }
      ]
    },
    { $Type: 'UI.ReferenceFacet', ID: 'OrderItems',   Target: 'items/@UI.LineItem',    Label: 'Order Items'              },
    { $Type: 'UI.ReferenceFacet', ID: 'DeliveryInfo', Target: 'delivery/@UI.LineItem', Label: 'Delivery & Goods Issue'   }
  ]
);

annotate service.SalesOrders with @(
  UI.DataPoint#GrossValue:  { Value: GrossValue,         Title: 'Gross Value (INR)'  },
  UI.DataPoint#NetValue:    { Value: NetValue,           Title: 'Net Value (INR)'    },
  UI.DataPoint#Status:      { Value: Status,             Title: 'Order Status', Criticality: Status },
  UI.DataPoint#CreditLimit: { Value: CustomerCreditLimit,Title: 'Credit Limit (INR)' },

  UI.FieldGroup#OrderDetails: { Data: [
    { $Type: 'UI.DataField', Value: OrderID,         Label: 'Sales Order ID'    },
    { $Type: 'UI.DataField', Value: OrderType,       Label: 'Order Type'        },
    { $Type: 'UI.DataField', Value: ReqDeliveryDate, Label: 'Req. Delivery Date'},
    { $Type: 'UI.DataField', Value: Status,          Label: 'Order Status'      }
  ]},

  UI.FieldGroup#CustomerDetails: { Data: [
    { $Type: 'UI.DataField', Value: CustomerName,        Label: 'Customer Name' },
    { $Type: 'UI.DataField', Value: CustomerGSTIN,       Label: 'GSTIN'         },
    { $Type: 'UI.DataField', Value: CustomerCreditLimit, Label: 'Credit Limit'  }
  ]},

  UI.FieldGroup#PricingDetails: { Data: [
    { $Type: 'UI.DataField', Value: NetValue,   Label: 'Net Value'   },
    { $Type: 'UI.DataField', Value: TaxAmount,  Label: 'IGST'        },
    { $Type: 'UI.DataField', Value: GrossValue, Label: 'Gross Value' }
  ]}
);

annotate service.SalesOrderItems with @(
  UI.LineItem: [
    { $Type: 'UI.DataField', Value: ItemNumber,          Label: 'Item'     },
    { $Type: 'UI.DataField', Value: MaterialDescription, Label: 'Material' },
    { $Type: 'UI.DataField', Value: Quantity,            Label: 'Qty'      },
    { $Type: 'UI.DataField', Value: NetItemValue,        Label: 'Net Value'}
  ]
);

annotate service.OutboundDeliveries with @(
  UI.LineItem: [
    { $Type: 'UI.DataField', Value: DeliveryID,   Label: 'Delivery ID'    },
    { $Type: 'UI.DataField', Value: ActualGIDate, Label: 'Actual GI Date' },
    { $Type: 'UI.DataField', Value: GIStatus,     Label: 'GI Status'      }
  ]
);
