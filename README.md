# SAP BTP CAP — Order-to-Cash (O2C) Architecture
## Vayu Drone Technologies Pvt. Ltd.

**Author:** Sayandip Bhattacharya | **Roll:** 23052423 | **Batch:** KIIT CSE 3rd Year  
**Project Type:** SAP BTP Developer Capstone — Individual Submission  

---

## Company Overview

Vayu Drone Technologies Pvt. Ltd. is a B2B industrial drone manufacturer. This repository implements a complete, cloud-native Order-to-Cash (O2C) business process using SAP Business Technology Platform (BTP) and the Cloud Application Programming (CAP) model, complete with a SAP Fiori Elements frontend.

## SAP BTP Architecture

- **Framework:** SAP CAP (Cloud Application Programming Model)
- **Database:** SQLite in-memory (development)
- **Frontend:** SAP Fiori Elements (List Report + Object Page) via `app/annotations.cds`

## O2C Process — T-Code Simulations (OData Actions)

- **`createSalesOrder()`** — Simulates VA01. Fires credit limit check and ATP simulation.
- **`createDelivery()`** — Simulates VL01N.
- **`confirmPGI()`** — Simulates VL02N Post Goods Issue. Reduces stock, posts COGS and Inventory GL entries.
- **`createInvoice()`** — Simulates VF01 billing. Posts AR, Revenue, and Tax GL entries.
- **`postPayment()`** — Simulates F-28. Posts Bank debit and AR credit GL entries.

## FI Accounting Entries (SD-FI Integration)

### On Post Goods Issue — VL02N (Movement Type 601)
- **DEBIT  GL 500000 — Cost of Goods Sold (COGS):** value at Moving Average Price
- **CREDIT GL 300000 — Finished Goods Inventory:** same value; stock exits Balance Sheet

### On Billing — VF01 (Billing Type F2)
- **DEBIT  GL 140000 — Trade Receivables (AR):** gross invoice value including IGST
- **CREDIT GL 800000 — Revenue — Drone Systems:** net value excluding tax
- **CREDIT GL 220100 — IGST Payable (Output Tax):** IGST at 18% on net taxable value

### On Incoming Payment — F-28
- **DEBIT  GL 113000 — HDFC Bank Current Account:** amount received
- **CREDIT GL 140000 — Trade Receivables (AR Cleared):** open item cleared
