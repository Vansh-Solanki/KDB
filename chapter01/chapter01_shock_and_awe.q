b:1+a:42 /right to left a is 42 and 1+42 is assigned to b

/ This is evaluated: 2 * (3 + 4) = 14, NOT (2*3) + 4 = 10
2*3+4          / outputs: 14

qty:1000
exit_price:105.5
entry_price:100
pnl:qty*exit_price-entry_price   / reads: pnl gets qty times (exitPx minus entryPx)

price:100
qty:50
notional:price*qty
notional:(price:100)*qty:50 // one line solution 

4%2

a:42 //long
b:3.14 //float
c:1b //boolean
d:"a" //char
e:`aapl //symbol
f:2024.01.15 //date
g:09:30:00.000000000 //timespan
f+5 // 5 days later
g+1000 //1000 nanoseconds later


2000.01.01      / this is 0 (day zero)
2000.01.02      / this is 1
1999.12.31      / this is -1 (before the millennium)
2000.01.01=0    / outputs: 1b (true)
2000.01.01+5    / outputs: 2000.01.06

10%3

L: 1 2 3 // L = [1, 2, 3]          # list
M: 10 20 30 // L = [10, 20, 30]

til 10 //Range 0 to 9 list(range(10)) 
1 2 3, 4 5 //Concatenation / 1 2 3 4 5
// take
2#L
-2#M
L[0] //index 0 = 1
/ Scalar broadcast - works natively
M+1                / 11 21 31
1+til 10           / 1 2 3 4 5 6 7 8 9 10

5# 1 2 3 //wraps around

5#42 // replicate single number

5#0b //5 booleans false

0#1 2 3 //empty long list
0#0.0 //empty float list
0#` //empty symbol list

prices:5#100 + til 5
sq:{[x] x*x}
sq 5
sq[5]
ab:{[a;b] a+b} [5;2] 

python:{[x;y] a:x*x; b:y+y; a+b} [3;6]

discount:{[p;r;t] interest:p*r*t; p+interest}
discount[1000;0.05;2]

mid:{(x+y)%2} //bid + ask /2
mid[100.0; 100.5]
