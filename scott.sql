-- RDBMS 
-- 기본단위 : 테이블

-- EMP(사원정보 테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서번호)
-- NUMBER(4,0) : 전체 자릿수 4자리(소수점 자릿수 0)
-- VARCHAR2(10) : 문자열 10Byte (VAR : 가변 - 7byte 문자열 저장했다면 7byte 공간만 사용)
--                영어 10문자, 한글 2byte, utf-8 3byte 할당 
-- DATE : 날짜

-- DEPT(부서테이블)
-- deptno(부서번호), dname(부서명), loc(부서위치)

-- SALGRADE(급여테이블)
-- grade(급여등급), losal(최저급여), hisal(최대급여)

-- 개발자 : C(Insert)R(Read)U(Update)D(Delete)
-- SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어

-- sql 구문 실행 순서
-- 5. SELECT 
-- ① FROM
-- ② WHERE 
-- ③ GROUP BY
-- ④ HAVING
-- 6. ORDER by

-- 1. 조회(SELECT) - Read
-- 사원정보조회(전체조회)
-- * (모든 열)
SELECT * FROM EMP e; 

-- 특정 열 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e; 

-- 사원번호, 부서번호만 조회
SELECT e.EMPNO, e.DEPTNO FROM EMP e;

-- 중복 데이터는 제외하고 조회
SELECT DISTINCT deptno FROM emp;

SELECT DISTINCT job, deptno FROM emp;

-- 별칭
SELECT ename, sal, sal * 12 + comm annsal, comm
FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS "annsal", comm FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS annsal, comm FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS 연봉, comm FROM EMP;
-- 별칭에 공백이 들어가는 경우 ""로 반드시 묶어야 함
SELECT ename 사원명, sal 급여, sal * 12 + comm AS "연 봉", comm 수당 FROM EMP e;

-- 원하는 순서대로 출력 데이터를 정렬(오름,내림) 
-- 오름차순일 때 asc 생략 가능
-- emp 테이블의 모든 열을 급여 기준으로 오름차순 조회
SELECT
	*
FROM
	EMP e
ORDER BY
	e.SAL ASC; 

SELECT
	*
FROM
	EMP e
ORDER BY
	e.SAL; 
-- 내림차순
SELECT * FROM EMP e ORDER BY e.SAL DESC; 
-- 사번,이름,직무만 급여기준으로 내림차순 조회
SELECT e.EMPNO, e.ENAME,e.JOB FROM EMP e ORDER BY e.SAL DESC; 

-- 부서번호의 오름차순, 급여의 내림차순
SELECT * FROM EMP e ORDER BY e.DEPTNO ASC, e.SAL DESC;

-- 
SELECT
	e.EMPNO employee_no,
	e.ENAME employee_name,
	e.mgr manager,
	e.sal salary,
	e.comm commission,
	e.deptno department_no
FROM
	EMP e;

SELECT
	*
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ename ASC;

-- where : 조회 시 조건 부여
-- 부서번호가 30번인 사원 조회
SELECT *
FROM EMP e 
WHERE e.DEPTNO = 30;

-- 사번이 7782인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7782;

-- 부서번호가 30이고 직책이 SALESMAN 사원 조회
-- 오라클에서 문자는 '' 만 허용, 대소문자 구분
SELECT
	*
FROM
	EMP e
WHERE
	e.deptno = 30 AND e.job = 'SALESMAN';

-- 사번 7499 이고 부서번호가 30 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499 AND e.DEPTNO = 30;

-- 사번 7499 이거나 부서번호가 30 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499 OR e.DEPTNO = 30;

-- 연산자
-- 1) 산술연산자 : +,-,*,/
-- 2) 비교연산자 : >,<,>=,<=
-- 3) 등가비교연산자 : =, 같지않다(!=, <>, ^= )
-- 4) 논리부정연산자 : NOT
-- 5)             : IN
-- 6) 범위 : BETWEEN A AND B
-- 7) 검색 : LIKE 연산자와 와일드카드(_, %)
-- 8) IS NULL : 널과 같다
-- 9) 집합 연산자 : UNION,MINUS,INTERSECT

-- 연봉이(SAL*12) 36000 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal*12 = 36000;

-- 급여가 3000이상인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal >= 3000;

-- 급여가 2500이상이고 직업이 ANALYST 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal >= 2500 AND e.JOB = 'ANALYST';

-- 문자 대소비교
-- 사원명의 첫 문자가 F와 같거나 F보다 뒤에 있는 사원조회
SELECT *
FROM EMP e
WHERE e.ename >= 'F';


-- 급여가 3000이 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal != 3000;

SELECT *
FROM EMP e 
WHERE e.sal <> 3000;

SELECT *
FROM EMP e 
WHERE e.sal ^= 3000;

SELECT *
FROM EMP e 
WHERE NOT e.sal = 3000;

-- job 이 MANAGER 이거나, SALESMAN 이거나, CLERK 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK';

-- in 연산자로 변경
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER','SALESMAN','CLERK');


SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN ('MANAGER','SALESMAN','CLERK');

-- BETWEEN A AND B
-- 급여 2000 이상 3000이하
SELECT * FROM EMP E WHERE E.SAL >= 2000 AND E.SAL <= 3000;

