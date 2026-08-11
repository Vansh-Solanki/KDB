d: `a`b`c!10 20 30
key d
value d
count d

// The key difference: Python stores key-value pairs as a hash map internally. q stores them as two separate, 
// contiguous lists in memory. This means q dictionaries over typed simple lists (e.g., all-symbol keys, 
// all-float values) are extremely cache-friendly.

(`u#`a`b`c)!10 20 30 // Applying the u# attribute for hash-based lookup speed
// ORDER MATTERS
(`a`b`c!10 20 30)~`a`c`b!10 30 20 //  these are NOT equal even though the mappings are identical

():() // General empty dictionary
(`symbol$()) ! `float$()  / Typed empty dictionary (symbol keys, float values)
(enlist `x) ! enlist 42 // Whenever you want a single-entry dictionary, you must enlist both the key and the value.
    
d `a 
d[`b]
d?20 //? on a dictionary maps a value back to its key

ddup:`a`b`a`c!10 20 10 30
ddup?10 // `a not `a again even though position 2 also has 10
d?99 // ` null symbol

where ddup?10 // `a`a both positions

// Dictionary vs. List
L:10 20 30
d:0 1 2!10 20 30
L 0 //10
d 0 //10
L 1 2 //20 30
d 1 2 //20 30

// The key practical difference: dictionaries can be extended, lists cannot:
d[3]:40   / works — adds a new key-value pair
L[3]:40   / error: index out of range

// Sparse list use case
d1:0 100 500000!10 20 30
d2: 0 99 1000000!100 200 300
d1+ d2 //This is how you can represent a sparse price grid (e.g., option strikes)

d:(`a`b; `c`d`e; enlist `f)!10 20 30 
d `a`b        / list key lookup 10
d?20 // `c`d`e

d:`a`b`c!(10 20; 30 40 50; enlist 60)
d`b // 30 40 50

d:`a`b`c!10 20 30 
d[`b]:42 // 10 42 30

d[`x]:100 // Insert new key 10 42 30 100 
`a`c _ d  //Use _ (Drop) with a list of keys on the left

d1,d2 // JOIN   Right wins on common command  - Join is not commutative:


travelers:`name`iq!(`Dent`Beeblebrox`Prefect; 42 98 126) 

dc:`c1`c2!(`a`b`c; 10 20 30)
t:flip dc

dc[`c1; 0] // Column dictionary: column first, then row ====== column c1, row 0
t[0; `c1]  // Flipped (table): row first, then column ===== row 0, column c1







// ============================================================
// Chapter 5: Dictionaries
// Q for Mortals - Practice File
// ============================================================

// --- 5.1 Dictionary Basics ---

// Basic creation with ! (bang)
d:`a`b`c!10 20 30
show d

// Key, value, count
show key d
show value d
show count d

// Type check - always 99h
show type d

// Unique attribute for hash lookup speed
dfast:(`u#`a`b`c)!10 20 30
show dfast

// Order matters - these are NOT equal
show (`a`b`c!10 20 30)~`a`c`b!10 30 20  // 0b

// --- 5.1.2 Singleton and Empty ---

// Empty general dictionary
show ()!()

// Typed empty dictionary
show (`symbol$())!`float$()

// Singleton - MUST use enlist
show (enlist `x)!enlist 42

// Common mistake - this is NOT a dictionary
// `x!42  <-- don't run this expecting a dict

// --- 5.1.3 Lookup ---
d:`a`b`c!10 20 30
show d[`a]          // 10
show d `b           // 20 - prefix syntax
show d[`x]          // 0N - null for missing key
show d[`a`c]        // 10 30 - vectorized lookup

// --- 5.1.4 Reverse Lookup ---
show d?20           // `b
show d?99           // ` (null symbol - not found)

// Non-unique keys - only first key found
ddup:`a`b`a`c!10 20 10 30
show ddup?10        // `a (first occurrence)
show where ddup=10  // `a`a (all occurrences)

// --- 5.1.5 Sparse Dictionary ---
d1:0 100 500000!10 20 30
d2:0 99 1000000!100 200 300
show d1+d2          // union of keys, add common ones

// --- 5.2 Operations ---

// Upsert semantics
d:`a`b`c!10 20 30
d[`b]:42            // update
d[`x]:100           // insert
show d

// Sub-dictionary extraction with #
d:`a`b`c!10 20 30
show `a`c#d         // {a:10, c:30}

// Removing entries with _
show `a`c _ d       // {b:20}

// Applying functions to dictionaries
show neg d
show 2*d
show d=20

// --- 5.2.5 Join ---
d1:`a`b`c!10 20 30
d2:`c`d!300 400
show d1,d2          // right wins on `c
show d2,d1          // left operand order reversed

// --- 5.2.6 Coalesce ---
d1:`a`b`c!10 0N 30
d2:`b`c`d!200 0N 400
show d1^d2          // null-safe merge

// --- 5.2.7 Arithmetic on mixed-key dicts ---
d1:`a`b`c!1 2 3
d2:`b`c`d!20 30 40
show d1+d2          // union keys, identity element for non-overlapping

// --- 5.3 Column Dictionaries ---

// Column dictionary: symbols -> same-length lists
travelers:`name`iq!(`Dent`Beeblebrox`Prefect; 42 98 126)
show travelers

// Column access
show travelers[`name]
show travelers[`iq]

// Element access (indexing at depth)
show travelers[`name; 1]    // `Beeblebrox
show travelers[`iq; 2]      // 126

// Row slice
show travelers[; 2]         // slice across all columns at position 2

// Single-column column dictionary
dc1:(enlist `c)!enlist 10 20 30
show dc1

// --- 5.4 Flipping a Column Dictionary -> Table ---
dc:`sym`price`qty!(`AAPL`GOOG`MSFT; 182.5 140.3 374.2; 100 200 150)
show dc             // column dictionary - columns printed sideways
t:flip dc
show t              // table - rows printed naturally

// Row access in table
show t[0]           // row 0 as a dictionary
show t[1]           // row 1 as a dictionary

// Column access in table
show t[;`price]     // price column as a list
show t[;`sym]       // sym column as a list

// Element access
show t[1;`price]    // price of row 1

// Verify flip is its own inverse
show dc~flip t      // 1b - flip of t gives back dc

// --- Financial Example: Trade Data Column Dictionary ---
trades:`time`sym`price`qty`side!(
    09:30:00 09:30:01 09:30:02 09:30:03;
    `AAPL`GOOG`AAPL`MSFT;
    182.5 140.3 183.0 374.2;
    100 200 150 300;
    `buy`sell`buy`buy)

show trades          // column dictionary of trade data
t:flip trades
show t               // trade table

// Access all AAPL rows (preview of what q-SQL will do)
show t[;`sym]        // all syms

// Apply price increase to all prices via dictionary arithmetic
show 1.01*trades     // does NOT work as expected on column dict directly
// Better: work on the values
show `price`qty#trades  // sub-dictionary of just price and qty columns