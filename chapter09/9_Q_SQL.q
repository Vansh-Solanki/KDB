trades:([] sym:`ibm`aapl`ibm`goog; qty:100 200 150 300; px:150.5 95.2 151.0 2800.0)
select sym, notional:qty*px from trades // 
select from trades where px=(max;px) fby sym /// Find the trade with the max price PER SYMBOL, using fby instead of a subquery

exec name from t where state in `NY`HI //exec
update c2:c2+100 from t where c1<>`a // update
delete c1 from t
delete from t where c2>15 // delete

`t upsert (`Marvin; 150) //	pass by name, modifies the global table in place
t upsert (`Marvin; 150) // pass by value, returns a new table, original untouched
`t insert (`Marvin; 150)
`trades upsert (`aapl; 96.0)     / price correction for aapl


trades:([] sym:`ibm`aapl`ibm; tm:10:05:00 10:01:00 10:03:00; px:151 95 150.5)
`sym`tm xasc trades //sort by time
`bidpx`askpx xcol ([] c1:1 2; c2:100.0 101.0; c3:100.5 101.5) // rename ambiguous join columns


t lj kt // 	all rows/columns from t, plus columns from kt where keys match, null where they don't
t ij kt // Same shape as lj, but only keeps rows where the key matches in both. No nulls in the result.

aj[`sym`ti; t; q] // for each row in t, attach the columns from q's matching row, using the quote in effect as of that trade's time
// Variant: aj0 — identical, except the result carries the matched row's time from the right table instead of the original left table's time.

wj[w; c; t; (q; (f0;c0); (f1;c1))] //Like aj, but instead of one matching value, aggregate over a window of time around each row


t:([] k:1 2 3 4; c:10 20 30 40)
kt:([k:2 3 4 5]; v: 200 300 400 500)
t lj kt // left join
t ij kt // inner join


show t:([] ti:10:01:01 10:01:03 10:01:04; sym:`msft`ibm`ge; qty:100 200 150)
show q:([] ti:10:01:00 10:01:01 10:01:01 10:01:02; sym:`ibm`msft`msft`ibm; px:100 99 101 98)
aj[`sym`ti; t; q]


show t:([] sym:3#`aapl; time:09:30:01 09:30:04 09:30:08; price:100 103 101)
show q:([] sym:8#`aapl; time:09:30:01+(til 5),7 8 9;ask:101 103 103 104 104 103 102 100; bid:98 99 102 103 103 100 100 99)
w:-2 1+\:t `time
c:`sym`time
wj[w;c;t;(q;(max;`ask);(min;`bid))]


d:([] c1:`a`b`c; c2:10 20 30; c3:1.1 2.2 3.3)
proc:{[sc] select from d where c2>sc} //basic parameterized query
proc 15

e:([] c1:`a`b`a`c`a`b`c; c2:10*1+til 7; c3:1.1*1+til 7)
select max c2, c2 wavg c3 by c1 from e where c2>35,c1 in `b`c  // template

c:((>;`c2;35); (in;`c1;enlist `b`c))
b:(enlist `c1)!enlist `c1
a:`maxc2`wtavg!((max;`c2); (wavg;`c2;`c3))
?[e;c;b;a]


t1:([] k:1 2 3 4; c:10 20 30 40)
t2:([] k:2 2 3 4 5; c:200 222 300 400 500; v:2.2 22.22 3.3 4.4 5.5)
ej[`k;t1;t2] // Equi Join

t:([] k:`a`b`c; a:100 200 300; b:10. 20. 30.; c:1 2 3)
kt:([k:`a`b] a:10 20; b:1.1 2.2)
t pj kt // Plus Join

t1:([] c1:`a`b`c; c2:10 20 30)
t2:([] c1:`x`y; c3:8.8 9.9)
t1 uj t2   // Union Join



mktrades:{[tickers; sz]
  dt:2015.01.01+sz?31;
  tm:sz?24:00:00.000;
  sym:sz?tickers;
  qty:10*1+sz?1000;
  px:90.0+(sz?2001)%100;
  t:([] dt; tm; sym; qty; px);
  t:`dt`tm xasc t;
  t:update px:6*px from t where sym=`goog;
  t:update px:2*px from t where sym=`ibm;
  t}
trades:mktrades[`aapl`goog`ibm; 10000000]

instr:([sym:`symbol$()] name:`symbol$(); industry:`symbol$())
`instr upsert (`ibm; `$"International Business Machines"; `$"Computer Services")
update `instr$sym from `trades

select vwap:qty wavg px by dt from trades where sym=`ibm // / VWAP by day
select vwap:qty wavg px by dt,100 xbar tm from trades where sym=`ibm // / VWAP by day AND 100ms buckets
select hi:max px,lo:min px,open:first px, close:last px by dt,tm.minute from trades where sym=`goog // OHLC bars, one minute buckets 

// IMPORTANT
// select lo:min px, hi:max px by sym.name from trades //ra implicit join through the foreign key, group by resolved company name
// That last one is worth sitting with: sym.name reaches through the foreign key from trades into instr to pull name, 
// and you can group by it directly, as if it were a native column. This is the implicit join pattern from 9D applied 
// inside a by phrase.


select max px-mins px by sym from trades //The "ideal trade" query, genuinely clever