SELECT * FROM EMP E WHERE E.SAL BETWEEN 2000 AND 3000;

-- 급여 2000 이상 3000이하가 아닌 사원 조회
SELECT * FROM EMP E WHERE E.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE : 검색
-- _ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

-- 사원명이 S 로 시작하는 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE 'S%';

-- 사원이름의 두번째 글자가 L 인 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '_L%';

-- 사원명에 AM 이 포함된 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '%AM%';

-- 사원명에 AM 이 포함되지 않은 사원 조회
SELECT * FROM EMP E WHERE E.ENAME NOT LIKE '%AM%';

-- IS NULL
-- COMM이 NULL 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.COMM IS NULL;

-- MGR이 NULL 인 사원(= 직속상관이 없는) 조회
SELECT *
FROM EMP e 
WHERE e.MGR IS NULL;

-- 직속 상관이 있는 사원 조회
SELECT *
FROM EMP e 
WHERE e.MGR IS NOT NULL;

-- 집합연산자 
-- UNION(합집합)
-- 부서번호 10, 20 사원조회(OR, IN)
SELECT * FROM EMP e WHERE e.DEPTNO = 10 OR e.DEPTNO=20;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);

SELECT e.EMPNO, e.ename, e.sal FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO, e.ename, e.sal FROM EMP e WHERE e.DEPTNO = 20;

-- 타입 일치만 확인 => 타입이 맞는다면 연결
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.sal, e.job, e.DEPTNO, e.empno FROM EMP e WHERE e.DEPTNO = 20;

-- UNION(중복 제외하고 출력), UNION ALL(중복 데이터도 출력)
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION ALL 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

-- MINUS(차집합)

SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e
MINUS 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.deptno = 10;


-- INTERSECT(교집합)
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e
INTERSECT 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.deptno = 10;

-- 오라클 함수
-- 내장함수
-- 1) 문자함수
-- 대소문자를 바꿔주는 함수 : upper(), lower(), initcap()
-- 문자의 길이를 구하는 함수 : LENGTH(), LENGTHB()
-- 문자열 일부 추출 : SUBSTR(문자열데이터,시작위치,추출길이)
-- 문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR()
-- 특정문자를 다른 문자로 변경 : REPLACE(원본문자열,찾을문자열,변경문자열)
-- 두 문자열 데이터를 합치기 : CONCAT(문자열1, 문자열2), ||
-- 특정 문자 제거 : TRIM(), LTRIM(), RTRIM()


-- 사원이름을 대문자, 소문자, 첫문자만 대문자로 변경
SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME)
FROM EMP e; 

-- 제목 oracle 검색
-- LIKE '%oracle%' OR LIKE '%ORACLE%' OR LIKE '%Oracle%'
--SELECT * 
--FROM board
--WHERE upper(title) = upper('oracle')

-- 사원명 길이 구하기
SELECT e.ENAME, LENGTH(e.ENAME)
FROM EMP e ;

-- 사원명이 5글자 이상인 사원 조회
SELECT *
FROM EMP e
WHERE LENGTH(e.ename) >= 5;

-- LENGTHB() : 문자열 바이트 수 반환
-- XE 버전 : 한글에 3BYTE 사용
-- dual : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용)
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- 시작위치 지정 시 양수(왼쪽) 1, 음수(오른쪽부터) : 맨 끝부터 -1
SELECT E.JOB, SUBSTR(E.JOB,1,2), SUBSTR(E.JOB,5)
FROM EMP e; 

SELECT
	E.JOB,
	SUBSTR(E.JOB,-LENGTH(E.JOB)),
	SUBSTR(E.JOB,-LENGTH(E.JOB), 2),
	SUBSTR(E.JOB,-3)
FROM
	EMP e;

-- INSTR(대상문자열,위치를 찾으려는문자,시작위치,시작위치에서 찾으려는 문자가 몇 번째인지)
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM
	DUAL;

-- 사원 이름에 S 가 있는 사원 조회
SELECT *
FROM EMP e WHERE e.ENAME LIKE '%S%';

SELECT *
FROM EMP e WHERE INSTR(e.ename, 'S') > 0;

-- REPLACE(원본문자열,찾을문자열,변경문자열)
SELECT
	'010-1234-5678' AS REPLACE_BEFORE,
	REPLACE('010-1234-5678', '-', ' ') AS REPLACE1,
	REPLACE('010-1234-5678', '-') AS REPLACE2
FROM
	DUAL;

-- 사번 : 사원명 
SELECT CONCAT(e.EMPNO, CONCAT(' : ',e.ENAME))
FROM EMP e; 

SELECT e.EMPNO || ' : ' || e.ENAME
FROM EMP e;


-- TRIM(삭제옵션(선택), 삭제할문자(선택) FROM 원본문자열(필수))
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS trim_leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM
	DUAL;

-- LTRIM(), RTRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	'[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim,
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2
FROM
	DUAL;

-- 숫자함수
-- 반올림 : ROUND()
-- 버림 : TRUNC()
-- 가장 큰 정수 : CEIL()
-- 가장 작은 정수 : FLOOR()
-- 나머지 : MOD()

