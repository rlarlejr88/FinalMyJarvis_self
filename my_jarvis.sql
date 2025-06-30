-- 회원 테이블
CREATE TABLE TBL_MEMBER (
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 회원고유번호
    MEMBER_ID VARCHAR2(30) NOT NULL,                             -- 아이디(Unique)
    MEMBER_PW VARCHAR2(100) NOT NULL,                            -- 비밀번호
    MEMBER_NAME VARCHAR2(50) NOT NULL,                           -- 이름
    MEMBER_STATUS CHAR(1)  DEFAULT 'Y' NOT NULL,                  -- 상태 'Y(기본값) 일반회원 / N 탈퇴회원 / A 관리자'
    MEMBER_EMAIL VARCHAR2(100) NOT NULL,                         -- 이메일
    MEMBER_PHONE VARCHAR2(20) NOT NULL,                          -- 전화번호
    JOIN_DATE DATE DEFAULT SYSDATE NOT NULL ,                     -- 회원가입일

    CONSTRAINT PK_TBL_MEMBER PRIMARY KEY (MEMBER_NO),            -- 기본키 제약조건
    CONSTRAINT UQ_TBL_MEMBER_ID UNIQUE (MEMBER_ID)               -- 아이디는 유니크
);

-- 회원 정보를 저장하는 핵심 테이블로, 대부분의 기능(계약, 고객, 일정 등)의 기준이 되는 중심 테이블입니다.
-- 각 컬럼은 회원 식별, 인증, 연락, 상태 관리에 필요한 정보를 포함합니다.
-- MEMBER_NO: 회원 고유 식별 번호. 전 시스템에서 공통으로 참조되는 PK입니다.
-- MEMBER_ID: 로그인용 아이디. 중복을 막기 위해 UNIQUE 제약을 설정했습니다.
-- MEMBER_STATUS: 회원 상태 코드. 'Y': 일반회원(기본값), 'N': 탈퇴회원, 'A': 관리자 구분용입니다.
-- JOIN_DATE: 회원 가입 일자. 기본값은 시스템 시간(SYSDATE)으로 자동 등록되도록 설정했습니다.
-- PK는 MEMBER_NO 단일 컬럼이며, 아이디 중복을 막기 위한 UQ 제약도 함께 설정되어 있습니다.


-- 계약 상태 테이블
CREATE TABLE TBL_CONTRACT_STATUS (
    STATUS_CODE VARCHAR2(20) NOT NULL,                       -- 계약 상태 코드 (예: 'W', 'C', 'X', 'T')
    STATUS_NAME VARCHAR2(50) NOT NULL,                       -- 상태 설명 (예: 대기, 확정, 취소 등)

    CONSTRAINT PK_TBL_CONTRACT_STATUS PRIMARY KEY (STATUS_CODE) -- 상태코드 단일 기본키
);

-- 계약 상태(W:대기, C:확정, X:취소 등)를 코드화해 관리하는 공통 코드 테이블입니다.
-- 상태코드는 다른 테이블(TBL_CONTRACT, TBL_SCHEDULE 등)에서 참조되므로 단일 PK로 설정합니다.


-- 고객사 테이블
CREATE TABLE TBL_CLIENT (
    CLIENT_NO VARCHAR2(20) NOT NULL,                             -- 고객 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 회원 고유번호 (등록자)
    CLIENT_NAME VARCHAR2(50) NOT NULL,                           -- 고객 이름
    CLIENT_PHONE VARCHAR2(20) NOT NULL,                          -- 고객 전화번호
    CLIENT_EMAIL VARCHAR2(100) NOT NULL,                         -- 고객 이메일
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                      -- 고객 등록일자

    CONSTRAINT PK_TBL_CLIENT PRIMARY KEY (CLIENT_NO, MEMBER_NO), -- 복합 기본키: 동일 회원이 보유한 고객 구분용
    CONSTRAINT FK_CLIENT_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO) -- 등록 회원 외래키
);

