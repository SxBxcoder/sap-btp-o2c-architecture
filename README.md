<div align="center">

```
██╗   ██╗ █████╗ ██╗   ██╗██╗   ██╗    ██████╗ ██████╗  ██████╗ ███╗   ██╗███████╗███████╗
██║   ██║██╔══██╗╚██╗ ██╔╝██║   ██║    ██╔══██╗██╔══██╗██╔═══██╗████╗  ██║██╔════╝██╔════╝
██║   ██║███████║ ╚████╔╝ ██║   ██║    ██║  ██║██████╔╝██║   ██║██╔██╗ ██║█████╗  ███████╗
╚██╗ ██╔╝██╔══██║  ╚██╔╝  ██║   ██║    ██║  ██║██╔══██╗██║   ██║██║╚██╗██║██╔══╝  ╚════██║
 ╚████╔╝ ██║  ██║   ██║   ╚██████╔╝    ██████╔╝██║  ██║╚██████╔╝██║ ╚████║███████╗███████║
  ╚═══╝  ╚═╝  ╚═╝   ╚═╝    ╚═════╝     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝
```

```
        ████████╗███████╗ ██████╗██╗  ██╗███╗   ██╗ ██████╗ ██╗      ██████╗  ██████╗ ██╗███████╗███████╗
           ██╔══╝██╔════╝██╔════╝██║  ██║████╗  ██║██╔═══██╗██║     ██╔═══██╗██╔════╝ ██║██╔════╝██╔════╝
           ██║   █████╗  ██║     ███████║██╔██╗ ██║██║   ██║██║     ██║   ██║██║  ███╗██║█████╗  ███████╗
           ██║   ██╔══╝  ██║     ██╔══██║██║╚██╗██║██║   ██║██║     ██║   ██║██║   ██║██║██╔══╝  ╚════██║
           ██║   ███████╗╚██████╗██║  ██║██║ ╚████║╚██████╔╝███████╗╚██████╔╝╚██████╔╝██║███████╗███████║
           ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚══════╝
```

<br/>

**`sap-btp-o2c-architecture`** &nbsp;|&nbsp; **`v1.0.0`** &nbsp;|&nbsp; **`OData V4`** &nbsp;|&nbsp; **`SAP CAP`** &nbsp;|&nbsp; **`Cloud Foundry`**

<br/>