--    -2 -1 0 1 2
-- 1 2 3 4  . 5 6 7 8

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND1,
	ROUND(1234.5678, 1) AS ROUND2,
	ROUND(1234.5678, 2) AS ROUND3,
	ROUND(1234.5678, -1) AS ROUND4,
	ROUND(1234.5678, -2) AS ROUND5
FROM
	DUAL;


SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC1,
	TRUNC(1234.5678, 1) AS TRUNC2,
	TRUNC(1234.5678, 2) AS TRUNC3,
	TRUNC(1234.5678, -1) AS TRUNC4,
	TRUNC(1234.5678, -2) AS TRUNC5
FROM
	DUAL;


SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;


SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;

-- 날짜함수
-- 오늘날짜/시간 : SYSDATE
-- 몇개월 이후 날짜 구하기 : ADD_MONTHS()
-- 두 날짜 간의 개월 수 차이 구하기 : MONTHS_BETWEEN()
-- 돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY() / LAST_DAY()


SELECT
	SYSDATE AS NOW,
	SYSDATE-1 YESTERDAY,
	SYSDATE+1 AS TOMORROW,
	CURRENT_DATE AS CURRENT_DATE,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL;

-- 오늘날짜를 기준으로 3개월 이후 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년 넘은 사원 조회
SELECT *
FROM EMP e 
WHERE ADD_MONTHS(E.HIREDATE, 480) < SYSDATE;

-- 오늘날짜와 입사일자의 차이 구하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	sysdate,
	MONTHS_BETWEEN(e.HIREDATE, sysdate) AS month1,
		MONTHS_BETWEEN(sysdate, e.HIREDATE) AS month2,
			TRUNC(MONTHS_BETWEEN(e.HIREDATE, sysdate)) AS month3
FROM
	EMP e;


SELECT sysdate, NEXT_DAY(sysdate, '월요일'), LAST_DAY(sysdate)
FROM dual;

-- 자료형을 변환하는 형변환 함수
-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
-- TO_NUMBER() : 문자열 데이터를 숫자 데이터로 반환
-- TO_DATE() : 문자열 데이터를 날짜 데이터로 반환


-- number + '문자숫자' : 덧셈 가능(자동형변환)
SELECT e.EMPNO, e.ename, e.empno + '500'
FROM EMP e 
WHERE E.ENAME = 'SMITH';

--SELECT e.EMPNO, e.ename, e.empno + 'abcd'
--FROM EMP e 
--WHERE E.ENAME = 'SMITH';

SELECT sysdate, to_char(sysdate, 'YYYY/MM/DD')
FROM dual;


SELECT
	sysdate,
	to_char(sysdate, 'MM'),
	to_char(sysdate, 'MON'),
	to_char(sysdate, 'MONTH'),
	to_char(sysdate, 'DD'),
	to_char(sysdate, 'DY'),
	to_char(sysdate, 'DAY'),
	to_char(sysdate, 'HH24:MI:SS'),
	to_char(sysdate, 'HH12:MI:SS AM'),
	to_char(sysdate, 'HH:MI:SS PM')
FROM
	dual;

-- 9 : 숫자 한자리를 의미
-- 0 : 숫자 한자리를 의미(빈자리를 0으로 채움)
SELECT e.SAL, TO_CHAR(e.sal, '$999,999'), TO_CHAR(e.sal, '$000,999,999')
FROM EMP e; 


-- 문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300 + '1500'
FROM dual;

SELECT '1300'-'1500'
FROM dual;

-- ORA-01722: 수치가 부적합합니다
SELECT '1,300'-'1,500'
FROM dual;


-- TO_NUMBER('문자열데이터','인식할숫자형태')
SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999')
FROM dual;

-- TO_DATE() : 문자열데이터 => 날짜형식으로 변경
SELECT
	TO_DATE('2025-03-20', 'YYYY-MM-DD') AS DATE1,
	TO_DATE('2025-03-20', 'YYYY/MM/DD') AS DATE2
FROM
	DUAL;


-- NULL
-- 산술연산이나 비교연산자(IS NULL OR IS NOT NULL)가 제대로 수행되지 않음
-- 1) NVL(널여부를 검사할 데이터,널일때 반환할데이터)
-- 2) NVL2(널여부를 검사할 데이터,널이아닐때 반환할 데이터,널일때 반환할데이터)

SELECT e.EMPNO, e.ENAME, e.sal, e.comm, e.sal+e.comm,  NVL(e.comm, 0), e.sal + nvl(e.comm,0)
FROM EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.sal,
	e.comm,
	e.sal + e.comm,
	NVL2(e.comm, 'O', 'X'),
	NVL2(e.comm, e.sal * 12 + e.COMM, e.SAL*12) AS 연봉
FROM
	EMP e;

-- 자바의 if, switch 구문과 유사
-- DECODE
-- DECODE(검사대상이 될 데이터, 
--        조건1, 조건1 만족시 반환할 결과,
--        조건2, 조건2 만족시 반환할 결과,
--        조건1~조건n 일치하지 않을때 반환할 결과
-- )
-- CASE
-- CASE 검사대상이 될 데이터 
--     WHEN  조건1 THEN 조건1 만족시 반환할 결과
--     WHEN  조건2 THEN 조건2 만족시 반환할 결과
--     ELSE  조건1~조건n 일치하지 않을때 반환할 결과
-- END

