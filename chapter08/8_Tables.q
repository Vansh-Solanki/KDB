t:flip `name`iq !(`Dent`Beeblebrox`Prefect; 98 42 126) //Building a table by flipping a dictionary
t:([] name: `Dent`Beeblebrox`Prefect; iq: 98 42 126) //Building a table directly

t[;`iq]      / all rows, column iq -> the iq list
t[`iq]       / shorthand for above -- semicolon can be dropped for column access
t[2;]        / row 2 as a dictionary (a "record")
t[2;`iq]     / row 2, column iq -> single value
t[0]         / row 0 as a dictionary

([] name: `symbol$(); iq:`int$()) //Empty/typed schema
type t
count t
meta t
cols t


emp:([] eid:`int$(); name:`symbol$(); dept:`symbol$())
emp,: (1; `Arthur; `Engineering)
emp,: (2; `Trillian; `Physics)

trade:([] time:`timestamp$();sym:`symbol$();price:`float$();size:`int$())
trade,:(.z.p;`AAPL;189.32;100)
trade,:(.z.p;`MSFT;412.5;250)


select name from t
select c1:name, c2:iq from t
update iq:iq%100 from t
t,: `name`iq!(`W; 26)      / append using a dictionary (any field order OK)
t,: (`H; 142)               / append using naked values (MUST match column order)

select from trade where sym=`AAPL
first trade
last trade