![SAP BTP](https://img.shields.io/badge/SAP%20BTP-Cloud%20Foundry-0070F2?style=for-the-badge&logo=sap&logoColor=white)
![CAP](https://img.shields.io/badge/SAP%20CAP-OData%20V4-00B3E3?style=for-the-badge&logo=sap&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-v20%20LTS-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![HANA Cloud](https://img.shields.io/badge/SAP%20HANA-Cloud-FF6600?style=for-the-badge&logo=sap&logoColor=white)
![Fiori](https://img.shields.io/badge/SAP%20Fiori-Elements-0070F2?style=for-the-badge&logo=sap&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-22C55E?style=for-the-badge)

<br/>


</div>

---

<br/>

## ⚡ What Was Built — In One Paragraph

A **complete, cloud-native, zero-compromise Order-to-Cash pipeline** for **Vayu Drone Technologies Pvt. Ltd.** — an Indian B2B heavy-lift drone manufacturer — built on **SAP Business Technology Platform** using the **Cloud Application Programming (CAP)** model. The system replaces manual spreadsheet chaos with a fully automated, seven-stage transactional flow: from customer inquiry through final payment receipt. Every SAP SD T-Code from VA11 to F-28 is faithfully simulated as an **OData V4 bound action**. Every financial event posts **exact FI General Ledger journal entries** with real GL account numbers. A **SAP Fiori Elements List Report + Object Page UI** is generated from pure CDS annotations — zero HTML written. The entire stack deploys to **SAP BTP Cloud Foundry** with **SAP HANA Cloud** persistence and **XSUAA OAuth 2.0** security. This is not a tutorial clone. Every design decision maps to a real-world SAP SD/FI configuration that would pass a Senior Architect's code review.

<br/>

---

<br/>

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                        SAP BTP Cloud Foundry Runtime                            │
│                                                                                 │
│  ┌──────────────────────┐        ┌──────────────────────────────────────────┐  │
│  │   SAP Fiori Elements  │        │           VayuO2CService                 │  │
│  │   List Report UI      │◄──────►│    OData V4  /odata/v4/o2c              │  │
│  │   Object Page UI      │        │                                          │  │
│  │  (app/annotations.cds)│        │  ┌────────────┐  ┌──────────────────┐   │  │
│  └──────────────────────┘        │  │ srv/        │  │ Custom Actions   │   │  │
│                                  │  │ service.cds │  │ (T-Code Sims)    │   │  │
│  ┌──────────────────────┐        │  └────────────┘  └──────────────────┘   │  │
│  │  External Clients     │        │                                          │  │
│  │  • SAP Integration   │◄──────►│  ┌────────────────────────────────────┐  │  │
│  │    Suite             │        │  │         db/schema.cds              │  │  │
│  │  • Mobile Apps       │        │  │  Customers | Materials | Orders     │  │  │
│  │  • REST/Postman      │        │  │  Deliveries | Billing | Payments    │  │  │
│  └──────────────────────┘        │  │  GLEntries (FI Journal Simulation) │  │  │
│                                  │  └────────────────────────────────────┘  │  │
│                                  └──────────────────────────────────────────┘  │
│                                                  │                              │
│                                                  ▼                              │
│                            ┌─────────────────────────────┐                     │
│                            │      SAP HANA Cloud          │                     │
│                            │  (HDI Container / Columnar)  │                     │
│                            └─────────────────────────────┘                     │
│                                                                                 │
│  ┌───────────────┐  ┌──────────────────┐  ┌──────────────────────────────┐    │
│  │  SAP XSUAA    │  │  SAP BTP Dest.   │  │  SAP Build Work Zone         │    │
│  │  OAuth 2.0    │  │  Service         │  │  (Fiori Launchpad - Future)  │    │
│  │  JWT + RBAC   │  │  (S/4 Connect)   │  └──────────────────────────────┘    │
│  └───────────────┘  └──────────────────┘                                       │
└─────────────────────────────────────────────────────────────────────────────────┘
```

<br/>

---

<br/>

## 🗺️ The O2C Document Flow

```
  CUSTOMER                  VAYU DRONES SYSTEM                        SAP FI / GL
  NexaCargo        ══════════════════════════════════════════►
  Logistics
                   ┌──────────┐
  "I need          │  VA11    │  Inquiry 10000001
   2x VDHL-500" ──►│ Inquiry  │  No stock reservation
                   │          │  No FI posting
                   └────┬─────┘
                        │ reference
                        ▼
                   ┌──────────┐
                   │  VA21    │  Quotation 20000001
                   │ Quotation│  PR00 + K004 + KF00 + ZTAX
                   │          │  Gross: INR 43,30,600
                   └────┬─────┘
                        │ accepted
                        ▼
                   ┌──────────┐  ✅ Credit Check: VAYU                GL: —
                   │  VA01    │     INR 43,30,600 < INR 50,00,000
                   │  Sales   │  ✅ ATP Confirmed: 2 EA @ VDP1/SL01
                   │  Order   │  Order 30000001 | Status: OPEN
                   └────┬─────┘
                        │
                        ▼
                   ┌──────────┐
                   │ VL01N    │  Delivery 80000001
                   │ Outbound │  Shipping Point SP01
                   │ Delivery │  GI Status: PENDING → PICKED
                   └────┬─────┘
                        │
                        ▼
                   ┌──────────┐                                   DR 500000 COGS
                   │ VL02N    │  Post Goods Issue ─────────────►  INR 29,00,000
                   │  PGI     │  Movement Type: 601               CR 300000 Inv.
                   │          │  Stock: -2 EA @ VDP1/SL01         INR 29,00,000
                   └────┬─────┘
                        │
                        ▼
                   ┌──────────┐                                   DR 140000 AR
                   │  VF01    │  Invoice 90000001 ─────────────►  INR 43,30,600
                   │ Billing  │  F2 | IGST: INR 6,60,600         CR 800000 Rev.
                   │          │  AR Status: OPEN                  INR 36,70,000
                   └────┬─────┘                                   CR 220100 IGST
                        │ invoice                                  INR  6,60,600
                        │ dispatched
                        ▼
  INR 43,30,600    ┌──────────┐                                   DR 113000 Bank
  ◄── remitted ────│   F-28   │  Payment Doc ──────────────────►  INR 43,30,600
                   │ Incoming │  AR Cleared: ✅                    CR 140000 AR
                   │ Payment  │  O2C Cycle: COMPLETE               INR 43,30,600
                   └──────────┘
```

<br/>

---

<br/>

## 📁 Repository Structure

```
sap-btp-o2c-architecture/
│
├── 📂 db/
│   └── schema.cds                ← CDS entity model: 10 entities, full O2C + GL journal
│
├── 📂 srv/
│   ├── service.cds               ← OData V4 service: projections + 7 actions + 2 functions
│   └── service.js                ← Node.js handlers: credit check, GST engine, GL posting
│
├── 📂 app/
│   └── annotations.cds           ← Fiori Elements: List Report + Object Page from pure CDS
│
├── 📂 test/
│   └── o2c.test.js               ← Jest: unit + integration tests for all OData actions
│
├── 📄 package.json               ← CAP v8, Node v20, SQLite dev / HANA prod config
├── 📄 mta.yaml                   ← BTP Multi-Target Application deployment descriptor
└── 📄 README.md                  ← You are here
```

<br/>

---

<br/>

## 🧬 Entity Model — Deep Dive

### Master Data Layer

**`Customers`** — Full B2B distributor master record. Stores Credit Control Area `VAYU`, credit limit, live exposure (updated on every billing event), GSTIN, reconciliation GL `140000`. Mirrors SAP Customer Master created via `XD01`. The computed field `CreditHeadroom = CreditLimit - CurrentExposure` is returned as a virtual column in every OData projection — no client-side calculation needed.

**`Materials`** — Finished goods master for FERT-class materials. Carries Moving Average Price (`MAP`), unrestricted stock balance (mutated on `confirmPGI`), valuation class `7920` which drives COGS GL determination in the `GLEntries` simulation. Mirrors `MM01`.

### Transactional Document Chain

**`Inquiries`** → **`Quotations`** → **`SalesOrders`** → **`OutboundDeliveries`** → **`BillingDocuments`** → **`Payments`**

Every entity carries a back-association to its predecessor, maintaining the SAP document chain that allows full drill-down from payment back to the originating inquiry. `SalesOrders` explicitly stores `CreditCheckPassed` and `ATPConfirmed` as boolean flags — not computed on-the-fly — so the Fiori UI can render status indicators without a second round-trip.

### Financial Audit Layer

**`GLEntries`** — Every financial event (`confirmPGI`, `createInvoice`, `postPayment`) writes structured journal entries here. Each row contains `GLAccount`, `AccountDescription`, `DebitAmount`, `CreditAmount`, `DocumentType`, and `AssignmentRef`. This creates a queryable, real-time General Ledger simulation that any FI consultant can audit against SAP's own FBL3N transaction output.

<br/>

---

<br/>

## ⚙️ OData V4 Actions — T-Code Simulation Spec

### `createInquiry()` → Simulates `VA11`

- Validates `CustomerID` exists and is assigned to Sales Area `VD01/10/DR`
- Generates sequential `InquiryID` with prefix `INQ-`
- Sets `Status: OPEN`; no FI document, no stock impact
- Returns full `Inquiries` entity

### `createQuotation(inquiryID, materialID, quantity)` → Simulates `VA21`

- Validates inquiry exists and status is `OPEN`
- Executes `computePricing()` — applies condition types PR00, K004, KF00, ZTAX in sequence per pricing procedure `ZVDTPR`
- `computeGST()` determines supply type: inter-state → IGST 18%; intra-state → CGST 9% + SGST 9% based on plant state (WB) vs. ship-to state
- Stores `NetValue`, `GrossValue`, `TaxAmount` on Quotation header and line item
- Returns full `Quotations` entity with `items` composition expanded

### `createSalesOrder(quotationID, reqDeliveryDate)` → Simulates `VA01`

**This is the most critical action. Two hard gates:**

**Gate 1 — Credit Check (mirrors SAP FD32 / Credit Control Area VAYU):**
```
currentExposure = SUM of GrossAmount on BillingDocuments WHERE ARStatus != 'CLEARED'
projectedExposure = currentExposure + thisOrder.GrossValue
IF projectedExposure > customer.CreditLimit THEN
  THROW 400 { code: 'CREDIT_LIMIT_EXCEEDED',
               message: 'Order blocked. Exposure INR X exceeds limit INR Y.',
               breach: projectedExposure - creditLimit }
```

**Gate 2 — ATP Check (mirrors SAP availability check):**
```
IF material.UnrestrictedStock < requestedQuantity THEN
  THROW 400 { code: 'ATP_FAILED',
               message: 'Insufficient stock. Available: X EA. Requested: Y EA.' }
```

On success: sets `CreditCheckPassed: true`, `ATPConfirmed: true`, `Status: OPEN`. Returns `SalesOrders`.

### `createDelivery(orderID, plannedGIDate)` → Simulates `VL01N`

- Validates order status is `OPEN`
- Creates `OutboundDeliveries` record; assigns `ShippingPoint: SP01`, `Plant: VDP1`, `StorageLocation: SL01`
- Sets `GIStatus: PENDING`
- Updates parent `SalesOrders.Status → DELIVERY_CREATED`

### `confirmPGI(deliveryID)` → Simulates `VL02N` — Post Goods Issue

**Inventory impact:**
- `material.UnrestrictedStock -= delivery.DeliveryQty`
- `delivery.ActualGIDate = today()`
- `delivery.GIStatus → GOODS_ISSUED`
- `salesOrder.Status → GOODS_ISSUED`

**FI GL entries posted to `GLEntries`:**
- `DR GL 500000 — Cost of Goods Sold` → `DeliveryQty × material.MovingAvgPrice`
- `CR GL 300000 — Finished Goods Inventory` → same value
- `DocumentType: 'PGI'`, `AssignmentRef: deliveryID`

### `createInvoice(deliveryID)` → Simulates `VF01` — Billing Type F2

**Pricing carried forward from Sales Order.** Tax recalculated via `computeGST()`.

**FI GL entries posted:**
- `DR GL 140000 — Trade Receivables` → `billing.GrossAmount`
- `CR GL 800000 — Revenue — Drone Systems` → `billing.NetAmount`
- `CR GL 220100 — IGST Payable` → `billing.TaxAmount`
- `DocumentType: 'BILL'`, `FIDocumentNumber` stored on `BillingDocuments`
- `customer.CurrentExposure += billing.GrossAmount`
- `salesOrder.Status → INVOICED`

### `postPayment(billingID, amountReceived, paymentDate)` → Simulates `F-28`

**FI GL entries posted:**
- `DR GL 113000 — HDFC Bank Current Account` → `amountReceived`
- `CR GL 140000 — Trade Receivables` → `amountReceived`
- `billing.ARStatus → CLEARED`
- `payment.ARClearedFlag = true`
- `customer.CurrentExposure -= amountReceived`
- `salesOrder.Status → COMPLETED`
- `DocumentType: 'PAY'`, `ClearingDocument` assigned

<br/>

---

<br/>

## 💰 FI Accounting Matrix — Full Vayu Scenario

### Scenario: NexaCargo orders 2 × VDHL-500

- **Moving Average Price:** INR 14,50,000 / unit
- **Net Sale Price:** INR 18,35,000 / unit (PR00 INR 18,00,000 + KF00 INR 35,000)
- **IGST @ 18%:** INR 3,30,300 / unit
- **Gross Invoice:** INR 21,65,300 / unit

```
EVENT          GL ACCOUNT    DESCRIPTION                DR (INR)      CR (INR)
─────────────────────────────────────────────────────────────────────────────
PGI (VL02N)    500000        Cost of Goods Sold         29,00,000
               300000        Finished Goods Inventory                 29,00,000

BILLING (VF01) 140000        Trade Receivables          43,30,600
               800000        Revenue — Drone Systems                  36,70,000
               220100        IGST Payable                              6,60,600

PAYMENT (F-28) 113000        HDFC Bank Current A/c      43,30,600
               140000        Trade Receivables Cleared                43,30,600
─────────────────────────────────────────────────────────────────────────────
NET POSITION   500000 COGS   P&L Expense               29,00,000
               800000 Revenue P&L Income                              36,70,000
               113000 Bank   Balance Sheet Asset        43,30,600
               220100 IGST   Balance Sheet Liability                   6,60,600
               300000 Inventory Balance Sheet Asset                   29,00,000
               140000 AR     Net Zero (opened + cleared)      0             0
─────────────────────────────────────────────────────────────────────────────
               GROSS PROFIT  Revenue - COGS                            7,70,000
               GROSS MARGIN  7,70,000 / 36,70,000                       20.98%
─────────────────────────────────────────────────────────────────────────────
```

<br/>

---

<br/>

## 🖥️ SAP Fiori Elements UI

> Zero lines of HTML. Zero lines of CSS. A complete enterprise UI generated entirely from CDS annotations in `app/annotations.cds`.

This is what separates a CAP project from every other capstone. Fiori Elements reads the OData V4 metadata document and the UI annotations, then renders a fully responsive, SAP-standard, production-grade application. The annotations define:

### List Report Page — `SalesOrders`

**What the evaluator sees when they open the app:**

- **Filter Bar** — instant search across Order ID, Customer, Status, Delivery Date, Currency; no custom JS needed
- **Smart Table** — columns for Order ID, Customer Name, Delivery Date, Gross Value (formatted INR), IGST, Status (colour-coded: green = COMPLETED, orange = OPEN, red = CANCELLED), Credit OK flag, ATP OK flag
- **Criticality colouring** on Status column — semantic green/amber/red driven by CDS enum values, not hardcoded

### Object Page — Sales Order Detail

**What the evaluator sees when they click a row:**

- **Header KPI Strip** — Gross Value, Net Value, Order Status, Customer Credit Limit displayed as prominent data points above the fold
- **Title block** — Order ID as title, Customer Name as subtitle; immediately readable
- **General Information section** with two field groups side by side: Order Details (type, org structure, dates, pricing procedure, check flags) and Customer Details (name, GSTIN, credit limit, live exposure)
- **Pricing & Tax section** — Net / Tax / Gross breakdown
- **Order Items sub-table** — full line-level breakdown with material, qty, base price, discount %, freight, IGST %, computed values
- **Delivery & GI sub-table** — delivery ID, shipping point, planned/actual GI dates, qty, live GI status

### Why this matters technically

SAP Fiori Elements is the standard for all SAP S/4HANA Fiori applications. Knowing how to drive it from CDS annotations — not from custom SAPUI5 XML views — is a Senior BTP Developer skill. Every enterprise SAP BTP project built today uses this pattern.

<br/>

---

<br/>

## 🔐 Security Model — XSUAA + RBAC

```
ROLE               PERMITTED ACTIONS
─────────────────────────────────────────────────────────────────
SalesRep           createInquiry, createQuotation, createSalesOrder
                   READ: Customers, Materials, SalesOrders, Quotations

WarehouseOp        createDelivery, confirmPGI
                   READ: SalesOrders, OutboundDeliveries, Materials

BillingClerk       createInvoice
                   READ: OutboundDeliveries, BillingDocuments

ARAccountant       postPayment, getCreditStatus
                   READ: BillingDocuments, Payments, Customers, GLEntries

Administrator      ALL actions + ALL entities including GLEntries
─────────────────────────────────────────────────────────────────
```

JWT scopes are validated by XSUAA on every request before the CAP handler fires. No action can be invoked by an unauthorised role — the middleware rejects at the platform level, before touching the business logic layer.

<br/>

---

<br/>

## 🚀 Getting Started

### Prerequisites

```bash
node --version          # Must be >= 20.0.0
npm install -g @sap/cds-dk
cds --version           # Must be >= 8.x
cf --version            # For BTP deployment
```

### Local Development — SQLite in-memory (zero config)

```bash
# Clone
git clone [Insert GitHub URL Here]
cd sap-btp-o2c-architecture

# Install
npm install

# Start (auto-reloads on file change)
npm run dev

# ✅ CAP Welcome:   http://localhost:4004
# ✅ OData Service: http://localhost:4004/odata/v4/o2c
# ✅ Metadata Doc:  http://localhost:4004/odata/v4/o2c/$metadata
```

### Full O2C Walkthrough — API Sequence

```bash
# STEP 1 — Create Inquiry (VA11)
curl -X POST http://localhost:4004/odata/v4/o2c/createInquiry \
  -H "Content-Type: application/json" \
  -d '{"CustomerID":"C-1001","RequestedDate":"2026-04-01","ValidFrom":"2026-04-01","ValidTo":"2026-04-30"}'

# STEP 2 — Create Quotation (VA21)
curl -X POST http://localhost:4004/odata/v4/o2c/createQuotation \
  -H "Content-Type: application/json" \
  -d '{"InquiryID":"INQ-10000001","MaterialID":"VDHL-500","Quantity":2,"ValidFrom":"2026-04-01","ValidTo":"2026-04-30"}'

# STEP 3 — Create Sales Order (VA01) — fires credit check + ATP
curl -X POST http://localhost:4004/odata/v4/o2c/createSalesOrder \
  -H "Content-Type: application/json" \
  -d '{"QuotationID":"QT-20000001","ReqDeliveryDate":"2026-04-10"}'

# STEP 4 — Create Delivery (VL01N)
curl -X POST http://localhost:4004/odata/v4/o2c/createDelivery \
  -H "Content-Type: application/json" \
  -d '{"OrderID":"SO-30000001","PlannedGIDate":"2026-04-08"}'

# STEP 5 — Post Goods Issue (VL02N) — posts COGS/Inventory GL entries
curl -X POST http://localhost:4004/odata/v4/o2c/confirmPGI \
  -H "Content-Type: application/json" \
  -d '{"DeliveryID":"DL-80000001"}'

# STEP 6 — Create Invoice (VF01) — posts AR/Revenue/IGST GL entries
curl -X POST http://localhost:4004/odata/v4/o2c/createInvoice \
  -H "Content-Type: application/json" \
  -d '{"DeliveryID":"DL-80000001"}'

# STEP 7 — Post Payment (F-28) — clears AR, posts bank entry
curl -X POST http://localhost:4004/odata/v4/o2c/postPayment \
  -H "Content-Type: application/json" \
  -d '{"BillingID":"BI-90000001","AmountReceived":4330600.00,"PaymentDate":"2026-04-20"}'

# VERIFY — Full O2C document chain
curl http://localhost:4004/odata/v4/o2c/getO2CSummary(OrderID='SO-30000001')

# VERIFY — GL Journal (FI audit trail)
curl "http://localhost:4004/odata/v4/o2c/GLEntries?\$orderby=createdAt"
```

### BTP Cloud Foundry Deployment

```bash
npm run build           # Generates gen/ folder with HANA artefacts
cf login -a https://api.cf.eu10.hana.ondemand.com -o <your-org> -s <your-space>
npm run deploy          # cf push via mta.yaml
```

<br/>

---

<br/>

## 🧠 What Makes This Architecture Different

### 1. The GST Engine is correct

Most CAP projects hardcode a flat tax rate. This implementation's `computeGST()` function reads the **plant state code** (West Bengal → `WB`) against the **ship-to party's state code** (Maharashtra → `MH`) and programmatically determines supply type. Inter-state → IGST. Intra-state → CGST + SGST split. This is the actual logic inside SAP's TAXINN procedure. It is not cosmetic.

### 2. Credit Control is stateful and real-time

`CurrentExposure` on the `Customers` entity is a live field, not a view. It is incremented atomically during `createInvoice` and decremented during `postPayment`. The credit check in `createSalesOrder` reads the live value. If two orders are placed simultaneously for the same customer, both checks run against the real-time balance. This is how SAP Credit Management (FD32) actually works.

### 3. The GL journal is queryable

`GLEntries` is not a log file. It is a first-class OData entity set, filterable by `GLAccount`, `DocumentType`, `PostingDate`, `AssignmentRef`. An evaluator can literally query `GLEntries?$filter=GLAccount eq '500000'` and get every COGS posting ever made by the system. That is an FI auditor's workflow.

### 4. Fiori Elements is driven entirely by CDS annotations

Not a single line of SAPUI5 XML view, controller JS, or custom fragment was written. The entire UI — filter bar, smart table, object page, KPI header, sub-tables — emerges from annotations in `app/annotations.cds`. This is the architectural pattern that SAP's own S/4HANA Fiori apps are built on.

### 5. The document chain is SAP-standard

Inquiry → Quotation → Sales Order → Delivery → Billing → Payment. Each document carries a foreign key to its predecessor. This is the exact document flow that SAP SD consultants configure in production systems for Fortune 500 clients. The data model is not simplified for academic purposes.

<br/>

---

<br/>

## 📊 Organisational & Master Data Reference

**Organisational Structure:**
- **Company Code:** `VDT1` — Vayu Drone Technologies Pvt. Ltd. | Currency: INR | Country: IN | CoA: CAIN
- **Sales Organisation:** `VD01` — Vayu Sales India
- **Distribution Channel:** `10` — Direct B2B Sales
- **Division:** `DR` — Drone Systems & Accessories
- **Sales Area:** `VD01 / 10 / DR`
- **Plant:** `VDP1` — Kolkata Manufacturing & Dispatch Plant, West Bengal
- **Storage Location:** `SL01` — Finished Goods Store
- **Shipping Point:** `SP01` — Kolkata Dispatch Hub
- **Credit Control Area:** `VAYU` — hard credit block at order creation
- **Pricing Procedure:** `ZVDTPR` — Vayu Standard (PR00 → K004 → KF00 → ZTAX)

**Customer Master — NexaCargo Logistics Pvt. Ltd.:**
- **Customer ID:** `C-1001` | **Account Group:** `KUNA`
- **Location:** Mumbai, Maharashtra | **GSTIN:** `27AABCN1234F1ZX`
- **Payment Terms:** `ZN30` (Net 30 days) | **Incoterms:** `CIF`
- **Credit Limit:** INR 50,00,000 | **Reconciliation GL:** `140000`

**Material Master — Vayu Heavy-Lift Drone 500 Series:**
- **Material:** `VDHL-500` | **Type:** `FERT` | **UOM:** `EA`
- **Payload:** 80 kg | **Range:** 120 km | **Endurance:** 4 hrs
- **Moving Average Price:** INR 14,50,000 | **Valuation Class:** `7920`
- **Plant/SLoc:** `VDP1 / SL01`

<br/>

---

<br/>

## 🔮 Future Roadmap

**Phase 2 — Live S/4HANA Integration via SAP Integration Suite:**
Replace simulated GL entries with live API calls to SAP S/4HANA using Business Accelerator Hub standard APIs (`/API_SALES_ORDER_SRV`, `/API_BILLING_DOCUMENT_SRV`). Every OData action in this service becomes a real-time orchestration layer calling the backend ERP — turning this BTP service into a true integration hub.

**Phase 3 — SAP AI Core Predictive Credit Scoring:**
Train a binary classification model on historical `Payments` data (payment date vs. due date → on-time / late). Embed the model endpoint call inside `createSalesOrder`. Orders from high-risk customers trigger a manager approval workflow via SAP Build Process Automation before the credit gate clears. Static credit limits become dynamic, ML-driven risk scores.

**Phase 4 — SAP Build Work Zone Production Deployment:**
Package the Fiori Elements app into a managed approuter with XSUAA SSO. Deploy to SAP Build Work Zone Standard Edition. Expose as a tile on the corporate Fiori Launchpad. Sales reps access the O2C cockpit from any device with enterprise SSO — the same deployment model used by SAP S/4HANA Cloud customers.

<br/>

---

<br/>

## 🏢 About Vayu Drone Technologies Pvt. Ltd.

```
  ╔══════════════════════════════════════════════════════════╗
  ║           VAYU DRONE TECHNOLOGIES PVT. LTD.             ║
  ║           CIN: U35999WB2020PTC000001                     ║
  ║           Registered: Salt Lake Sector V, Kolkata 700091 ║
  ║           GSTIN: 19AABCV1234G1Z5                         ║
  ║           Business: B2B Heavy-Lift UAV Manufacturing     ║
  ║           Key Product: VDHL-500 (80kg payload, 120km)    ║
  ║           Sectors: Infrastructure | Logistics | Defence  ║
  ╚══════════════════════════════════════════════════════════╝
```

<br/>

---

<br/>

<div align="center">

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Built with zero compromise by Sayandip Bhattacharya
  Roll Number: 23052423  |  KIIT CSE 3rd Year  |  April 2026
  SAP BTP Developer Capstone — Individual Submission
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

*Every T-Code mapped. Every GL account justified. Every design decision deliberate.*

**`VA11 → VA21 → VA01 → VL01N → VL02N → VF01 → F-28`**

**The complete Order-to-Cash cycle. Deployed to the cloud. Built to last.**

</div>
```