-- 직책이 MANAGER 인 사원은 급여의 10% 인상
-- 직책이 SALESMAN 인 사원은 급여의 5% 인상
-- 직책이 ANALYST 인 사원은 동결
-- 나머지는 3% 인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(e.job, 'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALYST', e.SAL,
	e.SAL * 1.03
	) AS upsal
FROM
	EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.job
	 WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS upsal
FROM
	EMP e;

-- 단일 그룹의 그룹 함수가 아닙니다(해결 : group by 절에 사용한 컬럼만 가능)
-- SELECT e.ENAME, sum(e.sal), FROM EMP E;

-- 결과값을 원하는 열로 묶어 출력 : GROUP BY

-- 부서별 평균 급여 조회
SELECT e.deptno,  AVG(e.sal )
FROM EMP e 
GROUP BY e.DEPTNO ;

-- 부서별, 직책별 평균 급여 조회
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;

-- 결과값을 원하는 열로 묶어 출력할 때 조건 추가 : GROUP BY + HAVING

-- 부서별, 직책별 평균 급여 조회 + 평균급여 >= 2000 
SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB HAVING AVG(e.SAL) >= 2000
ORDER BY e.DEPTNO;

-- SQL Error [934] [42000]: ORA-00934: 그룹 함수는 허가되지 않습니다
-- where절 그룹함수 안됨
-- SELECT e.DEPTNO, e.JOB, AVG(e.SAL)
-- FROM EMP e 
-- WHERE AVG(e.SAL) >= 2000
-- GROUP BY e.DEPTNO, e.JOB 
-- ORDER BY e.DEPTNO;


-- 같은 직무에 종사하는 사원이 3명 이상인 직책과 인원 수 출력
-- SALESMAN 4
SELECT E.JOB , COUNT(E.EMPNO)
FROM EMP e  
GROUP BY E.JOB HAVING COUNT(E.EMPNO) >= 3
ORDER BY E.JOB;


-- 아원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- 1987년 20부서 2명 
-- 1987   30     1 
SELECT TO_CHAR(E.HIREDATE, 'YYYY'), E.DEPTNO, COUNT(E.EMPNO)
FROM EMP e 
GROUP BY TO_CHAR(E.HIREDATE, 'YYYY'), E.DEPTNO;

-- 조인(join)
-- 여러 종류의 데이터를 다양한 테이블에 나누어 저장하기 떄문에 여러 테이블의 데이터를 조합하여
-- 출력할 때가 많다. 이때 사용하는 방식이 조인
-- 종류

-- 내부조인(연결 안되는 데이터는 제외) - inner join
-- 1. 등가조인 : 각 테이블의 특정 열과 일치하는 데이터를ㄹ 기준으로 추출
-- 2. 비등가조인 : 등가조인 외의 방식
-- 3. 자체(self)조인 : 같은 테이블끼리 조인

-- 외부조인 : 연결 안되는 데이터 보기 - outer join
-- 1. 왼쪽외부조인 (left outr join) : 오른쪽 테이블의 데이터 존재 여부와 상관없이 왼쪽테이블 기준으로 출력
-- 2. 오른쪽외부조인(right outer join) : 왼쪽 테이블의 데이터 존재 여부와 상관없이 오른쪽테이블 기준으로 출력



-- 사원별 부서정보 조회
SELECT *
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.EMPNO, e.DEPTNO, d.DEPTNO, d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- 나올 수 있는 모든 조합 출력
SELECT e.EMPNO, e.DEPTNO, d.DEPTNO, d.LOC
FROM EMP e , DEPT d 

-- 사원별 부서정보 조회 + 사원별 급여 >= 3000
SELECT e.EMPNO, e.DEPTNO, e.sal, d.DEPTNO, d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >= 3000;

-- 사원별 부서정보 조회 + 사원별 급여 <= 2500 + 사원번호 9999 이하
SELECT e.EMPNO, e.DEPTNO, e.sal, d.DEPTNO, d.LOC
FROM EMP e , DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL <= 2500 AND e.EMPNO <= 9999;

-- 비등가조인
-- 사원별 부서정보 + salgrade grade 
SELECT *
FROM EMP e , SALGRADE s 
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL;

SELECT *
FROM EMP e , SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 자체조인
-- 사원정보 + 직속상관 정보 
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO;

-- left outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO(+);

-- right outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR(+) = e2.EMPNO;

-- 표준문법을 사용한 join
-- join ~ on : inner join
-- join 테이플명 on 조인하는 조건

-- inner 생략가능
SELECT e.EMPNO, e.DEPTNO, d.DEPTNO, d.LOC
FROM EMP e JOIN DEPT d on e.DEPTNO = d.DEPTNO;

SELECT
	*
FROM
	EMP e
INNER JOIN SALGRADE s 
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- left outer join 테이블명 on 조인조건
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
LEFT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;


SELECT *
FROM emp e1 JOIN EMP e2 ON e1.EMPNO  = e2.EMPNO JOIN EMP e3 ON e2.EMPNO = e3.EMPNO; 


