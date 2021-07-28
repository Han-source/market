--Oracle 자료형 선택시.. 고민 거리..
-- int , long -> number(9), 19로 사용
--date -> 년-월-일(date)사용, 일시까지 사용(timestamp)
--boolean -> char(1)로 사용

drop table s_chat;
CREATE SEQUENCE chat_seq_id
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;
       


seq_chat_id.nextval
-- chat_id, from_id, to_id, chat_content, chat_time
create table s_chat(   
   chat_id         number(9)   primary key,
   from_id         varchar2(100),
   to_id         varchar2(100),
   chat_content   varchar2(4000),
   chat_time      date,
   chat_read      number(9) default 0
);





insert into s_chat(chat_id, from_id, to_id, chat_content, chat_time)
   values(chat_seq_id.nextval,'ghost','222', '하이', sysdate)       