-- 개인 고객 정보를 저장하는 테이블입니다.
-- CLIENT_NO는 단일 기본키이며, 각 회원(MEMBER_NO)별로 구분됩니다.
-- CLIENT_NO와 MEMBER_NO는 복합 유니크 관계로 구성되어 있으며, 계약(CONTRACT), 회의(MEETING) 등에서 MEMBER_NO와 함께 외래키로 참조됩니다.
-- 개인 고객은 이름, 연락처, 이메일 등의 기본 정보를 갖고 있으며, 거래처 테이블과는 별도로 관리됩니다.


-- 거래처 테이블
CREATE TABLE TBL_COMPANY (
    COMP_CD VARCHAR2(20) NOT NULL,                              -- 거래처 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                            -- 회원 고유번호 (등록자)
    COMP_NAME VARCHAR2(100) NOT NULL,                           -- 거래처명
    COMP_TEL VARCHAR2(100),                                     -- 거래처 전화번호
    COMP_ADDR VARCHAR2(100),                                    -- 거래처 주소
    TRADE_STATUS CHAR(1)  DEFAULT '1' NOT NULL,                  -- 거래 상태 ('1': 거래, '2': 거래중지)
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                         -- 거래처 등록일자

    CONSTRAINT PK_TBL_COMPANY PRIMARY KEY (COMP_CD, MEMBER_NO), -- 복합 기본키: 동일 회원이 가진 거래처 구분
    CONSTRAINT FK_COMPANY_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO) -- 회원 외래키
);

-- 거래처(법인 고객) 정보를 저장하는 테이블입니다.
-- 거래처는 회원 단위로 등록되며, 동일한 거래처 코드(COMP_CD)라도 회원(MEMBER_NO)에 따라 별도로 존재할 수 있습니다.
-- 따라서 COMP_CD와 MEMBER_NO는 복합 기본키로 설정되어 있고, 계약 등 연계 테이블에서도 이 두 값을 함께 외래키로 참조합니다.


