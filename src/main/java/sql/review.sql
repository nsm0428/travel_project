create table r_reply(
id varchar2(30) not null,
r_reply_content varchar2(150) not null,
r_reply_date date default sysdate,
r_write_group number default 0,
r_reply_no number primary key
);

create table review(
review_no number primary key,
review_title varchar2(100) not null,
review_content varchar2(300) not null,
review_hit_num number default 0,
review_like number,
review_date date default sysdate,
id varchar2(30) not null
);

create table r_photo(
id varchar2(30) not null,
origin_file_name varchar2(300),
stored_file_name varchar2(300),
r_write_group number not null,
photo_num number
);
