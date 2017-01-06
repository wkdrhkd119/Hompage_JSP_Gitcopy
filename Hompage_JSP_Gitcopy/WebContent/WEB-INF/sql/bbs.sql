CREATE TABLE bbs ( 
  bbsno   NUMBER(7)     NOT NULL,  -- 글 일련 번호, -9999999 ~ +9999999 
  wname   VARCHAR(20)   NOT NULL,  -- 글쓴이 
  title   VARCHAR(100)  NOT NULL,  -- 제목(*) 
  content VARCHAR(4000) NOT NULL,  -- 글 내용 
  passwd  VARCHAR(15)   NOT NULL,  -- 비밀 번호 
  viewcnt NUMBER(5)     DEFAULT 0, -- 조회수, 기본값 사용 
  wdate   DATE          NOT NULL,  -- 등록 날짜, sysdate 
  grpno   NUMBER(7)     DEFAULT 0, -- 부모글 번호 
  indent  NUMBER(2)     DEFAULT 0, -- 답변여부,답변의 깊이
  ansnum  NUMBER(5)     DEFAULT 0, -- 답변 순서 
  PRIMARY KEY (bbsno)  
); 

--filename 추가
alter table bbs
add(filename varchar(50) null,
	filesize number 	 default 0);
	
select * from bbs

--부모글 번호를 저장할 컬럼 추가(답변있는 부모글 삭제시 확인)
alter table bbs
add(refno number default 0);
 
select bbsno, grpno, indent, ansnum, refno from BBS
order by grpno desc, ansnum

delete from bbs;
 
2. 글 추가(C: Create) 
 
- MAX(bbsno): bbsno 컬럼에서 최대값을 추출 
SELECT MAX(bbsno) as max FROM bbs; 
 
 MAX 
 ---- 
 NULL <- 값이 없는 경우 
 
 
SELECT MAX(bbsno)+1 as max FROM bbs;  
 
 MAX 
 ---- 
 NULL <- 사칙연산이 의미가 없음. 
 
  
- NVL(): null 값을 0으로 변경 가능함. 
SELECT NVL(MAX(bbsno), 0) as max FROM bbs; 
 
 MAX 
 --- 
   0 
   
 
- 새로운 번호의 생성   
SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs; 
 
BBSNO 
 ----- 
     1 
 
     
- 서브쿼리를 이용한 레코드 추가 
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, grpno)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'왕눈이', '제목', '내용', '123', sysdate,(SELECT NVL(MAX(grpno), 0)+1 from bbs));                 
 
 
         
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum, r   
from( 
	SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum,rownum r   
	from(   
		SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
		FROM bbs  
		--where title like '%름'
		ORDER BY grpno DESC, ansnum
	)
)where r>=1 and r<=5


 
 BBSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM 
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------ 
     1 왕눈이   제목    내용      123          0 2013-10-31 20:46:18.0     0      0      0 
 
     
----total
select count(*) from bbs
where wname like '%왕눈이%'
      
4. 조회수 증가 
UPDATE bbs 
SET viewcnt = viewcnt + 1 
WHERE bbsno=1; 
 
 
 
5. 1건의 글 보기(R:Read, PK 사용) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE bbsno = 1; 
 
 PDSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM FILENAME FILESIZE 
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------ -------- -------- 
     1 왕눈이   제목    내용      123          0 2013-10-21 21:07:30.0     0      0      0 file.txt        0 
 
 
 
 
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
-- PK 수정, PK는 중복 충돌이 발생 할 수 있음으로 변경을 권장하지 않음.  
   
-- 일반 컬럼의 변경, 일반적인 UPDATE임    
UPDATE bbs 
SET wname='왕눈이', title='비오는날', content='개구리 연못' 
WHERE bbsno = 1; 
 
 PDSNO WNAME TITLE CONTENT PASSWD VIEWCNT WDATE                 GRPNO INDENT ANSNUM  
 ----- ----- ----- ------- ------ ------- --------------------- ----- ------ ------  
     1 아로미   제목2   내용2     123          0 2013-10-21 21:07:30.0     0      0      0 
 
     