-- 급여가 2000을 초과한 사원의 부서정보, 사원정보 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 급여
SELECT e.EMPNO, e.DEPTNO, e.SAL , e.ENAME, d.DNAME
FROM EMP e JOIN DEPT d ON d.DEPTNO  = e.DEPTNO 
WHERE e.SAL > 2000
ORDER BY e.DEPTNO;

-- 모든 부서정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 직무, 급여
SELECT e.EMPNO, e.DEPTNO, e.SAL , e.ENAME, d.DNAME, e.JOB
FROM EMP e JOIN DEPT d ON d.DEPTNO  = e.DEPTNO 
ORDER BY e.DEPTNO, e.EMPNO;

-- 모든 부서정보, 사원정보, 급여등급정보, 각 사원의 직속상관 정보를 
-- 부서번호, 사원번호 순서로 정렬하여 출력
-- 출력) 부서번호, 부서명, 사원번호, 사원명, 매니저번호, 급여, losal, hisal, grade, 매니저empno, 매니저이름
SELECT
	e1.DEPTNO,
	d.DNAME,
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e1.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE,
	e2.ENAME AS mgr_empno,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 ON
	e1.MGR = e2.EMPNO
JOIN DEPT d ON
	e1.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e1.sal BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	e1.DEPTNO,
	e1.EMPNO;


-- 부서별 평균급여, 최대급여, 최소급여, 사원 수 출력
-- 부서번호, 부서명, avg_sal, min_sal, cnt
SELECT E.DEPTNO, D.DNAME, AVG(E.SAL) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(E.EMPNO) AS CNT
FROM EMP e JOIN DEPT d  ON E.DEPTNO  = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;

-- 서브쿼리 : SQL 구문을 실행하는 데 필요한 데이터를 추가로 조회하고자 SQL 구문 내부에서 사용하는 SELECT 문
-- 연산자 등의 비교 또는 조회 대상 오른쪽에 놓이며 괄호로 묶어서 사용
-- 특수한 몇몇 경우를 제외한 대부분의 서브쿼리에서는 ORDER BY 절을 사용할 수 없다.
-- 서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정
-- 서브쿼리에 있는 SELECT 문의 결과 행 수는 함께 사용하는 메인 쿼리의 연산자 종류와 어울려야 한다

-- 1) 단일행 서브쿼리 : 실행결과가 행 하나인 서브쿼리
--  		연산자 : >, >=, <, <=, <>, ^=, !=

-- 2) 다중행 서브쿼리 : 실행결과가 여러개의 행인 서브쿼리
--			연산자 : in, any(some), all, exists 	

-- 3) 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 비교할 데이터를 여러개 지정
-- 			연산자 : 


-- 이름이 JONES 인 사원의 급여보다 높은 급여를 받는 사원 조회

-- JONES 의 급여 조회
SELECT e.SAL FROM EMP e WHERE e.ENAME = 'JONES';

-- JONES 보다 많이 받는 사원 조회
SELECT * FROM EMP e WHERE E.SAL > 2975;

-- 서브쿼리로 변경 (쿼리 안에 또 다른 쿼리가 들어감.) / 단일행 서브쿼리
SELECT * FROM EMP e WHERE E.SAL > (SELECT e.SAL FROM EMP e WHERE e.ENAME = 'JONES');

-- ALLEN 보다 빨리 입사한 사원 조회
SELECT * FROM EMP e WHERE E.HIREDATE < (SELECT e.HIREDATE  FROM EMP e WHERE e.ENAME = 'ALLEN');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보(사번, 이름, 직무, 급여)
-- 소속부서정보(부서번호, 부서명, 부서위치) 조회
SELECT
	E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
FROM
	EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO
WHERE
	E.DEPTNO = 20
	AND E.SAL > (
	SELECT
		AVG(E.SAL)
	FROM
		EMP e );

-- 전체사원의 평균 급여 보다 적거나 같은 급여를 받는 20번 부서의 정보를 조회
 SELECT
	E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
FROM
	EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO
WHERE
	E.DEPTNO = 20
	AND E.SAL <= (
	SELECT
		AVG(E.SAL)
	FROM
		EMP e );

-- 다중행 서브쿼리

-- 부서별 최고 급여와 같은 급여를 받는 사원 조회
-- 1) 부서별 최고 급여 
SELECT MAX(E.SAL)
FROM EMP e GROUP BY E.DEPTNO

SELECT * FROM EMP E WHERE E.SAL IN (3000, 2850, 5000);

-- 서브쿼리 사용
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL IN (
	SELECT
		MAX(E.SAL)
	FROM
		EMP e
	GROUP BY
		E.DEPTNO);

-- ANY, SOME : 서브쿼리가 반환한 여러 결과값 중 메인 쿼리와 조건식을 사용한 결과가 하나라도 TRUE 라면
-- 			   메인쿼리 조건식을 TRUE 로 반환

-- IN 과 같은 효과를 =ANY(=SOME)로 가능 (BUT, IN을 더 많이 사용)
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL = ANY (
	SELECT
		MAX(E.SAL)
	FROM
		EMP e
	GROUP BY
		E.DEPTNO);

-- < ANY, < SOME

