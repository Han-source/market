drop table s_trade_type;
drop table s_trade_product;
--상품 테이블
--product_id, board_id, parent_id, user_id, product_price
create table s_trade_product(
	product_id			varchar2(4000) 	primary key,
	board_id			number(9)		REFERENCES s_board(id),
	parent_id			number(9),		-- 구분자
	user_id				varchar2(10),
	product_price		number(19)
)
-- s_trade_product 테이블에 discrim 에 넣어줄 값.
-- trade_type
create table s_trade_type(
	trade_type			varchar2(50)		not null
)

insert into s_trade_type
	values('직접거래');
insert into s_trade_type
	values('협상거래');
insert into s_trade_type
	values('경매거래');	

--거래테이블
--product_price, seller_id, buyer_id
create table s_trade(
	trade_id				varchar2(4000) 	primary key,
	product_final_price		number(19),
	seller_id				varchar2(10),
	buyer_id				varchar2(10),
	trade_date				timestamp default sysdate not null
)

--거래 방식 테이블
--seller_id, buyer_id, product_id, discount_price, auction_current_price, auction_end_date
create table s_trade_condition(
	seller_id				varchar2(10),
	buyer_id				varchar2(10) default 0,
	product_id				varchar2(4000),
	discount_price			number(19) default 0,
	auction_current_price	number(19) default 0,
	auction_end_date		timestamp 
)

create table s_shopping_bascket(
	user_id			varchar2(10),
	product_id		varchar2(4000),
	primary key(user_id, product_id)
)


-- trade_id, buyer_name, address, phone_num, reserve_num, absent_message
create table s_shipping_info(
   trade_id       	trade_id,
   buyer_name     	varchar2(19),
   address		  	varchar2(1000),
   phone_num		number(19),
   reserve_num		number(19),
   absent_message	varchar2(4000)
)
