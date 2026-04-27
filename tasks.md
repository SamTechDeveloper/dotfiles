# 16FEB2026:
1. Discussion with Raj about strategy and setup changes.
2. Discussion with Snehal about gui changes in active/inactive window for selection or no selection of bots to increase/decrease wind rate.
3. Discussion with team for gui related doubts, strategy and mono related doubts. Single order, bot timer, global pause and rejection handler.
4. Started testing single order in local simulation.

# 17FEB2026:
1. Discussion with Snehal about gui changes.
2. Helped Shubham with MSEI FIX Login.
3. Prepared pcap for testing Atharva's data store/player code.

# 18FEB2026:
1. Researched and discussed charges with Devendra sir, Krishna sir and Pravin.
2. Checked box wind rate file with new correct charges with Devendra sir and discussed issues.
3. Checked wind rate calculations in debug.

# 19FEB2026:
1. DIA BFO RMS cash in hand breach issue due to multiple rejection for lpp limits. Checked logs and tested in local simulation to check issue in RMS updates.
2. DIA BFO checked with Pravin and Devendra sir's issue with bidding logic due to mod gap and 2 second timeout. Updated binary for 1 second modifications.
3. Charged calcultions checked.

# 24FEB2026:
1. Finished solving all issues with eobi data store. Fixed lpp and default case. Verfied working for enitre pcap.
2. 

# 26FEB2026:
1. Added single order code of herambh's rb sir setup and fixed compilation issues and tested working in simulation.
2. Helped shubham with fix protocol issues checking errors and verified fix42.xml file.


# 15APR2026:
1) Make a startgy calling fuctuin for rejaction handle.
2) Correct the error code for rejaction handling.
3) Make single bot_place_order and identify sqoff order and do smart_routing.
4) throttal gloabal pause on and off from user.
5) first order cancel on call of timer.
6) bot modify order wihth smart logic to manage throttal, buy no up and sell no down price after x% reached.

---

# 16APR2026: 
## BOX TODO:
## Rejection Handling
## BUG: Maker modify rejected — maker_quote_price_last desync
- Use orders_placed confirmed price to retrive last confirmed price if modify order gets rejected.
## MISSING: Maker cancel rejected — no explicit recovery log or reason preservation
- Do nothing. Everything is logged.

## Price-on-Book Check Before Maker Placement: Review Summary
### BUG 1: Only one side of book checked at taker depth before placement
- One side order book checked. Should we check both ? Tested on one side order book.
### BUG 2: Qty at execution depth not checked against order size
- Worse prices.
- In live partial trades can happen even with qty match then what ? Worse prices in this case too ?

## Multi-ETI Routing and OPS Throttle
- What is at ETI line_no:1541? : Optimisation for continuous maker partial trades.
- Does bot_modify_order_bfo route to the ETI the order was originally placed on? : Yes

## ETI Throttle Signal / Global Bidding Pause
### MISSING 1: Throttle error code not identified
- Need to implement throttle error code condition in rejection handle.
- Other error codes also.
### MISSING 2: Global throttle flag does not exist
### MISSING 3: Throttle set path in `handle_rejection_bfo`
### MISSING 4: Throttle check in wind phase
### MISSING 5: Operator resume — GUI control via TCP port 8181

## Bot Timer / Stale Data: Maker Cancel with Contract Identification
### BUG 1: `taker_prices_valid` — no per-contract identification in log
### BUG 2: `DATA_STALE` block — no per-contract identification in log
### BUG 3: Zero timestamp not distinguished from stale

## Self Trade: Review Summary
### BUG: Self-trade retry counter in `order_t` — chain is unbounded

---

# 17APR2026:
## MTS BFO Setup Installation
## Box Strategy rejection handler changes, bot place/modify/cancel function changes and discussion with Raj and Krishna sir.

---

# 21APR2026:
# Single Order Bot changes. 
- Tested working for Raj changes. [x]
- Single order price zero allow or not ? If allowed what checks should be present. [x]
- Update code from herambs tbt_nfo_single_order add dpr and validation_price checks for modify. [x]
- Check all todo.
- Use best_percent for modify to become best or opposite. [x]

---

# 22APR2026:
## MTS:
- Pre-open data in bot issue started wind phase timer which started bot action instead of waiting for 20 seconds initial sleepage time.
## BOX: Single order testing:
- Tested new code for single order with price/zero and for multiple rounds. 
- Fixed partial trade qty value issue in eti test file.
- Tested working for partial trade. 
- Checked all FIXME code.
---
# 23APR2026:
## MTS:
- Packet drop issue. Reduced correct_mbp printing in eobi. Fixed 9:15 check separated 9:16 check for snapshot recovery. Fixed fcast fetch token, no details bug.
- Updated ops to 980 from 850.
## BOX Testing:
- Tested with data player to chekc working of new box strategy code. Checked order book price/qty depth validations.
- Discussed testing of box in live server with c2c setup and changes required to run both setups simultaneously.
---
# 24APR2026:
## MTS:
- Checked eobi 9:15 time check issue. Made changes to fix time to 9:14. Tested working of binary.
## BOX Testing:
- Discussed pending work with Raj and running simulation on live server with changes in database.
---
# 27APR2026:
## BOX:
- Discussed with team regarding using of c2c server together with bfo box setup. 
- Discussed db, logs, db ltcp path changes and issues.
- Prepared box setup on .25 server. Compiled and checked issues while running.
- Discussed with team reagarding Box gui:
1. Long, short type display in box execution report.
2. Show all opp box running for particular box.
3. Traded opp box needs to be checked if multiple opp box running. Show in multiple lines opp boxes.
4. What if strategy sq off 1st leg itself? Then will it display properly and what about its opposite box will it show more quantity if it gets trade ?
5. Only single order otr window.
6. Development of box report using bootstrap js.
