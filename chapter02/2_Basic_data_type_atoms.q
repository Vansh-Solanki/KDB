// 1] integer type
42 //long 8 bytes
42j //long with explicit type indicator of long
42i // integer 4 bytes
-123h //short 2 bytes

// 2] Floating Point
3.141519 // float (8 bytes double precision) Default
1f // also a float
1.34e7 // scientific notation: 1.234 × 10^7
4.2e // real (4 bytes single precision) is useless in finance because it lacks precision

// 3] Boolean
1b //true
0b //false

42 + 1b     / 43 (boolean promoted to integer)
flag:1b
base:100
base+ flag*42 / conditional without if/else

// 4] BYTE and GUID
0x2a //byte in hex (= 42 decimal)
0x2A        / same thing, upper case also valid

-1?0Ng      / generate ONE random GUID (use negative for production!)
1?0Ng       / generates same GUID every session (use for testing only)

// 5] Char vs Symbol
"q" / a single character in double quotes
`q          / the symbol q
`AAPL       / the symbol AAPL (starts with backtick)
`            / the empty symbol (this is the null symbol)
`a ~ "a"    / are they the same? NO  Symbol and char are completely different types.

// 6] Temporal types
2024.01.15          / January 15, 2024
2000.01.01 = 0      / epoch: Jan 1 2000 is day 0
2000.01.02 = 1      / Jan 2 2000 is day 1
1999.12.31 = -1     / pre-millennium is negative

`int$2000.02.01     / get the underlying day count 31i

//time (millisecond resolution)
09:30:00.000        / 9:30 AM, zero milliseconds
12:00:00.000 = 12*60*60*1000   / verify: 12 hours = 43200000 ms
`int$09:30:00.000   / underlying millisecond count

// timespan (nanosecond resolution)
09:30:00.123456789          / format: hh:mm:ss.nnnnnnnnn
`long$09:30:00.123456789    / underlying nanosecond count

//timestamp 
2024.01.15D09:30:00.000000000    / full timestamp with nanoseconds

`date$2024.01.15D09:30:00.000000000    / extract the date part
`timespan$2024.01.15D09:30:00.000000000  / extract time part

//month 
2024.01m            / January 2024 (trailing m is REQUIRED)
2014.11             / WITHOUT m: this is a FLOAT 2014.11, not a month!

// minute and second
09:30               / minute type: 9 hours 30 minutes from midnight
09:30:00            / second type: same but with seconds

// 7] Infinities and Nulls
0w / positive float infinity
-0w / negative float infinity
0n  / null float (NaN)
0W / positive long infinity  (capital W)
-0W  / negative long infinity
0N        / null long

1%0       / division by zero -> positive infinity (no error!)  0w
-1%0      / -> negative infinity  -0w
0%0       / zero divided by zero -> NaN  0n
42 < 0W   / positive long infinity is greater than everything    1b (true)


0Nh        / null short
0Ni        / null int
0N         / null long (note: no j suffix needed)
0n         / null float
0Nd        / null date
0Nt        / null time
0Np        / null timestamp
`           / null symbol (empty backtick)
" "         / null char (space character)

0N = 0N          / this returns 0b (false!) because null propagates
null 0N          / this correctly returns 1b