-- 태그 테이블
CREATE TABLE TBL_TAG (
    TAG_NO VARCHAR2(20) NOT NULL,                              -- 태그 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                           -- 회원 고유번호 (태그 생성자)
    TAG_NAME VARCHAR2(50) NOT NULL,                            -- 태그 이름
    TAG_COLOR VARCHAR2(20),                                    -- 태그 색상 (시각 구분용)
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                    -- 태그 등록일자

    CONSTRAINT PK_TBL_TAG PRIMARY KEY (TAG_NO, MEMBER_NO),     -- 복합 PK: 태그별 소유자 구분
    CONSTRAINT FK_TAG_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- 회원이 생성한 태그 정보를 저장하는 테이블입니다.
-- 동일한 TAG_NO가 여러 회원에게 존재할 수 있으므로, TAG_NO와 MEMBER_NO를 복합 PK로 사용합니다.
-- 태그 색상은 시각적 구분용이며, MEMBER_NO는 생성자를 나타내는 외래키입니다.


-- 파일첨부 테이블
CREATE TABLE TBL_FILE (
    FILE_NO VARCHAR2(20) NOT NULL,                               -- 파일 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 회원 고유번호 (업로더)
    FILE_ORIGIN VARCHAR2(255) NOT NULL,                          -- 원본 파일명 (사용자 업로드 이름)
    FILE_NAME VARCHAR2(255) NOT NULL,                            -- 서버 저장 파일명
    FILE_PATH VARCHAR2(500) NOT NULL,                            -- 파일 경로 (서버 내부 또는 URL)
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL ,                   -- 파일 등록일
    FILE_TABLE VARCHAR2(200) NOT NULL,                           -- 대상 테이블 명 ('contract', 'memo' 등)
    FILE_ID VARCHAR2(30) NOT NULL,                               -- 대상 테이블의 PK값
    FILE_SIZE NUMBER,                                            -- 파일 크기 (byte)
    FILE_DELETED CHAR(1) DEFAULT 'N' NOT NULL ,                   -- 삭제 여부 ('Y' / 'N')

    CONSTRAINT PK_TBL_FILE PRIMARY KEY (FILE_NO, MEMBER_NO),
    CONSTRAINT FK_FILE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- 다양한 테이블(계약, 메모 등)에 첨부된 파일 정보를 저장하는 테이블입니다.
-- FILE_TABLE은 연동 대상 테이블명을, FILE_ID는 해당 테이블의 PK값을 의미합니다.
-- 이를 통해 유연하게 여러 테이블과 연결되도록 설계하였으며, FK 제약은 걸지 않습니다.
-- 파일 업로더를 식별하기 위해 MEMBER_NO를 외래키로 연결하고, FILE_NO와 MEMBER_NO를 복합 PK로 사용하여 회원별 파일 구분이 가능합니다.


-- 메모 테이블
CREATE TABLE TBL_MEMO (
    MEMO_NO VARCHAR2(20) NOT NULL,                               -- 메모 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 회원 고유번호 (작성자)
    MEMO_TABLE VARCHAR2(30) NOT NULL,                            -- 메모 대상 테이블 유형 ('contract', 'schedule' 등)
    MEMO_ID VARCHAR2(30) NOT NULL,                               -- 메모 대상 테이블의 PK 값
    MEMO_CONTENT VARCHAR2(1000) NOT NULL,                        -- 메모 내용
    REG_DATE DATE DEFAULT SYSDATE NOT NULL,                      -- 메모 등록일자
    REVISE_DATE DATE,                                            -- 수정 일자 (NULL 허용)

    CONSTRAINT PK_TBL_MEMO PRIMARY KEY (MEMO_NO, MEMBER_NO),
    CONSTRAINT FK_MEMO_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- ERP 내 다양한 대상(계약, 일정 등)에 메모 기능을 부여하기 위한 테이블입니다.
-- MEMO_TABLE은 메모가 연동될 대상 테이블명을 나타내며, MEMO_ID는 해당 테이블의 PK값을 저장하여 유연하게 연결합니다.
-- FK는 걸지 않고, Java단에서 ENUM/상수 관리로 타입 일관성을 유지합니다.
-- MEMBER_NO는 작성자를 식별하기 위한 외래키입니다.
-- MEMO_NO와 MEMBER_NO를 복합 기본키로 사용하여 작성자 기준 고유 메모 관리가 가능합니다.


-- 거래처 구성원 테이블
CREATE TABLE TBL_COMPANY_MEMBER (
    CONTACT_IDX VARCHAR2(20) NOT NULL,                             -- 구성원 고유번호
    COMP_CD VARCHAR2(20) NOT NULL,                                 -- 거래처 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                               -- 회원 고유번호 (등록자)
    CONTACT_NAME VARCHAR2(30) NOT NULL,                            -- 담당자 이름
    CONTACT_EMAIL VARCHAR2(100),                                   -- 담당자 이메일
    CONTACT_PHONE VARCHAR2(20),                                    -- 담당자 전화번호
    IS_MAIN_CONTACT CHAR(3) DEFAULT 'N',                           -- 대표 여부 ('Y' / 'N')
    CONTACT_POSITION VARCHAR2(30),                                 -- 담당자 직책
    CONTACT_DEPT VARCHAR2(30),                                     -- 담당자 부서
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                            -- 구성원 등록일자

    CONSTRAINT PK_TBL_COMPANY_MEMBER PRIMARY KEY (CONTACT_IDX),    -- 구성원 고유 기본키
    CONSTRAINT FK_CM_COMP FOREIGN KEY (COMP_CD, MEMBER_NO) 
        REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO),                -- 거래처 복합 외래키 (COMP_CD + MEMBER_NO)
    CONSTRAINT FK_CM_MEMBER FOREIGN KEY (MEMBER_NO) 
        REFERENCES TBL_MEMBER(MEMBER_NO)                           -- 회원 외래키
);

-- 거래처(COMPANY)에 소속된 담당자 정보를 관리하는 테이블입니다.
-- CONTACT_IDX는 구성원 개별 식별자이며, 기본키로 사용됩니다.
-- 하나의 거래처(COMP_CD)는 여러 담당자를 가질 수 있으므로, COMP_CD + MEMBER_NO를 복합 외래키로 지정합니다.
-- IS_MAIN_CONTACT는 대표 담당자 여부를 표시하며, 내부 연락망이나 우선 발송 대상자 구분에 사용됩니다.
-- 거래처와 회원 간 등록 관계를 명확히 하기 위해 MEMBER_NO도 별도로 외래키로 연결되어 있습니다.


-- 계약 테이블
CREATE TABLE TBL_CONTRACT (
    CONTRACT_NO VARCHAR2(20) NOT NULL,                           -- 계약 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 회원 고유번호 (계약 등록자)
    COMP_CD VARCHAR2(20),                                        -- 거래처 고유번호 (법인 고객일 경우)
    CLIENT_NO VARCHAR2(20),                                      -- 개인 고객 고유번호
    STATUS_CODE VARCHAR2(20) NOT NULL,                           -- 계약 상태 코드 ('W', 'C', 'X', 'T')
    CONTRACT_TITLE VARCHAR2(100) NOT NULL,                       -- 계약 제목
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                      -- 계약 등록일자
    CONTRACT_START DATE NOT NULL,                                -- 계약 시작일
    CONTRACT_END DATE NOT NULL,                                  -- 계약 종료일
    CONTRACT_DEPOSIT NUMBER NOT NULL,                            -- 계약금
    CONTRACT_CONFIRM DATE,                                       -- 계약 확정일자

    CONSTRAINT PK_TBL_CONTRACT PRIMARY KEY (CONTRACT_NO),        --  단일 기본키
    CONSTRAINT UQ_CONTRACT_STATUS UNIQUE (CONTRACT_NO, STATUS_CODE), --  상태코드 보조 제약
    CONSTRAINT FK_CONTRACT_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_CONTRACT_CLIENT FOREIGN KEY (CLIENT_NO, MEMBER_NO) REFERENCES TBL_CLIENT(CLIENT_NO, MEMBER_NO),
    CONSTRAINT FK_CONTRACT_COMP     FOREIGN KEY (COMP_CD, MEMBER_NO) REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO),
    CONSTRAINT FK_CONTRACT_STATUS FOREIGN KEY (STATUS_CODE) REFERENCES TBL_CONTRACT_STATUS(STATUS_CODE)
);

-- 계약 정보를 저장하는 핵심 테이블입니다.
-- CONTRACT_NO는 단일 기본키로 사용되며, 각 계약을 고유하게 식별합니다.
-- 계약은 반드시 회원(MEMBER_NO)에 의해 등록되며, 계약 상대는 법인 고객(COMP_CD) 또는 개인 고객(CLIENT_NO) 중 하나일 수 있습니다.
-- 단, CLIENT_NO와 COMP_CD는 각각 MEMBER_NO와 복합 외래키로 연결되어, 해당 회원이 등록한 고객만 참조할 수 있습니다.
-- 계약 상태는 STATUS_CODE로 표현되며, 상태코드별 관리 및 통제를 위해 보조 UNIQUE 제약(CONTRACT_NO + STATUS_CODE)이 설정되어 있습니다.
-- 계약의 주요 정보로는 계약 제목, 계약금, 시작일, 종료일, 확정일이 포함되며, 등록일은 기본값으로 SYSDATE가 자동 설정됩니다.


-- 회의 테이블
CREATE TABLE TBL_MEETING (
    MEETING_NO VARCHAR2(20) NOT NULL,                         -- 회의 고유번호 (단일 PK)
    MEMBER_NO VARCHAR2(20) NOT NULL,                          -- 회원 고유번호 (작성자)
    CLIENT_NO VARCHAR2(20),                                   -- 개인 고객 고유번호 (nullable)
    COMP_CD VARCHAR2(20),                                     -- 거래처 고유번호 (nullable)
    MEET_TITLE VARCHAR2(100) NOT NULL,                        -- 회의 제목
    MEET_CONTENT CLOB NOT NULL,                               -- 회의 내용
    MEET_DATE DATE DEFAULT SYSDATE NOT NULL ,                  -- 회의 일자
    GPT_SUMMARY VARCHAR2(1024),                               -- AI 요약 내용

    CONSTRAINT PK_TBL_MEETING PRIMARY KEY (MEETING_NO),       -- 단일 기본키
    CONSTRAINT FK_MEETING_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_MEETING_CLIENT FOREIGN KEY (CLIENT_NO, MEMBER_NO) REFERENCES TBL_CLIENT(CLIENT_NO, MEMBER_NO),
    CONSTRAINT FK_MEETING_COMP FOREIGN KEY (COMP_CD, MEMBER_NO) REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO)
);

