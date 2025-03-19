-- employee (scott의 emp와 동일개념)
-- first_name, last_name, job_id 조회
SELECT e.FIRST_NAME, e.LAST_NAME, e.JOB_ID
FROM EMPLOYEES e ;

-- job_id 중복제외 후 조회
SELECT DISTINCT e.JOB_ID
FROM EMPLOYEES e ;

-- 사번이 176인 사원의 last_name 과 부서번호 조회
SELECT  e.LAST_NAME, e.DEPARTMENT_ID  
FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 176;

-- 급여 12000 이상되는 사원의 last_name과 급여를 조회
SELECT e.LAST_NAME, e.SALARY
FROM EMPLOYEES e 
WHERE e.SALARY >= 12000;

-- 급여가 5000~12000 범위가 아닌 사원의 last_name과 급여를 조회
SELECT e.LAST_NAME, e.SALARY
FROM EMPLOYEES e 
WHERE NOT (e.SALARY >= 5000 AND e.SALARY <= 12000) ;

-- BETWEEN A AND B
SELECT e.LAST_NAME, e.SALARY
FROM EMPLOYEES e 
WHERE e.SALARY NOT BETWEEN 5000 AND 12000 ;

-- IN 
-- 20, 50 번 부서에 근무하는 사원 조회 (lAST_NAME, 부서번호), LAST_NAME 오름차순
SELECT
	E.LAST_NAME,
	E.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	E.DEPARTMENT_ID IN (20, 50) 
	ORDER BY E.LAST_NAME ASC;

-- SALARY가 2500, 3500, 7000이 아니며, 직무가 SA_REP, ST_CLERK가 아닌 사원 조회
SELECT *
FROM EMPLOYEES e 
WHERE E.SALARY NOT IN(2500, 3500, 7000) AND E.JOB_ID NOT IN('SA_REP', 'ST_CLERK');

-- 날짜 데이터 '' 사용
-- 고용일이 2014년 사원 조회(2014-01-01 ~ 2014-12-31)
SELECT *
FROM EMPLOYEES e 
WHERE E.HIRE_DATE  >= '2014-01-01' AND E.HIRE_DATE <='2014-12-31';

SELECT *
FROM EMPLOYEES e 
WHERE E.HIRE_DATE  BETWEEN'2014-01-01' AND '2014-12-31';

--LIKE 
--LAST_NAME 에 u가 포함되는 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.LAST_NAME LIKE '%u%';

-- last_name 의 4번째 글자가 a 인 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.LAST_NAME LIKE '___a%';

-- last_name 에 a 혹은 e 글자가 있는 사원들의 사번, last_name 조회(last_name 내림차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.LAST_NAME LIKE '%a%' 
	OR e.LAST_NAME LIKE '%e%'
	ORDER BY e.LAST_NAME desc;

-- last_name 에 a 와 e 글자가 있는 사원들의 사번, last_name 조회(last_name 내림차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.LAST_NAME LIKE '%a%e%' 
	AND e.LAST_NAME LIKE '%e%a%'
	ORDER BY e.LAST_NAME desc;

-- IS NULL
-- 메니저가 없는 사원들의 LAST_NAME, JOB_ID 조회
SELECT E.LAST_NAME, E.JOB_ID
FROM EMPLOYEES e 
WHERE E.MANAGER_ID IS NULL;

-- ST_CLERK인 직업을 가진 사원이 없는 부서 번호 조회(단, 부서번호가 널 값인 부서 제외)
SELECT DISTINCT T E.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE E.JOB_ID NOT LIKE 'ST_CLERK'
	AND E.DEPARTMENT_ID IS NOT NULL;

-- COMMISSION_PCT가 NULL이 아닌 사원들 중에서 COMMISSION=SALARY * COMMISSION_PCT를 구한다
-- 계산 결과와 함께 사번, FIRST_NAME, JOB_ID 출력
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.JOB_ID, E.SALARY * E.COMMISSION_PCT AS COMMISSION
FROM EMPLOYEES e 
WHERE E.COMMISSION_PCT IS NOT NULL;


-- FIRST_NAME이 'Curtis'인 사람의 first_name과 last_name, email, phone_numbr, job_id 조회
-- 단, job_id 결과는 소문자로 출력
SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL, e.PHONE_NUMBER, LOWER(e.JOB_ID) AS job_id
FROM EMPLOYEES e 
WHERE e.FIRST_NAME = 'Curtis';


-- 부서번호가 60, 70, 80, 90,인 사원들의 사번, first_name, last_name, hire_date, job_id 조회
-- 단, job_id가 IT_PROG인 사원의 경우 '프로그래머'로 변경하여 출력한다
SELECT e.DEPARTMENT_ID , e.FIRST_NAME, e.LAST_NAME, e.HIRE_DATE, REPLACE(e.JOB_ID, 'IT_PROG' ,'프로그래머') job_id
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID  IN (60, 70, 80, 90);


-- job_id가 AD_PRES, PU_CLERK인 사원들의 사번, first_name, last_name, 부서번호, job_id 조회
-- 단, 사원명은 first_name, last_name 을 연결하여 출력한다 (예 Douglas Grant)
SELECT e.EMPLOYEE_ID, e.FIRST_NAME || ' ' || e.LAST_NAME AS name, e.DEPARTMENT_ID, e.JOB_ID
FROM EMPLOYEES e 
WHERE e.JOB_ID  IN ('AD_PRES', 'PU_CLERK');

-- 입사 10주년이 되는 날짜 출력
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE, ADD_MONTHS(E.HIRE_DATE, 120) 
FROM EMPLOYEES e 


















































