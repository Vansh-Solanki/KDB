+[2;3]

neg 1 2 3
1 2 3 + 15 20 25

100 + 1 2 3

2*3+4 //14 not 10
(2*3)+4 //10

(2*3)*3+4 //35

//practice
6*3+4 //42
10-3+2 //5
2*3*4 // 24
12%2+4 //2f
1+2*3+4 //15

42~42 // 1b True
42~42h // 0b False  same value, different type (long vs short)
42~42.0  // 0b False same value, different type (long vs float)
1 2 3~1 2 3 //1b True
1 2 3~1 2 4 //0b False

12~12  //0b (False, different types)
12=12 //1b (True, = is value-only, atom by atom)
42~(42)       / (42) is NOT a list, it's just 42
42~enlist 42  / enlist 42 IS a 1-item list

2 1 3 = 1 2 3     / compare element by element
2 = 1 2 3         / atom extends to match list
10 20 30 <= 30 20 10

not 0b            / 1b
not 1b            / 0b
not 42            / 0b  (42 is not zero)
not 0             / 1b  (0 is zero)
not 0.0           / 1b

10%2      / division in q
10 div 2  / integer division
10 mod 3  / modulus

3|5        / greater of 3 and 5
3&5        / lesser of 3 and 5
0b|1b      / on booleans, acts like logical OR
1b&0b      / on booleans, acts like logical AND

/ Cap a price at 100
price: 95 102 88 110 97
price & 100

/ Floor a PnL at 0 (no negative values)
pnl: -5 10 -3 20 -1
pnl | 0


L:100 200 300 400
L[1]+:99          / add 99 to index 1
L[1 3]-:1         / subtract 1 from indices 1 and 3

sqrt 14
exp 10
log 1
2 xexp 10         / 2 to the power 10
2 xlog 1024       / log base 2 of 1024


/ Determine direction of price moves
pnl: -5 10 -3 20 -1
signum pnl


//Truncating floats to N decimal places using floor
x:4.2478
0.01 * floor 100*x


//null < negative infinity < any value < positive infinity


//Alias
a:42
c:a
b::a
a:43 // now b=43 and c = 42 fixed






// ============================================================
// Chapter 4: Operators
// Q for Mortals - Practice File
// ============================================================

// -----------------------------------------------------------
// 4.1 Right-to-Left Evaluation (NO operator precedence)
// -----------------------------------------------------------

// CRITICAL: q evaluates right to left
// 2*3+4 = 2*(3+4) = 14, NOT 10
a_rtl: 2*3+4                    // 14
b_rtl: (2*3)+4                  // 10, force left side first
c_rtl: (2+3)*3+4                // 35

// -----------------------------------------------------------
// 4.2 Match ~
// -----------------------------------------------------------

match_int:   42~42              // 1b, same type and value
match_type:  42~42h             // 0b, different types (long vs short)
match_float: 42~42.0            // 0b, different types
match_list:  1 2 3~1 2 3        // 1b
match_diff:  4 2~2 4            // 0b, same values, different order

// Common trap: (42) is NOT a list
trap_paren:  42~(42)            // 1b, (42) is just 42
trap_list:   42~enlist 42       // 0b, enlist 42 IS a 1-item list

// -----------------------------------------------------------
// 4.3 Equality and Relational Operators
// -----------------------------------------------------------

// = is atomic (element-wise), ~ is structural (whole)
eq_atoms:    42=42.0            // 1b, same numeric value
eq_list:     2 1 3=1 2 3        // 0 0 1b, element-wise
eq_atom_list:2=1 2 3            // 0 1 0b, atom extends

// not = "is this zero?"
not_zero:    not 0              // 1b
not_nonzero: not 42             // 0b
not_list:    not 0 1 2 0 3      // 1 0 0 1 0b

// Disequality
diseq:       42<>43             // 1b

// -----------------------------------------------------------
// 4.4 Basic Arithmetic
// -----------------------------------------------------------

// % is DIVISION in q (not modulus like Python!)
div_result:  10%4               // 2.5f, always float

// NO unary minus in q - use neg instead
pos_val:     42
neg_val:     neg pos_val        // -42

// Right-to-left with arithmetic
expr1:       6*3+4              // 42, not 22!
expr2:       12%2+4             // 2f, not 10!

