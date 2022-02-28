create table member(
id varchar2(30) primary key,
pw varchar2(100) not null,
addr1 varchar2(20) not null,
addr2 varchar2(40) not null,
addr3 varchar2(40) not null,
email varchar2(100) not null,
session_id varchar2(100) default nan not null,
phone_number varchar2(100) not null,
register_date date default sysdate,
limit_time date,
traduler_admin number default 0
)