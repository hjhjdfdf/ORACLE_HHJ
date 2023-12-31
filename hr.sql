
-- 커서 실행 단축키 : ctrl + enter
-- 문서 전체 실행 : F5
SELECT 1+1
FROM dual;



-- 1. 계정 접속 명령어
-- conn 계정명/비밀번호;
conn system/123456;

-- 2. 
-- SQL 은 대/소문자 구분이 없다.
-- 명령어 키워드 대문자, 식별자는 소문자를 주로 사용한다. (각자 스타일대로)
SELECT user_id, username
FROM all_users;
-- WHERE user_name = 'HR';

-- HR 계정 생성하기
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO HR;


-- 3.
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오.
DESC employees;

-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를 조회하는 SQL 문을 작성하시오.
-- * 사원테이블의 사원번호와, 이름을 조회
SELECT employee_id, first_name
FROM employees;

-- 4.
-- 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
-- * 한글 별침을 부여하여 조회

-- AS (alias) : 출력되는 컬럼명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호"   -- 띄어쓰기가 있으면, " " 로 표기
     , first_name AS 이름          -- AS 생략 가능
     , last_name AS 성
     , email AS 이메일
     , phone_number AS 전화번호
     , hire_date AS 입사일자
     , salary AS 급여
FROM employees;

--
SELECT *        -- (*) [에스터리크] : 모든 컬럼 지정
FROM employees;


-- 5.
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
-- * DISTINCT 컬럼명 : 중복된 데이터를 제거하고 조회하는 키워드
SELECT DISTINCT job_id
FROM employees;


-- 6.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- * WHERE 조건 : 조회 조건을 작성하는 구문
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8.
-- 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고, FIRST_NAME 을 기준으로 오름차순 정렬
-- 하여 조회하는 SQL 문을 작성하시오.

-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC];
-- * ASC   : 오름차순
-- * DESC  : 내림차순
-- * (생략) : 오름차순이 기본값
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 9.테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시
오.
-- OR : "이거나", "또는"
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
   OR job_id = 'IT_PROG';
   

-- 10. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시
오.
-- 단, IN 키워드를 사용하시오.
-- * 컬럼명 IN ('A', 'B')   : OR 연산을 대체하여 사용 할 수 있는 키워드

SELECT *
FROM employees
WHERE job_id In ('FI_ACCOUNT', 'IT_PROG');


-- 11. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하
시오.
--  단, IN 키워드를 사용하시오.

SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG');


-- 12. 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- AND 연산 : ~이면서, 그리고, 동시에
-- WHERE A AND B;
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND salary >= 6000
  ;
  
  
-- 13. 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- LIKE : * 컬럼명 LIKE '와일드카드';
-- %    : 여러 문자 대체
-- _    : 한 문자 대체

SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14. s 로 끝나는

SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. s가 포함되는

SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16. 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.

SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH (컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;


-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NULL
;

-- 18. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
;

-- 19. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= '04/01/01'     -- SQL Developter 에서 문자형 데이터를 날짜형 데이터로 자동 변환
;

-- TO.DATE() : 문자형 데이터를 날짜형 데이터로 변환하는 함수
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD')
;

-- 20. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD')
  AND hire_date <= TO_DATE('20051231', 'YYYYMMDD')
  ;
  
 -- 칼럼 BETWEEN A AND B;
 -- : A보다 크거나 같고 B 보다 작거나 같은 조건 (사이)
 SELECT *
 FROM employees
 WHERE hire_date BETWEEN TO_DATE('20040101', 'YYYYMMDD') AND TO_DATE('20051231', 'YYYYMMDD')
 ;
 
 SELECT *
 FROM employees
 WHERE hire_date BETWEEN '04/01/01' AND '05/12/31'
 ;
   