// Vectorized arithmetic
vec_add:     1.0+10 20 30       // 11 21 31f
vec_div:     10 20 30%1 2 3     // 10 10 10f

// -----------------------------------------------------------
// 4.5 Greater | and Lesser &
// -----------------------------------------------------------

// | returns the LARGER (not bitwise OR!)
// & returns the SMALLER (not bitwise AND!)
greater:     3|5                // 5
lesser:      3&5                // 3

// Cap prices at 100
prices:      95 102 88 110 97
capped:      prices&100         // 95 100 88 100 97

// Floor PnL at 0
pnl:         -5 10 -3 20 -1
floored_pnl: pnl|0              // 0 10 0 20 0

// Boolean usage: | = OR, & = AND on booleans
bool_or:     0b|1b              // 1b
bool_and:    1b&0b              // 0b

// -----------------------------------------------------------
// 4.6 Amend :
// -----------------------------------------------------------

// Amend in place
x_amend:10
x_amend+:5                      // x_amend is now 15
x_amend*:2                      // x_amend is now 30

// Append to list with ,:
mylist:1 2 3
mylist,:4                       // 1 2 3 4
mylist,:100 200                 // 1 2 3 4 100 200

// Amend at index
L:100 200 300 400
L[1]+:99                        // L is now 100 299 300 400
L[1 3]-:1                       // L is now 100 298 300 399

// -----------------------------------------------------------
// 4.7 Exponential Primitives
// -----------------------------------------------------------

sq_root:     sqrt 2             // 1.414214f
e_val:       exp 1              // 2.718282f
nat_log:     log 1              // 0f
power:       2 xexp 10          // 1024f
log_base2:   2 xlog 1024        // 10f

// -----------------------------------------------------------
// 4.8 Numeric Primitives
// -----------------------------------------------------------

// div and mod (NOT % which is division!)
int_div:     7 div 2            // 3
mod_rem:     7 mod 2            // 1
neg_div:     -7 div 2           // -4 (floors, not truncates!)
neg_mod:     -7 mod 2           // 1

// signum: tells you direction
signum_pos:  signum 42          // 1i
signum_neg:  signum -5          // -1i
signum_zero: signum 0           // 0i

// Useful for trade direction
pnl_dir:     signum -5 10 -3 20 -1   // -1 1 -1 1 -1i

// floor and ceiling
fl:          floor 4.7          // 4
cl:          ceiling 4.2        // 5

// Truncate to 2 decimal places
price_raw:   4.2478
price_trunc: 0.01*floor 100*price_raw   // 4.24

// abs
abs_val:     abs -42            // 42

// -----------------------------------------------------------
// 4.9 Temporal Arithmetic
// -----------------------------------------------------------

// Underlying integer of temporal values
date_int:    `int$2000.01.01    // 0i (the epoch)
day_before:  `int$1999.12.31    // -1i

// Date arithmetic
tomorrow:    2024.01.01+1       // 2024.01.02
week_dates:  2024.01.01+til 5   // Mon-Fri

// Date difference = number of days
leap_year:   2001.01.01-2000.01.01   // 366i (2000 was leap year)

// Timestamp from date + timespan
ts:          2015.01.01+12:00:00.000000000
// 2015.01.01D12:00:00.000000000

// -----------------------------------------------------------
// 4.10 Nulls and Infinities
// -----------------------------------------------------------

inf_long:    0W                 // positive long infinity
neg_inf:     -0W                // negative long infinity
null_long:   0N                 // null long

// Null comparisons always return 0b
null_cmp:    0N<42              // 0b, nulls are incomparable
inf_cmp:     42<0W              // 1b, any value < infinity
neg_neg_inf: neg 0W             // -0W
neg_null:    neg 0N             // 0N, sign is meaningless for null

// -----------------------------------------------------------
// 4.11 Alias :: (Views)
// -----------------------------------------------------------

// Basic alias - deferred evaluation
a_base:42
b_alias::a_base                 // b is an alias of a, not a copy
c_copy:a_base                   // c is a copy of current value
a_base:43
// b_alias -> 43 (tracks a_base)
// c_copy  -> 42 (frozen at assignment time)

// Database view (most practical use)
trade_t:([]sym:`AAPL`GOOG`AAPL; price:150.0 2800.0 151.0)
aapl_view::select sym,price from trade_t where sym=`AAPL
// aapl_view auto-updates when trade_t changes