-- 고객과의 사전 커뮤니케이션(회의, 상담 등) 내용을 기록하는 테이블입니다.
-- MEETING_NO는 회의의 고유 식별자로 단일 PK로 설정되어 조회 및 관리가 용이합니다.
-- 회의 대상은 개인 고객(CLIENT_NO + MEMBER_NO) 또는 법인 거래처(COMP_CD + MEMBER_NO) 중 하나와 연동됩니다.
-- 작성자는 MEMBER_NO를 통해 TBL_MEMBER 테이블과 외래키로 연결됩니다.
-- CLIENT_NO와 COMP_CD는 동시에 NULL일 수 있으며, 둘 중 하나는 반드시 선택되어야 하므로 서비스 로직에서 XOR 조건으로 제어해야 합니다.


-- 태그맵 테이블
CREATE TABLE TBL_TAG_MAP (
    TAG_MAP_NO VARCHAR2(20) NOT NULL,                              -- 태그 매핑 고유번호
    TAG_NO VARCHAR2(20) NOT NULL,                                  -- 태그 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                               -- 태그 생성 회원 번호
    TAG_TABLE VARCHAR2(255) NOT NULL,                              -- 태그 대상 테이블 명 (예: 'contract', 'schedule' 등)
    TAG_ID VARCHAR2(30) NOT NULL,                                  -- 태그 대상 테이블의 PK 번호

    CONSTRAINT PK_TBL_TAG_MAP PRIMARY KEY (TAG_MAP_NO),           
    CONSTRAINT FK_TAGMAP_TAG FOREIGN KEY (TAG_NO, MEMBER_NO) REFERENCES TBL_TAG(TAG_NO, MEMBER_NO)
);

