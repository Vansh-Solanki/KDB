// t:flip `name`iq !(`Dent`Beeblebrox`Prefect; 98 42 126) //Building a table by flipping a dictionary
// t:([] name: `Dent`Beeblebrox`Prefect; iq: 98 42 126) //Building a table directly

// t[;`iq]      / all rows, column iq -> the iq list
// t[`iq]       / shorthand for above -- semicolon can be dropped for column access
// t[2;]        / row 2 as a dictionary (a "record")
// t[2;`iq]     / row 2, column iq -> single value
// t[0]         / row 0 as a dictionary

// ([] name: `symbol$(); iq:`int$()) //Empty/typed schema
// type t
// count t
// meta t
// cols t


// emp:([] eid:`int$(); name:`symbol$(); dept:`symbol$())
// emp,: (1; `Arthur; `Engineering)
// emp,: (2; `Trillian; `Physics)

// trade:([] time:`timestamp$();sym:`symbol$();price:`float$();size:`int$())
// trade,:(.z.p;`AAPL;189.32;100)
// trade,:(.z.p;`MSFT;412.5;250)


// select name from t
// select c1:name, c2:iq from t
// update iq:iq%100 from t
// t,: `name`iq!(`W; 26)      / append using a dictionary (any field order OK)
// t,: (`H; 142)               / append using naked values (MUST match column order)

// select from trade where sym=`AAPL
// first trade
// last trade


// kt:([eid:1001 1002 1003] name:`Dent`Beeblebrox`Prefect; iq:98 42 126)
// kt:(flip (enlist `eid)!enlist 1001 1002 1003) ! flip `name`iq!(`Dent`Beeblebrox`Prefect;98 42 126)
// kt[1002]          / abbreviated key -> returns the value RECORD (dictionary)
// kt[1002;`iq]       / drill into a specific field
// kt 1002            / same as kt[1002] -- function-application-style syntax works too
// kt ([] eid:1001 1002)              / anonymous table of keys -- the clean way


// ktc:([lname:`Dent`Beeblebrox`Prefect; fname:`Arthur`Zaphod`Ford] iq:98 42 126)
// ktc[`Dent`Arthur]                   / lookup by compound key value
// ktc (`Dent`Arthur;`Prefect`Ford)    / multiple compound-key lookups work directly (no length error here)

// `eid xkey t      / convert plain table t to keyed table, keyed on eid
// () xkey kt        / convert keyed table back to plain table (unkey it)
// 1!t               / shorthand: key on the leftmost 1 column
// 0!kt              / shorthand: unkey (0 columns as key)

// //instrument reference table + trade foreign key
// instr:([sym:`AAPL`MSFT`GOOG] sector:`Tech`Tech`Tech; ticksize:0.01 0.01 0.01; exch:`NASDAQ`NASDAQ`NASDAQ)
// trade:([] sym:`instr$`AAPL`MSFT`AAPL`GOOG; price:189.3 412.6 189.5 141.2; size:100 250 150 80)
// select sym.exch, price, size from trade
// trade,: (`instr$`TSLA; 245.0; 500) // 'cast That last error is exactly the referential-integrity check working as designed — TSLA isn't in instr's key column, so the append is rejected.


tp:([] d:2015.01.01 2015.01.02; lh:(67.9 82.1; 72.8 88.4))
`s#1 2 4 8          / sorted attribute -- checked; fails with 's-fail if not actually sorted
`u#2 1 4 8          / unique attribute -- checked; fails with 'u-fail if duplicates exist
`p#2 2 2 1 1 4 4     / parted attribute -- checked for "same values adjacent," not sortedness
`g#1 2 3 2 3 4       / grouped attribute -- works on ANY list, no structural requirement

L:`s#1 2 3 4 5
L,:6        / 6 preserves sort order -> attribute survives
L,:0        / 0 breaks sort order -> attribute silently DROPPED, no error

L:`p#3 3 3 1 1 2 2 2
L,:3

tm:([] wk:2015.01.01 2015.01.08; rv:(38.92 67.34; 16.99 5.14 128.23 31.69))
select wk, avgr: avg each rv from tm