-- 패스워드 검사 
SELECT COUNT(bbsno) as cnt 
FROM bbs 
WHERE bbsno=1 AND passwd='123'; 
 
 CNT 
 --- 
   1 
      
      
 
7. 글 삭제(D:Delete)
--부모글인지 확인하기, 결과값이 0이상이면 부모글이 존재.
--0이면 부모글이 아님
select count(refno) from bbs
where refno = 30

-- 모든 레코드 삭제
DELETE FROM bbs; 
 
-- 1번 레코드만 삭제
DELETE FROM bbs WHERE bbsno=1; 
 
 
 
8. 답변 
 
1) 모든 레코드 삭제 
DELETE FROM bbs; 
 
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----   -----    ----- ------ ------ 
     1  부모글1     1      0      0 
 
      
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----  -----    ----- ------ ------ 
     2  부모글2      2      0      0 
     1  부모글1      1      0      0 
 
      
 BBSNO  TITLE            GRPNO INDENT ANSNUM 
 -----  -----            ----- ------ ------ 
     4  부모글4            4      0      0    
     3  부모글3            3      0      0      
     2  부모글2            2      0      0 
     1  부모글1            1      0      0 
       
 
4) 부모글(일반적인 글) 등록 
 
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, 
grpno)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'왕눈이', '부모글3', '내용', '123', sysdate,
(SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM bbs)
);                 
 
         
SELECT bbsno, title, grpno, indent, ansnum 
FROM bbs  
ORDER BY grpno DESC, ansnum ASC; 
  
     
5) 답변처리
--read(부모의 title,grpno,indent,ansnum) : 첫번째
select bbsno, title, grpno, indent, ansnum
from bbs
where bbsno=2 --부모의 글
 
 BBSNO TITLE   GRPNO INDENT ANSNUM
 ----- ----- - ---- ------ ------
     2 부모글1       2      0      0
     
--답변등록(부모의grpno,부모+1 -> indent,ansnum): 세번째
INSERT INTO bbs(bbsno, wname, title, content, passwd, wdate, 
grpno,indent,ansnum)  
VALUES((SELECT NVL(MAX(bbsno), 0) + 1 as bbsno FROM bbs), 
'아로미', '부모글1 답변글2', '내용', '123', sysdate,2,1,1);
 
     
--부모글의 2차이상의 답변인 경우 ansnum(답변의 순서) 재정렬 :두번째
UPDATE bbs 
SET ansnum = ansnum + 1 
WHERE grpno=2 AND ansnum > 0; 
 
 
--------------------------------------------------------------------      
 
  
9. 검색 글 목록(S:Search List), title 컬럼에 '제목'이란  
   단어가 들어가 있는 레코드 검색 
    
  
기타)  
- WHERE title LIKE '%독도%': 독도라는 문자열이 발견되면 전부 해당(*)  
- WHERE title LIKE '독도%' : 독도로 시작하는 문자열 검색 
- WHERE title LIKE '%독도' : 독도로 끝나는 문자열 검색 
- WHERE title LIKE '독도'  : 독도와 일치하는 문자열 검색 
- WHERE title = '독도'     : 독도와 일치하는 문자열 검색, LIKE '독도' 동일 
- WHERE title = '__독도'   : 한국독도, 동해독도와 같은 패턴의 문자열 검색 
 
 
1) 성명 검색 글 목록(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE wname LIKE '%왕눈이%' 
ORDER BY bbsno DESC;  
 
 
2) 제목 검색 글 목록(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE title LIKE '%독도%' 
ORDER BY bbsno DESC;  
 
 
 
3) 내용 검색 글 목록(S:Search List) 
SELECT bbsno, wname, title, content, passwd, viewcnt, wdate, grpno, indent, ansnum 
FROM bbs  
WHERE content LIKE '%독도%' 
ORDER BY bbsno DESC;  
 
 
 
4) 파이프 기호를 통한 SQL 결합 
SELECT ('A' || 'B' || 'C' || 'D') as "grade" 
FROM dual; 
 
 grade 
 ----- 
 ABCD 
  
 
SELECT ('등록자: ' || wname) as "wname"  
FROM bbs; 
 
 wname 
 --------- 
 등록자: 홍길동 
 등록자: 홍길동 
 등록자: 홍길동 
 등록자: 홍길동 