-- 다양한 대상 테이블에 태그를 연결하는 매핑 테이블입니다.
-- TAG_MAP_NO는 태그 매핑의 고유 식별자이며, 단일 PK로 구성됩니다.
-- TAG_NO와 MEMBER_NO는 함께 복합 외래키로 연결되며, TBL_TAG의 복합키(TAG_NO, MEMBER_NO)를 정확히 참조합니다.
-- 태그 대상 테이블은 TAG_TABLE과 TAG_ID를 통해 식별되며, 다형적 연동 구조로 설계되어 유연성을 제공합니다.


-- 일정표 테이블
CREATE TABLE TBL_SCHEDULE (
    SCHEDULE_NO VARCHAR2(20) NOT NULL,                            -- 일정 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                              -- 회원 고유번호 (일정 등록자)
    CONTRACT_NO VARCHAR2(20) NOT NULL,                            -- 계약 고유번호
    STATUS_CODE VARCHAR2(20) NOT NULL,                            -- 일정 상태코드 ('W', 'C', 'X', 'T')
    SCHEDULE_TITLE VARCHAR2(20) NOT NULL,                         -- 일정 제목
    SCHEDULE_START DATE NOT NULL,                                 -- 일정 시작일
    SCHEDULE_END DATE NOT NULL,                                   -- 일정 종료일
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                       -- 일정 등록일
    SCHEDULE_CONTENT VARCHAR2(1000),                              -- 일정 설명 내용
    SCHEDULE_PROGRESS NUMBER  DEFAULT 0 NOT NULL,                   -- 일정 진행률 (%), TBL_TASK와 연동
    SCHEDULE_COLOR VARCHAR2(20) NULL,                             -- 일정 색상 (캘린더용)
    SCHEDULE_ALERT CHAR(1)  DEFAULT 'N' NOT NULL,                  -- 알림 여부 ('Y' / 'N')

    CONSTRAINT PK_TBL_SCHEDULE PRIMARY KEY (SCHEDULE_NO),         --  단일 기본키
    CONSTRAINT UQ_SCHEDULE_UNIQUE UNIQUE (MEMBER_NO, CONTRACT_NO, STATUS_CODE), --  보조 유니크 설정
    CONSTRAINT FK_SCHEDULE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_SCHEDULE_CONTRACT FOREIGN KEY (CONTRACT_NO) REFERENCES TBL_CONTRACT(CONTRACT_NO),
    CONSTRAINT FK_SCHEDULE_STATUS FOREIGN KEY (STATUS_CODE) REFERENCES TBL_CONTRACT_STATUS(STATUS_CODE)
);

