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

SELECT *
FROM team t1_0
WHERE t1_0.TEAM_ID =?;

SELECT *
FROM team t1_0
LEFT JOIN TEAM_MEMBER tm1_0 ON t1_0.TEAM_ID = tm1_0.TEAM_ID
WHERE tm



-- todo 완료 목록
SELECT *
FROM TODO t 
WHERE t.COMPLETED = 1;

-- todo 미완료 목록
SELECT *
FROM TODO t 
WHERE t.COMPLETED = 0;

-- todo 중요 목록
SELECT *
FROM TODO t 
WHERE t.IMPORTANTED = 1;




--board 조회

-- wrier 가 user4 게시물 조회
SELECT * FROM BOARD b WHERE b.WRITER ='writer4';

-- title 이 board Title1 게시물 조회
SELECT * FROM BOARD b  WHERE b.TITLE ='title1';

-- Title 단어가 들어간 게시물 조회
SELECT * FROM BOARD b  WHERE b.TITLE  LIKE '%title%'



--	JPA_ITEM 테이블
-- 집계함수 : sum, count, avg, max, min
-- sum,avg,max,min : price
-- count : 아이템 개수

SELECT COUNT(*), SUM(ji.PRICE),AVG(ji.PRICE), MAX(ji.PRICE), MIN(ji.PRICE)
FROM JPA_ITEM ji ;


--Team, TeamMember

SELECT *
FROM TEAM_MEMBER tm JOIN TEAM t ON tm.TEAM_ID =t.TEAM_ID
WHERE tm.TEAM_ID =2;


-- 두 개의 테이블 조인
SELECT
	*
FROM
	ORDERS o
JOIN MART_MEMBER mm ON
	o.MEMBER_ID = mm.MEMBER_ID;

-- 세개의 테이블 조인
SELECT
	*
FROM
	ORDERS o
JOIN MART_MEMBER mm ON
	o.MEMBER_ID = mm.MEMBER_ID
JOIN ORDER_ITEM oi ON
	o.ORDER_ID = oi.ORDER_ID ;


-- 동일한 주문 번호에 주만한 상품의 총 개수, 주문 내역 조회
SELECT oi.ORDER_ID , count(oi.ORDER_ID) AS cnt 
FROM ORDER_ITEM oi
GROUP BY oi.ORDER_ID;

-- ORDER_ITEM + ORDERS
-- oi.ORDER_ID , count(oi.ORDER_ID) AS cnt, ORDER_STATUS
SELECT
	o.ORDER_ID ,
	o.ORDER_STATUS, 
	A.cnt
FROM
	ORDERS o
LEFT JOIN (
	SELECT
		oi.ORDER_ID  AS oid,
		count(oi.order_id) AS cnt
	FROM
		ORDER_ITEM oi 
	GROUP BY
		oi.ORDER_ID) A ON
	o.order_id = A.oid;

-- select 절
SELECT
	o.ORDER_ID ,
	o.ORDER_STATUS,
	(
	SELECT
		count(oi.order_id)
	FROM
		ORDER_ITEM oi
	WHERE
		o.ORDER_ID = oi.order_id
	GROUP BY
		oi.ORDER_ID) As cnt
	FROM
		orders o;


-- 더미 데이터 
INSERT INTO BOOKTBL(PRICE, AUTHOR, CREATED_DATE, TITLE, UPDATED_DATE)
(SELECT PRICE, AUTHOR, CREATED_DATE, TITLE, UPDATED_DATE FROM BOOKTBL b );

SELECT count(*) FROM BOOKTBL b ;
	

-- board 조회
-- bno, title, reply개수, createdDate
SELECT b.BNO, b.TITLE, b.CREATED_DATE
FROM BOARDDBL b;
	
SELECT r.BOARD_ID, COUNT(r.RNO)
FROM REPLY r 
GROUP BY r.BOARD_ID;


SELECT 
	b.BNO,
	b.TITLE,
	(
	SELECT
		COUNT(r.RNO)
	FROM
		REPLY r
	WHERE
		r.BOARD_ID = b.BNO
	GROUP BY
		r.BOARD_ID) AS reply_cnt,
	b.CREATED_DATE,
	bm.NAME
FROM
	BOARDDBL b JOIN BOARD_MEMBER bm ON bm.EMAIL = b.MEMBER_ID;
	

















































