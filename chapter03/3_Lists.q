L:(1; 2.2; "z";`abc)  / General list notation
prices: 100 101 102 103 / Simple (homogeneous) list  // count= 4 | first = 100 | last= 103 

prices: 100.5 101.2 99.8     / float list
sizes:  100 200 300           / long list
syms:   `AAPL`GOOG`MSFT      / symbol list

/ Basic
prices: 99.5 100.0 100.5 101.0 99.8
count prices              / 5
first prices              / 99.5
last prices               / 99.8
type prices               / 9h  (9 = float type code)

/ Realistic: trade sizes
sizes: 100 500 200 1000 300
sum sizes                 / 2100 — sum of all trade sizes
avg sizes                 / 420f — average trade size
max sizes                 / 1000
min sizes                 / 100

/ Industry style: symbol list for a portfolio
portfolio: `AAPL`GOOG`MSFT`AMZN`TSLA
count portfolio           / 5
first portfolio           / `AAPL

()                / general empty list — no display in console
enlist 42         / this is a list containing one item: 42

/ q
x: ()           / empty general list
x: enlist 42    / singleton containing 42 — must use enlist
s: enlist "a"   / singleton char list — don't forget this!


L: 100 200 300 400 500

/ Basic indexing
L[0]          / 100 — first item
L[4]          / 500 — last item
L[5]          / 0N  — out of bounds returns NULL (not an error!)
L[-1]         / 0N  — negative index also returns null (NOT Python behavior)

L[1]: 999  // inserts 999 at index 1
L[0 2 4] // retrives multiple values at once  100 300 500


/ Juxtaposition (no brackets needed)
L 0           / 100  — same as L[0]
L 0 2 4       / 100 300 500 — same as L[0 2 4]

/ Find operator ?
L ? 300       / 2 — index of 300 in L
L ? 99       / 5 — not found: returns count of list (one past the end)

/ IMPORTANT: mixed types produce general list
1 2 3, 4.5        / (1; 2; 3; 4.5) — general list, NOT a simple list

/ Merge with ^ (fill nulls)
L1: 10 0N 30
L2: 100 200 0N
L1 ^ L2           / 100 200 30 / Rule: take right (L2) except where right is null, then take left (L1)

/ Building a live price stream
live_prices: 100.5 101.0 0N 102.0 0N    / some nulls (missing ticks)
prev_close:  99.0  99.5  100.0 101.5 101.8

/ Fill missing prices with previous close
filled: prev_close ^ live_prices
filled  / 100.5 101.0 100.0 102.0 101.8

m: (1 2 3 4;
    10 20 30 40;
    100 200 300 400) // creating a nested list like a matrix
flip m // transpose of m
m[0]          / 1 2 3 4
m[1;2]        / 30
m[;2]         / 3 30 300 — column (note: semicolon before index)


book:(99.8 500 100.2 300;
       99.7 1000 100.3 800;
       99.6 2000 100.4 1500;
       99.5 500  100.5 200;
       99.4 300  100.6 100)

/ Get best bid price
book[0;0]       / 99.8

/ Get entire bid price column
book[;0]        / 99.8 99.7 99.6 99.5 99.4

/ Get entire ask size column
book[;3]        / 300 800 1500 200 100

/ Total liquidity at best 3 levels on bid side
sum book[0 1 2;1]   / 3500


syms:   `AAPL`GOOG`AAPL`MSFT`AAPL`GOOG
prices: 185.5 140.2 186.0 412.3 185.8 141.0
sizes:  100 200 500 1000 300 150

/ Find all indices where sym is AAPL
aapl_idx: where syms= `AAPL
aapl_idx          / 0 2 4

/ Use those indices to get AAPL prices and sizes
prices[aapl_idx]  / 185.5 186.0 185.8
sizes[aapl_idx]   / 100 500 300

/ Average AAPL trade price
avg prices[aapl_idx]   / 185.7666...

distinct `AAPL`GOOG`AAPL`MSFT`GOOG
distinct 1 2 3 2 3 4 6 4 3 5 6

group "i miss mississippi"
group syms

symbols: `AAPL`GOOG`AAPL`MSFT`AAPL`GOOG
group symbols