-- 30번 부서의 (최대)급여보다 적은 급여를 받는 사원조회(단일행)
-- 
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL < (SELECT MAX(E.SAL) FROM EMP e WHERE E.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

-- 30번 부서의 (최대)급여보다 적은 급여를 받는 사원조회(다중행)
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL < ANY (SELECT E.SAL FROM EMP e WHERE E.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;


-- ALL : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리의 조건식이 TRUE



-- 30번 부서의 (최대)급여보다 적은 급여를 받는 사원조회(단일행)
SELECT * FROM EMP e WHERE E.SAL < (SELECT MIN(E.SAL) FROM EMP e WHERE e.DEPTNO = 30);

-- 30번 부서의 급여보다 적은 급여를 받는 사원조회(다중행)
SELECT * FROM EMP e WHERE E.SAL < ALL (SELECT E.SAL FROM EMP e WHERE e.DEPTNO = 30);


-- EXISTS : 서브쿼리에 결과값이 하나 이상 있으면 조건식이 모두 TRUE, 없으면 FALSE 

SELECT * FROM EMP e WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

SELECT * FROM EMP e WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 50); 

-- 비교할 열이 여러개인 다중열 서브쿼리

-- 부서별 최고 급여와 같은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP E
WHERE
	(E.DEPTNO, E.SAL) IN (
	SELECT
		E.DEPTNO, MAX(E.SAL)
	FROM
		EMP e
	GROUP BY
		E.DEPTNO);

-- SELECT 절에 사용하는 서브쿼리 (결과가 반드시 하나만 반환)
-- 사원정보, 급여등급, 부서명 조회(조인)

SELECT
	E.EMPNO,
	E.JOB,
	E.SAL,
	(
	SELECT
		S.GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL ) AS SALGRADE,
	E.DEPTNO,
	(
	SELECT
		D.DNAME 
	FROM
		DEPT d
	WHERE
		E.DEPTNO = D.DEPTNO ) AS DNAME
FROM
	EMP e;


-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사원정보(사번, 이름, 직무)
-- 부서정보(부서번호, 부서명, 위치) 조회
SELECT
	E.ENAME,
	E.EMPNO,
	E.JOB,
	D.DEPTNO,
	D.DNAME,
	D.LOC
FROM
	EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO
WHERE
	E.JOB 
NOT IN (
	SELECT
		E.JOB
	FROM
		EMP e
	WHERE
		E.DEPTNO = 30) AND E.DEPTNO = 10;



-- 직책이 SALESMAN 인 사람의 최고급여보다 많이 받는 사람의 사원정보, 급여등급정보를 조회
-- 다중행 함수를 사용하는 방법과 사용하지 않는 밥법 2가지로 작성
-- 출력 : 사번, 이름, 급여, 등급

-- 다중행 하무를 사용하지 않는 방법
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	(
	SELECT
		S.GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL )AS SALGRADE
FROM
	EMP e
WHERE
	E.SAL
> (
	SELECT
		MAX(E.SAL)
	FROM
		EMP e
	WHERE
		E.JOB = 'SALESMAN')
ORDER BY
	E.EMPNO ;

-- 다중행 함수 사용
SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	(
	SELECT
		S.GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL )AS SALGRADE
FROM
	EMP e
WHERE
	E.SAL
> ALL(
	SELECT
		E.SAL
	FROM
		EMP e
	WHERE
		E.JOB = 'SALESMAN')
ORDER BY
	E.EMPNO ;



-- C(Insert) : 삽입
-- INSERT INTO 테이블명(필드명, 필드명, ....)  / 필드명 생략 가능 할 때가 있고 아닐떄가 있음.
-- VALUES(값1, 값2, ...)

-- 필드명 생략은 테이블의 현재 열 순서대로 나열되었다고 가정하고 데이터 처리

-- 기존 테이블 복사 후 새 테이블로 생성
CREATE TABLE dept_temp AS SELECT * FROM dept;

INSERT INTO dept_temp(deptno, dname, LOC)
VALUES(50, 'DATABASE', 'SEOUL');

INSERT INTO dept_temp
VALUES(60, 'NETWORK', 'BUSAN');

INSERT INTO dept_temp
VALUES('70', 'NETWORK', 'BUSAN');



-- 값의 수가 충분하지 않습니다.
-- 값의 수가 너무 많습니다
INSERT INTO dept_temp(deptno, dname, LOC)
VALUES('NETWORK', 'BUSAN', 'NETWORK', 'BUSAN');

-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
-- Number(2, 0)
INSERT INTO dept_temp
VALUES(600, 'NETWORK', 'BUSAN');

-- null을 넣는 방법.
INSERT INTO dept_temp
VALUES(80, 'NETWORK', null);

INSERT INTO dept_temp(deptno, dname)
VALUES(90, 'NETWORK');


-- 열 구조만 복사 후 새 테이블 생성
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1<>1;

-- 날짜데이터 삽입 : 'YYYY-MM-DD'  OR 'YYYY/MM/DD'
INSERT INTO EMP_TEMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2020-12-13', 5000, 1000, 10);

INSERT INTO EMP_TEMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(3111, '성춘향', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);


-- emp, salgrade 급여 등급이 1인 사원들만 emp_temp 추가하기 -> values 대신 select 문 사용
INSERT
	INTO
	EMP_TEMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
SELECT
	e.*
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
	AND s.GRADE = 1


-- U(Update)
-- update 테이블명
-- set 변경할열 = 값, 변경할열 = 값,.....
-- where 데이터를 변경할 대상 해을 선별하는 조건 나열
-- 90번 부서의 loc seoul로 변경
UPDATE dept_temp
SET LOC = 'SEOUL'
WHERE DEPTNO = 90;


UPDATE dept_temp
SET LOC = 'SEOUL';	

-- COMMIT;
-- ROLLBACK;
	
	
-- 40번 부서의 부서명, 위치 변경
-- dept 테이블 40번 부서랑 동일
UPDATE dept_temp
SET (dname, LOC ) = (SELECT DNAME, loc FROM dept WHERE DEPTNO = 40)
WHERE deptno =40;
	
-- 50번 부서의 dname, loc 변경
UPDATE dept_temp
SET LOC = 'BOSTON', DNAME = 'SALES'
WHERE DEPTNO = 50;
	
	
-- D(Delete) : 삭제
--DELETE FROM 테이블명
--WHERE 삭제할 조건
	
--DELETE 테이블명
--WHERE 삭제할 조건
DELETE FROM dept_temp 
WHERE deptno = 70;

-- loc가 seoul 데이터 삭자
DELETE DEPT_TEMP 
WHERE loc = 'SEOUL';


DELETE EMP_TEMP 
WHERE SAL >= 100;

DELETE EMP_TEMP;


CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;	
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;	
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;	

-- DEPT 테이블에 다음 데이터를 삽입하기
-- 50, ORACLE, BUSAN
-- 60, SQL, ISLAN
-- 70, SELECT, INCHEON
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT 
VALUES(60, 'SQL', 'ISLAN');

INSERT INTO EXAM_DEPT 
VALUES(50, 'ORACLE', 'BUSAN');

INSERT INTO EXAM_DEPT 
VALUES(70, 'SELECT', 'INCHEON');

INSERT INTO EXAM_DEPT 
VALUES(80, 'DML', 'BUNDANG');


-- EXAM_EMP 테이블에 다음 데이터 삽입하기
-- 7201, USER1, MANAGER, 7788, 2016-02-01, 4500, NULL, 50
-- 7202, USER2, CLERK, 7201, 2016-02-16, 1800, NULL, 50
-- 7203, USER3, ANALYST, 7201, 2016-04-11, 3400, NULL, 60
-- 7204, USER4, SALESMAN, 7201, 2016-05-31, 2700, 300, 60
-- 7205, USER5, CLERK, 7201, 2016-07-20, 2600, NULL, 70
-- 7206, USER6, CLERK, 7201, 2016-09-08, 2600, NULL, 70
-- 7207, USER7, LECTURER, 7201, 2016-10-28, 2300, NULL, 80
-- 7208, USER8, STUDENT, 7201, 2018-03-09, 1200, NULL, 80
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7201, 'USER1', 'MANAGER', 7788, '2016-02-01', 4500, NULL, 50);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7202, 'USER2', 'CLERK', 7201, '2016-02-16', 1800, NULL, 50);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7203, 'USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 60);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7204, 'USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7205, 'USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7206, 'USER6', 'CLERK', 7201, '2016-09-08', 2600, NULL, 70);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7207, 'USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 80);
INSERT INTO EXAM_EMP(empno, ENAME, JOB, MGR, HIREDATE, sal, COMM, DEPTNO)
VALUES(7208, 'USER8', 'STUDENT', 7201, '2018-03-09', 1200, NULL, 80);


