f:{[x;y] a:x*x; b:y*y; a+b}
result:f[3;4]

sq:{[x] x*x}  // Simple square function
sq[6]

add:{[a;b] a+b}  // Two-argument function
add[9;6]

hypotenuse:{[g;h] v:g*g; l:h*h; sqrt v+l} // Multi-expression function - intermediate variables
hypotenuse[6;8]

/ These two are identical
{[x] x*x}
{x*x}

/ These two are identical
{[x;y] x+y}
{x+y}

/ Warning: if you use z, q requires ALL 3 args
f:{x+z}
f[1;2;3]   / works, 2nd arg ignored
f[1;2]     / this is a projection, not an error - more on this later


mid:{[bid;ask] (bid+ask)%2} // Mid-price from bid and ask
mid [100.5;100.7]

bids:100.1 100.2 100.3
asks: 100.5 100.6 100.7
mid[bids;asks]


{x*x}[5] /Anonymous functions (lambdas)
ops:({x+y}; {x-y}; {x*y}) // As items in a list (dynamic dispatch)
ops[0][10;3] //add
ops[1][10;3] //subtract
ops[2][10;3] //multiply

//Local and Global Variables
f:{[x] localVar:x*2; localVar+1} // Local variable - disappears after call
f[5] //result 11

globalRate:0.05  // Global variable - visible inside functions
calcReturn:{[price] price*globalRate}
calcReturn[1000] //result 50f

add:{[x;y] x+y} //Projection
add10:add[10;]   / project - fix x=10, leave y open
add10[5]         / Result: 15



/ General fee calculator
calcFee:{[rate;amount] amount*rate}

/ Specialized versions via projection
brokerFee:calcFee[0.001;]    / 0.1% brokerage fee
exchangeFee:calcFee[0.0005;] / 0.05% exchange fee

brokerFee[10000]    / Result: 10f
exchangeFee[10000]  / Result: 5f

zscore:{[x] (x-avg x)%dev x}  // This is atomic because * and + are atomic
zscore 10 20 30 40 50


count (10 20 30; 40 50)   / Result: 2  -- counts outer items
count each (10 20 30; 40 50)  / Result: 3 2  -- counts each inner list

reverse each ("live";"evil";"stressed")
/ Result: ("evil";"live";"desserts")

data:(1 2 3; 10 20 30; 100 200 300)
sum each data // Result: 6 60 600

/ Join strings pairwise
("abc";"de") ,' ("XY";"Z") // Result: ("abcXY";"deZ")

/ Build bid-ask pairs
bids:100.1 100.2 100.3
asks:100.5 100.6 100.7
bids ,' asks
/ Result:
/ 100.1 100.5
/ 100.2 100.6
/ 100.3 100.7

("abc";"de";"f") , \: ">" // Each Left: append ">" to each string
"<" ,/: ("abc";"de";"f")  // Each Right: prepend "<" to each string
"<" ,/: ("abc";"de";"f") , \: ">"  // Combine both to make XML-like tags


/ Daily PnL
dailypnl:100 -50 200 -30 150
/ Cumulative PnL using Over
cumsumpnl:0 +\ dailypnl     / <- this is Scan, see below / Result: 100 50 250 220 370

prices:100 99 101 102 101
0 +\ prices
/ Result: 100 199 300 402 503

/ Running maximum (useful for drawdown)
(|\) prices
/ Result: 100 100 101 102 102

/ Running product
(*\) 1 2 3 4 5
/ Result: 1 2 6 24 120


L:10 20 30 40 50

/ Simple retrieval
L@2             / Result: 30

/ Apply unary function to specific indices
@[L; 0 2; neg]
/ Result: -10 20 -30 40 50   -- full list returned

/ Apply binary function with a value
@[L; 0 1; +; 100]
/ Result: 110 120 30 40 50

/ Modify IN PLACE using symbol name
@[`L; 0 2; :; 999 888]
L
/ Result: 999 20 888 40 50

.[m; 0 1; +; 999]
/ Result:
/ 10 1019 30
/ 100 200 300
