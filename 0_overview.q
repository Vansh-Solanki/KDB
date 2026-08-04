trades:([] 
    time: 09:30:01 09:30:02 09:30:03 09:30:04 09:30:05;
    sym: `AAPL`GOOG`AAPL`MSFT`AAPL;
    price: 150.10 2801.50 150.25 310.00 150.40;
    qty: 100 10 200 150 100;
    side: `buy`sell`buy`sell`buy) //table defined as column list from the start

avg trades `price

//q sql
select avg price from trades