-- EXAM_EMP 에서 50번 부서에서 근무하는 사원의 평균 급여보다 많이 받는 사원을 70번 부서로 옮기는 SQL 작성
UPDATE
	EXAM_EMP
SET
	deptno = 70
WHERE
	SAL > (
	SELECT
		AVG(SAL)
	FROM
		EXAM_EMP
	WHERE
		DEPTNO = 50);

-- EXAM_EMP에서 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 
-- 급여를 10% 인상하고 80번 부서로 옮기는 SQL 구문 작성
UPDATE
	EXAM_EMP
SET
	sal = sal * 1.1,
	deptno = 80
WHERE
	HIREDATE > (
	SELECT
		MIN(HIREDATE)
	FROM
		EXAM_EMP
	WHERE
		DEPTNO = 60);

-- EXAM_EMP 에서 급여등급이 5인 사원을 삭제하는 SQL 구문 작성
DELETE
	EXAM_EMP
WHERE
	empno IN (
	SELECT
		EMPNO
	FROM
		EXAM_EMP e
	JOIN EXAM_SALGRADE s ON
		e.SAL BETWEEN s.LOSAL AND s.HISAL
		AND s.GRADE = 5);

-- 트랜잭션 : ALL or NOTHING (전부 수행 OR 전부 취소)
-- DML(데이터 조작어) : INSERT, UPDATE, DELETE 

-- COMMIT(전부 실행) / ROLLBACK(전부 취소)

INSERT INTO DEPT_TEMP VALUES(30, 'DATABASE', 'SEOL');
UPDATE  DEPT_TEMP SET LOC = 'BUSAN' WHERE DEPTNO =30;
DELETE FROM DEPT_TEMP WHERE DNAME = 'RESERCH';

