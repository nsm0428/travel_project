create table qna(
qnaNo number primary key,
qnaTitle varchar2(150),
qnaContent varhchar2(300),
qnaHit number,
saveDate date default sysdate,
qnaPwd varchar2(100),
id varchar2(30)
);

create table qnaReply(
id varchar2(30),
qrContent varchar2(300),
qrWriteGroup number,
saveDate date default sysdate,
qrId varchar2(30)
);

create SEQUENCE qna_board_SEQ
  INCREMENT BY 1;