-- 계약에 따른 업무 일정을 캘린더 형태로 관리하기 위한 테이블입니다.
-- 각 일정은 SCHEDULE_NO로 구분되며, 등록자(MEMBER_NO)와 연결됩니다.
-- 일정은 반드시 하나의 계약(CONTRACT_NO)에 속하며, 상태코드(STATUS_CODE)는 별도 상태 테이블과 연동됩니다.
-- 일정 제목, 설명, 시작/종료일 외에도 진행률(SCHEDULE_PROGRESS)과 색상, 알림 여부 등의 시각적/기능적 속성을 포함합니다.
-- 동일 계약 내 중복 일정 방지를 위해 MEMBER_NO + CONTRACT_NO + STATUS_CODE에 유니크 제약조건이 추가됩니다.


-- 결제/청구 테이블
CREATE TABLE TBL_INVOICE (
    INVOICE_NO VARCHAR2(20) NOT NULL,                             -- 결제 고유번호
    CONTRACT_NO VARCHAR2(20) NOT NULL,                            -- 계약 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                              -- 회원 고유번호 (등록자)
    INVOICE_CLIENT VARCHAR2(200) NOT NULL,                        -- 수신인 이름 또는 회사명 (메일 발송용)
    INVOICE_EMAIL VARCHAR2(200) NOT NULL,                         -- 수신인 이메일
    INVOICE_DEPOSIT NUMBER NOT NULL,                              -- 결제 금액
    INVOICE_SEND DATE NOT NULL,                                   -- 청구서 발송일자
    INVOICE_IS_SEND CHAR(1) DEFAULT 'N' NOT NULL ,                 -- 발송 여부 ('Y' / 'N')
    INVOICE_PAID DATE,                                            -- 입금일자 (실제 입금 시점)
    INVOICE_IS_PAID CHAR(1) DEFAULT 'N' NOT NULL ,                 -- 입금 여부 ('Y' / 'N')
    INVOICE_METHOD VARCHAR2(50) NOT NULL,                         -- 입금 방식 (계좌이체, 카드결제 등)
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                       -- 청구서 생성일자

    CONSTRAINT PK_TBL_INVOICE PRIMARY KEY (INVOICE_NO, CONTRACT_NO, MEMBER_NO),
    CONSTRAINT FK_INVOICE_CONTRACT FOREIGN KEY (CONTRACT_NO) REFERENCES TBL_CONTRACT(CONTRACT_NO),
    CONSTRAINT FK_INVOICE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- 계약에 따른 청구/결제 정보를 관리하는 테이블입니다.
-- INVOICE_NO는 청구서 식별자이며, 계약(CONTRACT_NO), 등록자(MEMBER_NO)와 함께 복합 PK로 구성되어 있습니다.
-- 발송 여부(INVOICE_IS_SEND)와 입금 여부(INVOICE_IS_PAID)를 별도 관리하여 상태 추적이 가능합니다.
-- 입금 방식(INVOICE_METHOD), 발송일/입금일, 생성일자 등의 항목은 정산 흐름을 시각화하고 자동화하는 데 활용됩니다.
-- 계약(CONTRACT_NO) 및 작성자(MEMBER_NO)와 각각 외래키로 연결됩니다.


-- 작업관리 테이블
CREATE TABLE TBL_TASK (
    TASK_NO VARCHAR2(20) NOT NULL,                               -- 작업 고유번호
    SCHEDULE_NO VARCHAR2(20) NOT NULL,                           -- 연동된 일정 고유번호
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- 작업 등록자(회원 고유번호)
    TASK_TITLE VARCHAR2(100) NOT NULL,                           -- 작업 제목
    TASK_CONTENT VARCHAR2(3000) NOT NULL,                        -- 작업 상세 내용
    TASK_DUE DATE,                                               -- 작업 마감일
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                      -- 작업 등록일자
    TASK_COMPLETE CHAR(1) DEFAULT 'N' NOT NULL,                  -- 완료 여부 ('Y' / 'N')
    TASK_PRIORITY VARCHAR2(10) DEFAULT '중' NOT NULL,            -- 작업 우선순위 ('상', '중', '하')
    TASK_ALERT DATE,                                             -- 알림 발송일 (예: 마감 하루 전)

    CONSTRAINT PK_TBL_TASK PRIMARY KEY (TASK_NO),               
    CONSTRAINT FK_TASK_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_TASK_SCHEDULE FOREIGN KEY (SCHEDULE_NO) REFERENCES TBL_SCHEDULE(SCHEDULE_NO)
);


-- 일정(SCHEDULE)에 소속된 개별 작업(To-Do)을 관리하는 테이블입니다.
-- TASK_NO는 작업 고유 식별자로, 단일 기본키로 설정되어 있습니다.
-- 각 작업은 일정(SCHEDULE_NO)과 연결되며, 등록자(MEMBER_NO) 정보도 함께 저장됩니다.
-- 작업 제목, 상세 내용, 마감일(TASK_DUE), 등록일, 우선순위(TASK_PRIORITY), 완료 여부(TASK_COMPLETE) 등을 포함합니다.
-- TASK_ALERT는 마감 이전 알림 기능을 위한 속성입니다.
-- 일정 및 회원 테이블과 외래키로 연결되어 있어 일정 기반 작업 흐름 추적이 가능합니다.


--------------------------------------------------------------------------------

-- 계약번호(CONTRACT_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_CONTRACT_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 거래처코드(COMP_CD) 시퀀스
CREATE SEQUENCE SEQ_TBL_COMPANY_CD START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 개인고객번호(CLIENT_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_CLIENT_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 회의번호(MEETING_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_MEETING_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 일정번호(SCHEDULE_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_SCHEDULE_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 작업번호(TASK_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_TASK_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 청구번호(INVOICE_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_INVOICE_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 메모번호(MEMO_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_MEMO_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 태그번호(TAG_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_TAG_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 태그 매핑 번호(TAG_MAP_NO) 시퀀스
CREATE SEQUENCE SEQ_TBL_TAG_MAP_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- 거래처 구성원(CONTACT_IDX) 시퀀스
CREATE SEQUENCE SEQ_TBL_COMPANY_MEMBER_IDX START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


