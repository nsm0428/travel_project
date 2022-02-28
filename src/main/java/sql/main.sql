create table main(
main_category varchar2(50),
place_name varchar2(50),
content_one varchar2(300),
content_two varchar2(300),
main_image_file varchar2(100),
image_file1 varchar2(100),
image_file2 varchar2(100),
likeHit number default 0,
upHit number default 0,
latitude float,
longitude float,
address varchar2(150)
);

create table mylist(
list_no number primary key,
id varchar2(30),
place varchar2(50),
image varchar2(100)
);

create table mainReply(
rep_no number primary key,
rep_content varchar2(200),
place_name varchar2(200),
id varchar2(30),
likeHit number default 0,
savedate date default sysdate
);