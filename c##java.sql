-- board 테이블 작성
CREATE TABLE board(
	bno number(8) PRIMARY KEY,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	writer varchar2(50) NOT NULL,
	regdate DATE DEFAULT sysdate 
	
);

CREATE SEQUENCE board_seq;

INSERT INTO board(bno, title, content, writer)
values(board_seq.nextval, 'title1', 'content1', 'user1');

INSERT INTO STUDENTTBL(name) values('홍길동');
INSERT INTO STUDENTTBL(name) values('성춘향');


-- Team(부모) 과 TeamMember(자식) 외래키 제약조건

-- insert : 부모 먼저 한다
INSERT INTO TEAM(TEAM_NAME) VALUES('vistory');
INSERT INTO TEAM(TEAM_NAME) VALUES('hope');

INSERT INTO TEAM_MEMBER (USER_NAME, TEAM_TEAM_ID) VALUES ('홍길동', 1);
INSERT INTO TEAM_MEMBER (USER_NAME, TEAM_TEAM_ID) VALUES ('성춘향', 2);

-- delete : 자식 먼저 한다.