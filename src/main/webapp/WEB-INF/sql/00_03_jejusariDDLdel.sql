
/* 시퀀스 삭제 */
DROP SEQUENCE SEQ_SALES_NUMBER;
DROP SEQUENCE SEQ_REPORT_NUMBER;
DROP SEQUENCE SEQ_MEMBER_NUMBER;
DROP SEQUENCE SEQ_NOTICE_NUMBER;
DROP SEQUENCE SEQ_SCRAP_NUMBER;

/* 테이블 삭제 */
ALTER TABLE REPORT
	DROP
		CONSTRAINT FK_SALES_TO_REPORT
		CASCADE;

ALTER TABLE SALES
	DROP
		CONSTRAINT FK_MEMBER_TO_SALES
		CASCADE;

ALTER TABLE SALES_IMG
	DROP
		CONSTRAINT FK_SALES_TO_SALES_IMG
		CASCADE;

ALTER TABLE NOTICE
	DROP
		CONSTRAINT FK_MEMBER_TO_NOTICE
		CASCADE;

ALTER TABLE SCRAP
	DROP
		CONSTRAINT FK_SALES_TO_SCRAP
		CASCADE;

ALTER TABLE FACTOR
	DROP
		CONSTRAINT FK_SALES_TO_FACTOR
		CASCADE;

ALTER TABLE REPORT
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE SALES
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE NOTICE
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE MEMBER
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE FACTOR
	DROP
		PRIMARY KEY
		CASCADE
		KEEP INDEX;

ALTER TABLE NOTICE_IMG
	DROP
		CONSTRAINT FK_NOTICE_TO_NOTICE_IMG
		CASCADE;

DROP INDEX PK_REPORT;

DROP INDEX PK_SALES;

DROP INDEX PK_NOTICE;

DROP INDEX PK_MEMBER;

DROP INDEX PK_FACTOR;

/* 신고게시판 */
DROP TABLE REPORT 
	CASCADE CONSTRAINTS;

/* 매물목록 */
DROP TABLE SALES 
	CASCADE CONSTRAINTS;

/* 매물이미지 */
DROP TABLE SALES_IMG 
	CASCADE CONSTRAINTS;

/* 공지사항 */
DROP TABLE NOTICE 
	CASCADE CONSTRAINTS;

/* 스크랩 */
DROP TABLE SCRAP 
	CASCADE CONSTRAINTS;

/* 회원 */
DROP TABLE MEMBER 
	CASCADE CONSTRAINTS;

/* 지수 */
DROP TABLE FACTOR 
	CASCADE CONSTRAINTS;

/* 공지사항이미지 */
DROP TABLE NOTICE_IMG 
	CASCADE CONSTRAINTS;