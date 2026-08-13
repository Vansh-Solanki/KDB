type 42
0h // General list
99h // Dictionary
98h // Table

// This negative/positive convention is q's compact way of saying "atom vs vector" without a separate flag.
// The big mental shift: Python's type system is about classes and objects. q's type system is about storage layout.

type 10 20 30
type ()
type 3.14 
type 3.14 2.02 3.01
type ([] a:1 2 3)

`int$42
`float$42 // int to float


ts:2024.03.15D09:31:22.457000000
`date$ts
`hh$ts
`minute$ts

`$"Hello World" // Symbol creation via `$
`$("Life";"the";"Universe") // This is atomic, so it works on lists of strings too

prices:0#0.0
prices,: 100.02
prices,: 100.6

u:`g`aapl`msft`ibm        / unique domain
v:1000000?u               / 1M random picks from u (your raw repetitive data)
k:u?v                     / Find: for each item in v, its index in u
ev:`u$v
`int$ev        / -> the underlying k values
value ev       / -> back to plain `msft`aapl`... symbols


sym:()
`sym?`g          / ? not $ -- appends `g to sym if not already there, then enumerates
`sym?`ibm`aapl   / appends both if new, enumerates


sym:`AAPL`MSFT`IBM
trade:([] time:3#.z.p; sym:`sym$`AAPL`MSFT`AAPL; price:150.2 305.1 150.5; size:100 200 150)

//Confusing ev~v (identical, 0b) with ev=v (element-wise equal, all 1b).

isAtom:{type[x]<0} // one liner to check if x is an atom
isAtom 42
isAtom 10 20 30

x:250000000j
`int$x
`$("Buy";"Sell";"Hold") //Strings to symbols

s:0#` // type s = 11h
q,: `AAPL
q,: `MSFT