COMMIT;

ROLLBACK;

-- 세션 : 데이터베이스 접속 후 작업을 수행한 후 접속을 종료하기까지 전체 기간

SELECT * FROM EMP e;

DELETE FROM DEPT_TEMP WHERE deptno = 30;
COMMIT ;


-- DDL(데이터 정의어) : 객체를 생성, 변경, 삭제
-- 1. 테이블 생성 : CREATE
-- 2. 		 변경 : ALTER
-- 3. 		 삭제 : DROP
-- 4. 테이블 전체 데이터 삭제 : TRUNCATE
-- 5. 테이블 이름 변경 : RENAME

-- CREATE TABLE 테이블명(
-- 		컬럼명1 자료형,
-- 		컬럼명2 자료형,
-- 		컬럼명3 자료형,
-- )

-- 테이블명 규칙 
-- 문자로 시작 (영문자, 한글, 숫자 가능)
-- 테이블 이름은 30 byte 이하 
-- 같은 사용자 안에서는 테이블명 중복 불가
-- SQL 예약어(SELECT, FROM,...)는 테이블 이름으로 사용할 수 없음

-- VARCHAR2(14) : 영어 14문자, 한글 4문자
-- NUMBER(7, 2) : 전체자리수 7, 소수점 2자리 포함.(앞에 자리는 5자리 사용 가능.)

CREATE TABLE DEPT_DDL(
	DEPTNO NUMBER(2, 0),
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4, 0),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4, 0),
	HIREDATE DATE,
	SAL NUMBER(7, 2),
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2, 0)
);



-- 기존 테이블 구조와 데이터를 이용한 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;

-- 기존 테이블 구조만 이용해 새 테이블 생성(데이터 안가져옴.)
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP WHERE 1<>1;


-- ALTER : 테이블 변경
-- 1) 열 추가
-- 2) 열 이름 변경
-- 3) 열 자료형 변경
-- 4) 특정 열 삭제 


-- HP 열 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);

-- HP -> TEL 변경
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

-- EMPNO 자리수 4 => 5
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

ALTER TABLE EMP_DDL MODIFY ENAME VARCHAR2(8);

ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(3);

-- 정도 또는 자리수를 축소할 열이 비어 있어야 합니다
-- ALTER TABLE EMP_TEMP MODIFY EMPNO NUMBER(3);

-- 특정 열 삭제
ALTER TABLE EMP_DDL DROP COLUMN TEL;


-- 테이블 이름 변경
RENAME EMP_DDL TO EMP_RENAME;


-- 테이블 데이터 삭제 
-- DELETE FROM EMP_RENAME; ==> ROLLBACK 가능
TRUNCATE TABLE EMP_RENAME; --> ROLLBACK 불가능

-- 테이블 제거
DROP TABLE EMP_RENAME;

-- MEMBER 테이블 생성하기
-- ID VARCHAR2(8) / NAME 10 / ADDR 50 / EMAIL 30 / AGE NUMBER(4)
CREATE TABLE NUMBER_EMP(
	ID VARCHAR2(8),
	NAME VARCHAR2(10),
	ADDR VARCHAR2(50),
	EMAIL VARCHAR2(30),
	AGE NUMBER(4, 0)
);

-- MENBER 테이블 열 추가
-- BIGO 열 추가 (문자열, 20)
ALTER TABLE NUMBER_EMP ADD BIGO VARCHAR2(20);

-- BIGO 열 크기를 30으로 변경
ALTER TABLE NUMBER_EMP MODIFY BIGO VARCHAR2(30);
-- BIGO 열 이름을 REMARK로 변경
ALTER TABLE NUMBER_EMP RENAME COLUMN BIGO TO REMARK;

RENAME NUMBER_EMP TO MEMBER;


-- 오라클 객체
-- 1. 오라클 데이터베이스 테이블 
-- 		1) 사용자 테이블
-- 		2) 데이터 사전 - 중요한 데이터(사용자, 권한, 메모리, 성능...) : 일반 사용자가 접근하는 곳은 아님
-- 			user_*, all_*, dba_*, v$_*
-- 2. 인덱스 : 검색을 빠르게 처리 
-- 		1) FULL SCAN
--		2) INDEX SCAN
-- 3. view : 가상 테이블
-- 		-> 물리적으로 저장된 테이블은 아님.

SELECT * FROM dict;

-- scott 계정이 가진 table 조회
SELECT table_name
FROM user_tables;


-- 인덱스 조회
SELECT * FROM USER_INDEXES;


-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(열이름 ASC OR DESC, 열이름...)

CREATE INDEX IDX_EMP_TEMP_SAL ON EMP_TEMP(SAL);

-- 인덱스 삭제 
DROP INDEX IDX_EMP_TEMP_SAL;


-- 뷰(view)
-- 권한을 가진 사용자만 생성 가능
-- 보안성 : 특정 열을 노출하고 싶지 않을 때 
-- 편리성 : select 문의 복잡도 완화
-- CREATE VIEW 뷰이름(열이름1, 열이름2,...) AS (저장할 SELECT 구문)

CREATE VIEW vw_emp20 AS (
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 20);

DROP VIEW VW_EMP20;












