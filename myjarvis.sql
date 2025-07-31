-- ȸ�� ���̺�
CREATE TABLE TBL_MEMBER (
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- ȸ��������ȣ
    MEMBER_ID VARCHAR2(30) NOT NULL,                             -- ���̵�(Unique)
    MEMBER_PW VARCHAR2(100) NOT NULL,                            -- ��й�ȣ
    MEMBER_NAME VARCHAR2(50) NOT NULL,                           -- �̸�
    MEMBER_STATUS CHAR(1)  DEFAULT 'Y' NOT NULL,                  -- ���� 'Y(�⺻��) �Ϲ�ȸ�� / N Ż��ȸ�� / A ������'
    MEMBER_EMAIL VARCHAR2(100) NOT NULL,                         -- �̸���
    MEMBER_PHONE VARCHAR2(20) NOT NULL,                          -- ��ȭ��ȣ
    JOIN_DATE DATE DEFAULT SYSDATE NOT NULL ,                     -- ȸ��������
    MEMBER_COMP_NAME VARCHAR2(100),			-- ȸ�� ��ȣ��
    MEMBER_COMP_NO VARCHAR2(100),			-- ȸ������ڹ�ȣ

    CONSTRAINT PK_TBL_MEMBER PRIMARY KEY (MEMBER_NO),            -- �⺻Ű ��������
    CONSTRAINT UQ_TBL_MEMBER_ID UNIQUE (MEMBER_ID)               -- ���̵�� ����ũ
);

-- ȸ�� ������ �����ϴ� �ٽ� ���̺��, ��κ��� ���(���, ��, ���� ��)�� ������ �Ǵ� �߽� ���̺��Դϴ�.
-- �� �÷��� ȸ�� �ĺ�, ����, ����, ���� ������ �ʿ��� ������ �����մϴ�.
-- MEMBER_NO: ȸ�� ���� �ĺ� ��ȣ. �� �ý��ۿ��� �������� �����Ǵ� PK�Դϴ�.
-- MEMBER_ID: �α��ο� ���̵�. �ߺ��� ���� ���� UNIQUE ������ �����߽��ϴ�.
-- MEMBER_STATUS: ȸ�� ���� �ڵ�. 'Y': �Ϲ�ȸ��(�⺻��), 'N': Ż��ȸ��, 'A': ������ ���п��Դϴ�.
-- JOIN_DATE: ȸ�� ���� ����. �⺻���� �ý��� �ð�(SYSDATE)���� �ڵ� ��ϵǵ��� �����߽��ϴ�.
-- PK�� MEMBER_NO ���� �÷��̸�, ���̵� �ߺ��� ���� ���� UQ ���൵ �Բ� �����Ǿ� �ֽ��ϴ�.



-- ��� ���� ���̺�
CREATE TABLE TBL_CONTRACT_STATUS (
    STATUS_CODE VARCHAR2(20) NOT NULL,                       -- ��� ���� �ڵ� (��: 'W', 'C', 'X', 'T')
    STATUS_NAME VARCHAR2(50) NOT NULL,                       -- ���� ���� (��: ���, Ȯ��, ��� ��)

    CONSTRAINT PK_TBL_CONTRACT_STATUS PRIMARY KEY (STATUS_CODE) -- �����ڵ� ���� �⺻Ű
);

-- ��� ����(W:���, C:Ȯ��, X:��� ��)�� �ڵ�ȭ�� �����ϴ� ���� �ڵ� ���̺��Դϴ�.
-- �����ڵ�� �ٸ� ���̺�(TBL_CONTRACT, TBL_SCHEDULE ��)���� �����ǹǷ� ���� PK�� �����մϴ�.


-- ���� ���̺�
CREATE TABLE TBL_CLIENT (
    CLIENT_NO VARCHAR2(20) NOT NULL,                             -- �� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- ȸ�� ������ȣ (�����)
    CLIENT_NAME VARCHAR2(50) NOT NULL,                           -- �� �̸�
    CLIENT_PHONE VARCHAR2(20) NOT NULL,                          -- �� ��ȭ��ȣ
    CLIENT_EMAIL VARCHAR2(100) NOT NULL,                         -- �� �̸���
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                      -- �� �������

    CONSTRAINT PK_TBL_CLIENT PRIMARY KEY (CLIENT_NO, MEMBER_NO), -- ���� �⺻Ű: ���� ȸ���� ������ �� ���п�
    CONSTRAINT FK_CLIENT_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO) -- ��� ȸ�� �ܷ�Ű
);

-- ���� �� ������ �����ϴ� ���̺��Դϴ�.
-- CLIENT_NO�� ���� �⺻Ű�̸�, �� ȸ��(MEMBER_NO)���� ���е˴ϴ�.
-- CLIENT_NO�� MEMBER_NO�� ���� ����ũ ����� �����Ǿ� ������, ���(CONTRACT), ȸ��(MEETING) ��� MEMBER_NO�� �Բ� �ܷ�Ű�� �����˴ϴ�.
-- ���� ���� �̸�, ����ó, �̸��� ���� �⺻ ������ ���� ������, �ŷ�ó ���̺���� ������ �����˴ϴ�.


-- �ŷ�ó ���̺�
CREATE TABLE TBL_COMPANY (
    COMP_CD VARCHAR2(20) NOT NULL,                              -- �ŷ�ó ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                            -- ȸ�� ������ȣ (�����)
    COMP_NAME VARCHAR2(100) NOT NULL,                           -- �ŷ�ó��
    COMP_TEL VARCHAR2(100),                                     -- �ŷ�ó ��ȭ��ȣ
    COMP_ADDR VARCHAR2(100),                                    -- �ŷ�ó �ּ�
    OWNER_NAME VARCHAR2(30),				-- ��ǥ�� �̸�
    TRADE_STATUS CHAR(1)  DEFAULT '1' NOT NULL,                  -- �ŷ� ���� ('1': �ŷ�, '2': �ŷ�����)
   COMP_TYPE CHAR(1) NOT NULL,				-- ����� ���� ( C:���� , P:���� )    
   COMP_NO VARCHAR2(100) NULL,				-- ����� ��ȣ
   REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                         -- �ŷ�ó �������

    CONSTRAINT PK_TBL_COMPANY PRIMARY KEY (COMP_CD, MEMBER_NO), -- ���� �⺻Ű: ���� ȸ���� ���� �ŷ�ó ����
    CONSTRAINT FK_COMPANY_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO) -- ȸ�� �ܷ�Ű
);

-- �ŷ�ó(���� ��) ������ �����ϴ� ���̺��Դϴ�.
-- �ŷ�ó�� ȸ�� ������ ��ϵǸ�, ������ �ŷ�ó �ڵ�(COMP_CD)�� ȸ��(MEMBER_NO)�� ���� ������ ������ �� �ֽ��ϴ�.
-- ���� COMP_CD�� MEMBER_NO�� ���� �⺻Ű�� �����Ǿ� �ְ�, ��� �� ���� ���̺����� �� �� ���� �Բ� �ܷ�Ű�� �����մϴ�.


-- �±� ���̺�
CREATE TABLE TBL_TAG (
    TAG_NO VARCHAR2(20) NOT NULL,                              -- �±� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                           -- ȸ�� ������ȣ (�±� ������)
    TAG_NAME VARCHAR2(50) NOT NULL,                            -- �±� �̸�
    TAG_COLOR VARCHAR2(20),                                    -- �±� ���� (�ð� ���п�)
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                    -- �±� �������

    CONSTRAINT PK_TBL_TAG PRIMARY KEY (TAG_NO, MEMBER_NO),     -- ���� PK: �±׺� ������ ����
    CONSTRAINT FK_TAG_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- ȸ���� ������ �±� ������ �����ϴ� ���̺��Դϴ�.
-- ������ TAG_NO�� ���� ȸ������ ������ �� �����Ƿ�, TAG_NO�� MEMBER_NO�� ���� PK�� ����մϴ�.
-- �±� ������ �ð��� ���п��̸�, MEMBER_NO�� �����ڸ� ��Ÿ���� �ܷ�Ű�Դϴ�.


-- ����÷�� ���̺�
CREATE TABLE TBL_FILE (
    FILE_NO VARCHAR2(20) NOT NULL,                               -- ���� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- ȸ�� ������ȣ (���δ�)
    FILE_ORIGIN VARCHAR2(255) NOT NULL,                          -- ���� ���ϸ� (����� ���ε� �̸�)
    FILE_NAME VARCHAR2(255) NOT NULL,                            -- ���� ���� ���ϸ�
    FILE_PATH VARCHAR2(500) NOT NULL,                            -- ���� ��� (���� ���� �Ǵ� URL)
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL ,                   -- ���� �����
    FILE_TABLE VARCHAR2(200) NOT NULL,                           -- ��� ���̺� �� ('contract', 'memo' ��)
    FILE_ID VARCHAR2(30) NOT NULL,                               -- ��� ���̺��� PK��
    FILE_SIZE NUMBER,                                            -- ���� ũ�� (byte)
    FILE_DELETED CHAR(1) DEFAULT 'N' NOT NULL ,                   -- ���� ���� ('Y' / 'N')

    CONSTRAINT PK_TBL_FILE PRIMARY KEY (FILE_NO, MEMBER_NO),
    CONSTRAINT FK_FILE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- �پ��� ���̺�(���, �޸� ��)�� ÷�ε� ���� ������ �����ϴ� ���̺��Դϴ�.
-- FILE_TABLE�� ���� ��� ���̺����, FILE_ID�� �ش� ���̺��� PK���� �ǹ��մϴ�.
-- �̸� ���� �����ϰ� ���� ���̺�� ����ǵ��� �����Ͽ�����, FK ������ ���� �ʽ��ϴ�.
-- ���� ���δ��� �ĺ��ϱ� ���� MEMBER_NO�� �ܷ�Ű�� �����ϰ�, FILE_NO�� MEMBER_NO�� ���� PK�� ����Ͽ� ȸ���� ���� ������ �����մϴ�.


-- �޸� ���̺�
CREATE TABLE TBL_MEMO (
    MEMO_NO VARCHAR2(20) NOT NULL,                               -- �޸� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- ȸ�� ������ȣ (�ۼ���)
    MEMO_TABLE VARCHAR2(30) NOT NULL,                            -- �޸� ��� ���̺� ���� ('contract', 'schedule' ��)
    MEMO_ID VARCHAR2(30) NOT NULL,                               -- �޸� ��� ���̺��� PK ��
    MEMO_CONTENT VARCHAR2(1000) NOT NULL,                        -- �޸� ����
    REG_DATE DATE DEFAULT SYSDATE NOT NULL,                      -- �޸� �������
    REVISE_DATE DATE,                                            -- ���� ���� (NULL ���)

    CONSTRAINT PK_TBL_MEMO PRIMARY KEY (MEMO_NO, MEMBER_NO),
    CONSTRAINT FK_MEMO_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- ERP �� �پ��� ���(���, ���� ��)�� �޸� ����� �ο��ϱ� ���� ���̺��Դϴ�.
-- MEMO_TABLE�� �޸� ������ ��� ���̺���� ��Ÿ����, MEMO_ID�� �ش� ���̺��� PK���� �����Ͽ� �����ϰ� �����մϴ�.
-- FK�� ���� �ʰ�, Java�ܿ��� ENUM/��� ������ Ÿ�� �ϰ����� �����մϴ�.
-- MEMBER_NO�� �ۼ��ڸ� �ĺ��ϱ� ���� �ܷ�Ű�Դϴ�.
-- MEMO_NO�� MEMBER_NO�� ���� �⺻Ű�� ����Ͽ� �ۼ��� ���� ���� �޸� ������ �����մϴ�.


-- �ŷ�ó ������ ���̺�
CREATE TABLE TBL_COMPANY_MEMBER (
    CONTACT_IDX VARCHAR2(20) NOT NULL,                             -- ������ ������ȣ
    COMP_CD VARCHAR2(20) NOT NULL,                                 -- �ŷ�ó ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                               -- ȸ�� ������ȣ (�����)
    CONTACT_NAME VARCHAR2(30) NOT NULL,                            -- ����� �̸�
    CONTACT_EMAIL VARCHAR2(100),                                   -- ����� �̸���
    CONTACT_PHONE VARCHAR2(20),                                    -- ����� ��ȭ��ȣ
    IS_MAIN_CONTACT CHAR(3) DEFAULT 'N',                           -- ��ǥ ���� ('Y' / 'N')
    CONTACT_POSITION VARCHAR2(30),                                 -- ����� ��å
    CONTACT_DEPT VARCHAR2(30),                                     -- ����� �μ�
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                            -- ������ �������

    CONSTRAINT PK_TBL_COMPANY_MEMBER PRIMARY KEY (CONTACT_IDX),    -- ������ ���� �⺻Ű
    CONSTRAINT FK_CM_COMP FOREIGN KEY (COMP_CD, MEMBER_NO) 
        REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO),                -- �ŷ�ó ���� �ܷ�Ű (COMP_CD + MEMBER_NO)
    CONSTRAINT FK_CM_MEMBER FOREIGN KEY (MEMBER_NO) 
        REFERENCES TBL_MEMBER(MEMBER_NO)                           -- ȸ�� �ܷ�Ű
);

-- �ŷ�ó(COMPANY)�� �Ҽӵ� ����� ������ �����ϴ� ���̺��Դϴ�.
-- CONTACT_IDX�� ������ ���� �ĺ����̸�, �⺻Ű�� ���˴ϴ�.
-- �ϳ��� �ŷ�ó(COMP_CD)�� ���� ����ڸ� ���� �� �����Ƿ�, COMP_CD + MEMBER_NO�� ���� �ܷ�Ű�� �����մϴ�.
-- IS_MAIN_CONTACT�� ��ǥ ����� ���θ� ǥ���ϸ�, ���� �������̳� �켱 �߼� ����� ���п� ���˴ϴ�.
-- �ŷ�ó�� ȸ�� �� ��� ���踦 ��Ȯ�� �ϱ� ���� MEMBER_NO�� ������ �ܷ�Ű�� ����Ǿ� �ֽ��ϴ�.


-- ������ ���̺�
CREATE TABLE TBL_CONTRACT (
    CONTRACT_NO         VARCHAR2(20) NOT NULL,                  -- ��� ������ȣ
    MEMBER_NO           VARCHAR2(20) NOT NULL,                  -- ��� ��� ȸ�� ��ȣ
    STATUS_CODE         VARCHAR2(20) NOT NULL,                  -- ��� ���� �ڵ� ('W', 'C', 'X', 'T')(���,Ȯ��,���,�ӽ�����)
    CONTRACT_TITLE      VARCHAR2(100) NOT NULL,                 -- ��� ����
    CONTRACT_CONTENT CLOB NOT NULL,			-- ��� ����
    REG_DATE            DATE DEFAULT SYSDATE NOT NULL,          -- ��� �������
    CONTRACT_START      DATE NOT NULL,                          -- ��� ������
    CONTRACT_END        DATE NOT NULL,                          -- ��� ������
    CONTRACT_DEPOSIT    NUMBER NOT NULL,                        -- ����
    CONTRACT_CONFIRM    DATE,                                   -- ��� Ȯ������

    CONSTRAINT PK_TBL_CONTRACT PRIMARY KEY (CONTRACT_NO),
    CONSTRAINT UQ_CONTRACT_STATUS UNIQUE (CONTRACT_NO, STATUS_CODE),
    CONSTRAINT FK_CONTRACT_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_CONTRACT_STATUS FOREIGN KEY (STATUS_CODE) REFERENCES TBL_CONTRACT_STATUS(STATUS_CODE)
);

ALTER TABLE TBL_CONTRACT MODIFY (CONTRACT_TITLE VARCHAR2(200));
commit;

-- ��� ������ �����ϴ� �ٽ� ���̺��Դϴ�.
-- CONTRACT_NO�� ���� �⺻Ű�� ���Ǹ�, �� ����� �����ϰ� �ĺ��մϴ�.
-- ����� �ݵ�� ȸ��(MEMBER_NO)�� ���� ��ϵǸ�, ��� ���� ��� ��� ���̺�� ����Ǿ� �ֽ��ϴ�.
-- ��� ���´� STATUS_CODE�� ǥ���Ǹ�, �����ڵ庰 ���� �� ������ ���� ���� UNIQUE ����(CONTRACT_NO + STATUS_CODE)�� �����Ǿ� �ֽ��ϴ�.
-- ����� �ֿ� �����δ� ��� ����, ����, ������, ������, Ȯ������ ���ԵǸ�, ������� �⺻������ SYSDATE�� �ڵ� �����˴ϴ�.


-- ����� ���̺�
CREATE TABLE TBL_CONTRACT_PARTY (
    ID             NUMBER PRIMARY KEY,                               -- ���� �ĺ��� (������ ��� ����)
    CONTRACT_NO    VARCHAR2(20) NOT NULL,                            -- ��� ��ȣ
    CLIENT_NO      VARCHAR2(20),                                     -- ���� �� ��ȣ (nullable)
    COMP_CD        VARCHAR2(20),                                     -- �ŷ�ó ���� ��ȣ (nullable)
    MEMBER_NO      VARCHAR2(20) NOT NULL,                            -- ��� ���� �Ҽ� ȸ��
    ROLE           VARCHAR2(50),                                     -- ��� �� ���� (��: �����, ������ ��)

    CONSTRAINT FK_PARTY_CONTRACT FOREIGN KEY (CONTRACT_NO)
        REFERENCES TBL_CONTRACT(CONTRACT_NO),

    CONSTRAINT FK_PARTY_CLIENT FOREIGN KEY (CLIENT_NO, MEMBER_NO)
        REFERENCES TBL_CLIENT(CLIENT_NO, MEMBER_NO),

    CONSTRAINT FK_PARTY_COMPANY FOREIGN KEY (COMP_CD, MEMBER_NO)
        REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO)
);

-- ����� �����(���� �� �Ǵ� ���� ����)�� �����ϴ� ���� ���̺��Դϴ�.
-- CONTRACT_NO�� �������� ��� ���� ���̺�(TBL_CONTRACT)�� ����Ǹ�, 1:N ������ �����˴ϴ�.
-- ����ڴ� ���� ��(CLIENT_NO) �Ǵ� ���� ����(COMP_CD) �� �ϳ��� ����Ǹ�, ������ �Ҽ� ȸ��(MEMBER_NO)�� �������� ���Ἲ�� Ȯ���մϴ�.
-- CLIENT_NO�� COMP_CD�� ���ÿ� ������ ������, ���ø����̼� �ܿ��� �� �ʸ� �Էµǵ��� �����ؾ� �մϴ�.


-- ȸ�� ���̺�
CREATE TABLE TBL_MEETING (
    MEETING_NO     VARCHAR2(20) NOT NULL,                          -- ȸ�� ������ȣ
    MEMBER_NO      VARCHAR2(20) NOT NULL,                          -- �ۼ��� ȸ����ȣ
    MEET_TITLE     VARCHAR2(100) NOT NULL,                         -- ȸ�� ����
    MEET_CONTENT   CLOB NOT NULL,                                  -- ȸ�� ����
    MEET_DATE      DATE DEFAULT SYSDATE NOT NULL,                  -- ȸ�� ����
    GPT_SUMMARY    VARCHAR2(1024),                                 -- AI ��� ����

    CONSTRAINT PK_TBL_MEETING PRIMARY KEY (MEETING_NO),
    CONSTRAINT FK_MEETING_MEMBER FOREIGN KEY (MEMBER_NO)
        REFERENCES TBL_MEMBER(MEMBER_NO)
);

-- ������ ���� Ŀ�´����̼�(ȸ��, ��� ��) ������ ����ϴ� ���̺��Դϴ�.
-- MEETING_NO�� ���� �⺻Ű�̸�, �� ȸ�Ǹ� �����ϰ� �ĺ��մϴ�.
-- ȸ�Ǵ� �ݵ�� ȸ��(MEMBER_NO)�� ���� ��ϵǸ�, ȸ���� ����ڴ� ������ ȸ�������� ���̺�(TBL_MEETING_PARTICIPANT)�� ����˴ϴ�.
-- ȸ���� �ֿ� �����δ� ȸ�� ����, ȸ�� ����, AI ��� ����� ������, ȸ�� ���ڴ� �⺻������ SYSDATE�� �ڵ� �����˴ϴ�.


-- ȸ�������� ���̺�
CREATE TABLE TBL_MEETING_PARTICIPANT (
    MEETING_PARTICIPANT_NO            NUMBER  PRIMARY KEY,                              -- ȸ�� ������ ������ȣ
    MEETING_NO    VARCHAR2(20) NOT NULL,                           -- ȸ�� ������ȣ
    CLIENT_NO     VARCHAR2(20),                                    -- ���� �� ��ȣ (nullable)
    COMP_CD       VARCHAR2(20),                                    -- �ŷ�ó ���� ��ȣ (nullable)
    MEMBER_NO     VARCHAR2(20) NOT NULL,                           -- �� �Ҽ� ȸ��

    CONSTRAINT FK_PARTICIPANT_MEETING FOREIGN KEY (MEETING_NO)
        REFERENCES TBL_MEETING(MEETING_NO),

    CONSTRAINT FK_PARTICIPANT_CLIENT FOREIGN KEY (CLIENT_NO, MEMBER_NO)
        REFERENCES TBL_CLIENT(CLIENT_NO, MEMBER_NO),

    CONSTRAINT FK_PARTICIPANT_COMPANY FOREIGN KEY (COMP_CD, MEMBER_NO)
        REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO)
);

-- ȸ�� �����(������)�� �����ϴ� ���̺��Դϴ�.
-- MEETING_NO�� �������� TBL_MEETING�� ����Ǹ�, 1:N ������ ȸ�� ����ڸ� �ټ� ������ �� �ֽ��ϴ�.
-- �����ڴ� ���� ��(CLIENT_NO) �Ǵ� �ŷ�ó ����(COMP_CD) �� �ϳ��� �����Ǹ�, ������ �Ҽ� ȸ��(MEMBER_NO)�� ���� ���Ἲ�� Ȯ���մϴ�.


-- �±׸� ���̺�
CREATE TABLE TBL_TAG_MAP (
    TAG_MAP_NO VARCHAR2(20) NOT NULL,                              -- �±� ���� ������ȣ
    TAG_NO VARCHAR2(20) NOT NULL,                                  -- �±� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                               -- �±� ���� ȸ�� ��ȣ
    TAG_TABLE VARCHAR2(255) NOT NULL,                              -- �±� ��� ���̺� �� (��: 'contract', 'schedule' ��)
    TAG_ID VARCHAR2(30) NOT NULL,                                  -- �±� ��� ���̺��� PK ��ȣ

    CONSTRAINT PK_TBL_TAG_MAP PRIMARY KEY (TAG_MAP_NO),           
    CONSTRAINT FK_TAGMAP_TAG FOREIGN KEY (TAG_NO, MEMBER_NO) REFERENCES TBL_TAG(TAG_NO, MEMBER_NO)
);

-- �پ��� ��� ���̺� �±׸� �����ϴ� ���� ���̺��Դϴ�.
-- TAG_MAP_NO�� �±� ������ ���� �ĺ����̸�, ���� PK�� �����˴ϴ�.
-- TAG_NO�� MEMBER_NO�� �Բ� ���� �ܷ�Ű�� ����Ǹ�, TBL_TAG�� ����Ű(TAG_NO, MEMBER_NO)�� ��Ȯ�� �����մϴ�.
-- �±� ��� ���̺��� TAG_TABLE�� TAG_ID�� ���� �ĺ��Ǹ�, ������ ���� ������ ����Ǿ� �������� �����մϴ�.


-- ����ǥ ���̺�
CREATE TABLE TBL_SCHEDULE (
    SCHEDULE_NO VARCHAR2(20) NOT NULL,                            -- ���� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                              -- ȸ�� ������ȣ (���� �����)
    CONTRACT_NO VARCHAR2(20) NOT NULL,                            -- ��� ������ȣ
    STATUS_CODE VARCHAR2(20) NOT NULL,                            -- ���� �����ڵ� ('W', 'C', 'X', 'T')
    SCHEDULE_TITLE VARCHAR2(20) NOT NULL,                         -- ���� ����
    SCHEDULE_START DATE NOT NULL,                                 -- ���� ������
    SCHEDULE_END DATE NOT NULL,                                   -- ���� ������
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                       -- ���� �����
    SCHEDULE_CONTENT VARCHAR2(1000),                              -- ���� ���� ����
    SCHEDULE_PROGRESS NUMBER  DEFAULT 0 NOT NULL,                   -- ���� ����� (%), TBL_TASK�� ����
    SCHEDULE_COLOR VARCHAR2(20) NULL,                             -- ���� ���� (Ķ������)
    SCHEDULE_ALERT CHAR(1)  DEFAULT 'N' NOT NULL,                  -- �˸� ���� ('Y' / 'N')

    CONSTRAINT PK_TBL_SCHEDULE PRIMARY KEY (SCHEDULE_NO),         --  ���� �⺻Ű
    CONSTRAINT UQ_SCHEDULE_UNIQUE UNIQUE (MEMBER_NO, CONTRACT_NO, STATUS_CODE), --  ���� ����ũ ����
    CONSTRAINT FK_SCHEDULE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_SCHEDULE_CONTRACT FOREIGN KEY (CONTRACT_NO) REFERENCES TBL_CONTRACT(CONTRACT_NO),
    CONSTRAINT FK_SCHEDULE_STATUS FOREIGN KEY (STATUS_CODE) REFERENCES TBL_CONTRACT_STATUS(STATUS_CODE)
);

-- ��࿡ ���� ���� ������ Ķ���� ���·� �����ϱ� ���� ���̺��Դϴ�.
-- �� ������ SCHEDULE_NO�� ���еǸ�, �����(MEMBER_NO)�� ����˴ϴ�.
-- ������ �ݵ�� �ϳ��� ���(CONTRACT_NO)�� ���ϸ�, �����ڵ�(STATUS_CODE)�� ���� ���� ���̺�� �����˴ϴ�.
-- ���� ����, ����, ����/������ �ܿ��� �����(SCHEDULE_PROGRESS)�� ����, �˸� ���� ���� �ð���/����� �Ӽ��� �����մϴ�.
-- ���� ��� �� �ߺ� ���� ������ ���� MEMBER_NO + CONTRACT_NO + STATUS_CODE�� ����ũ ���������� �߰��˴ϴ�.


-- ����/û�� ���̺�
CREATE TABLE TBL_INVOICE (
    INVOICE_NO        VARCHAR2(20) NOT NULL,                       -- û���� ������ȣ
    CONTRACT_NO       VARCHAR2(20) NOT NULL,                       -- ��� ������ȣ
    MEMBER_NO         VARCHAR2(20) NOT NULL,                       -- �ۼ��� ȸ����ȣ
    INVOICE_DEPOSIT   NUMBER NOT NULL,                             -- û�� �ݾ�
    INVOICE_SEND      DATE NOT NULL,                               -- û���� �߼���
    INVOICE_IS_SEND   CHAR(1) DEFAULT 'N' NOT NULL,                -- �߼� ���� ('Y'/'N')
    INVOICE_PAID      DATE,                                        -- �Ա�����
    INVOICE_IS_PAID   CHAR(1) DEFAULT 'N' NOT NULL,                -- �Ա� ���� ('Y'/'N')
    INVOICE_METHOD    VARCHAR2(50) NOT NULL,                       -- ���� ����
    REG_DATE          DATE DEFAULT SYSDATE NOT NULL,               -- û���� ��������

    CONSTRAINT PK_TBL_INVOICE PRIMARY KEY (INVOICE_NO),
    CONSTRAINT FK_INVOICE_CONTRACT FOREIGN KEY (CONTRACT_NO) REFERENCES TBL_CONTRACT(CONTRACT_NO),
    CONSTRAINT FK_INVOICE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);


-- û�� ������ �����ϴ� ���� ���̺��Դϴ�.
-- INVOICE_NO�� ���� �⺻Ű�̸�, �� û������ �����ϰ� �ĺ��մϴ�.
-- û������ �ݵ�� ȸ��(MEMBER_NO)�� ���� �ۼ��Ǹ�, ���(CONTRACT_NO)�� ����˴ϴ�.
-- �� ������ ������ û�� ����� ���̺�(TBL_INVOICE_TARGET)�� ���� �����˴ϴ�.
-- û�� �ݾ�, ���� ���, �߼� ����, �Ա� ���� ���� û�� ���� ������ �� ���̺� ��ϵ˴ϴ�.

-- ��������� ���̺�
CREATE TABLE TBL_INVOICE_TARGET (
    ID                    NUMBER PRIMARY KEY,                         -- ���� �ĺ���
    INVOICE_NO            VARCHAR2(20) NOT NULL,                      -- û���� ������ȣ
    CLIENT_NO             VARCHAR2(20),                               -- ���� �� ��ȣ (nullable)
    COMP_CD               VARCHAR2(20),                               -- �ŷ�ó ���� ��ȣ (nullable)
    MEMBER_NO             VARCHAR2(20) NOT NULL,                      -- �� �Ҽ� ȸ��
    INVOICE_CLIENT_NAME   VARCHAR2(200) NOT NULL,                     -- ������ �̸� �Ǵ� ȸ���
    INVOICE_CLIENT_EMAIL  VARCHAR2(200) NOT NULL,                     -- ������ �̸���

    CONSTRAINT FK_TARGET_INVOICE FOREIGN KEY (INVOICE_NO)
        REFERENCES TBL_INVOICE(INVOICE_NO),

    CONSTRAINT FK_TARGET_CLIENT FOREIGN KEY (CLIENT_NO, MEMBER_NO)
        REFERENCES TBL_CLIENT(CLIENT_NO, MEMBER_NO),

    CONSTRAINT FK_TARGET_COMPANY FOREIGN KEY (COMP_CD, MEMBER_NO)
        REFERENCES TBL_COMPANY(COMP_CD, MEMBER_NO)
);

-- û�� ����� ������ �����ϴ� ���̺��Դϴ�.
-- INVOICE_NO�� �������� TBL_INVOICE�� ����Ǹ�, �ϳ��� û������ ���� ���� ���� ������ �� �ֽ��ϴ�.
-- ����ڴ� ���� ��(CLIENT_NO) �Ǵ� �ŷ�ó ����(COMP_CD) �� �ϳ��� �����Ǹ�,
-- ������ ���� �Ҽ� ȸ��(MEMBER_NO)�� ���� ���� ���踦 �����մϴ�.
-- �������� �̸��� �̸����� ���� û���� �߼��� ���� ������ Ȱ��˴ϴ�.
-- CLIENT_NO�� COMP_CD�� ���ÿ� �Էµ��� ������, ���ø����̼� �ܿ��� �� �ʸ� �Էµǵ��� �����ؾ� �մϴ�.


-- �۾����� ���̺�
CREATE TABLE TBL_TASK (
    TASK_NO VARCHAR2(20) NOT NULL,                               -- �۾� ������ȣ
    SCHEDULE_NO VARCHAR2(20) NOT NULL,                           -- ������ ���� ������ȣ
    MEMBER_NO VARCHAR2(20) NOT NULL,                             -- �۾� �����(ȸ�� ������ȣ)
    TASK_TITLE VARCHAR2(100) NOT NULL,                           -- �۾� ����
    TASK_CONTENT VARCHAR2(3000) NOT NULL,                        -- �۾� �� ����
    TASK_DUE DATE,                                               -- �۾� ������
    REG_DATE DATE DEFAULT SYSDATE NOT NULL ,                      -- �۾� �������
    TASK_COMPLETE CHAR(1) DEFAULT 'N' NOT NULL,                  -- �Ϸ� ���� ('Y' / 'N')
    TASK_PRIORITY VARCHAR2(10) DEFAULT '��' NOT NULL,            -- �۾� �켱���� ('��', '��', '��')
    TASK_ALERT DATE,                                             -- �˸� �߼��� (��: ���� �Ϸ� ��)

    CONSTRAINT PK_TBL_TASK PRIMARY KEY (TASK_NO),               
    CONSTRAINT FK_TASK_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO),
    CONSTRAINT FK_TASK_SCHEDULE FOREIGN KEY (SCHEDULE_NO) REFERENCES TBL_SCHEDULE(SCHEDULE_NO)
);


-- ����(SCHEDULE)�� �Ҽӵ� ���� �۾�(To-Do)�� �����ϴ� ���̺��Դϴ�.
-- TASK_NO�� �۾� ���� �ĺ��ڷ�, ���� �⺻Ű�� �����Ǿ� �ֽ��ϴ�.
-- �� �۾��� ����(SCHEDULE_NO)�� ����Ǹ�, �����(MEMBER_NO) ������ �Բ� ����˴ϴ�.
-- �۾� ����, �� ����, ������(TASK_DUE), �����, �켱����(TASK_PRIORITY), �Ϸ� ����(TASK_COMPLETE) ���� �����մϴ�.
-- TASK_ALERT�� ���� ���� �˸� ����� ���� �Ӽ��Դϴ�.
-- ���� �� ȸ�� ���̺�� �ܷ�Ű�� ����Ǿ� �־� ���� ��� �۾� �帧 ������ �����մϴ�.

-- ��� ���� ���� �̷� ���� ���̺�
CREATE TABLE TBL_CONTRACT_HISTORY (
    CONTRACT_HISTORY_NO         NUMBER              CONSTRAINT PK_CONTRACT_HISTORY PRIMARY KEY,
    CONTRACT_NO                 VARCHAR2(20)        NOT NULL,
    MEMBER_NO                   VARCHAR2(20)        NOT NULL,
    CONTRACT_HISTORY_CONTENT    VARCHAR2(1000)      NULL,
    CONTRACT_HISTORY_DATE       DATE                DEFAULT SYSDATE NOT NULL,
    
    CONSTRAINT FK_HISTORY_CONTRACT FOREIGN KEY (CONTRACT_NO) REFERENCES TBL_CONTRACT(CONTRACT_NO),
    CONSTRAINT FK_HISTORY_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES TBL_MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN TBL_CONTRACT_HISTORY.CONTRACT_HISTORY_NO IS '��� ���� �̷� ���� ��ȣ (PK)';
COMMENT ON COLUMN TBL_CONTRACT_HISTORY.CONTRACT_NO IS '��� ���� ��ȣ (FK)';
COMMENT ON COLUMN TBL_CONTRACT_HISTORY.MEMBER_NO IS '������ ������ ȸ�� ��ȣ (FK)';
COMMENT ON COLUMN TBL_CONTRACT_HISTORY.CONTRACT_HISTORY_CONTENT IS '���� ����(����)';
COMMENT ON COLUMN TBL_CONTRACT_HISTORY.CONTRACT_HISTORY_DATE IS '���� �Ͻ�';

--------------------------------------------------------------------------------

-- ��� ���� ���� �̷� ���� ������
CREATE SEQUENCE SEQ_CONTRACT_HISTORY_NO
START WITH 1
INCREMENT BY 1;

-- ����ȣ(CONTRACT_NO) ������
CREATE SEQUENCE SEQ_TBL_CONTRACT_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ������ȣ(CONTRACT_PARTY_NO)
CREATE SEQUENCE SEQ_CONTRACT_PARTY_ID START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �ŷ�ó�ڵ�(COMP_CD) ������
CREATE SEQUENCE SEQ_TBL_COMPANY_CD START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ���ΰ���ȣ(CLIENT_NO) ������
CREATE SEQUENCE SEQ_TBL_CLIENT_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ȸ�ǹ�ȣ(MEETING_NO) ������
CREATE SEQUENCE SEQ_TBL_MEETING_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ȸ��������(MEETING_PARTICIPANT_NO) ������
CREATE SEQUENCE SEQ_MEETING_PARTICIPANT_ID START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ������ȣ(SCHEDULE_NO) ������
CREATE SEQUENCE SEQ_TBL_SCHEDULE_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �۾���ȣ(TASK_NO) ������
CREATE SEQUENCE SEQ_TBL_TASK_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- û����ȣ(INVOICE_NO) ������
CREATE SEQUENCE SEQ_TBL_INVOICE_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ��������ڹ�ȣ(INVOICE_TARGET_NO) ������
CREATE SEQUENCE SEQ_INVOICE_TARGET_ID START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �޸��ȣ(MEMO_NO) ������
CREATE SEQUENCE SEQ_TBL_MEMO_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �±׹�ȣ(TAG_NO) ������
CREATE SEQUENCE SEQ_TBL_TAG_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �±� ���� ��ȣ(TAG_MAP_NO) ������
CREATE SEQUENCE SEQ_TBL_TAG_MAP_NO START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- �ŷ�ó ������(CONTACT_IDX) ������
CREATE SEQUENCE SEQ_TBL_COMPANY_MEMBER_IDX START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ȸ�� ���� �� ������
CREATE SEQUENCE seq_tbl_member_no START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ���� ��ȣ ������
CREATE SEQUENCE SEQ_TBL_FILE_NO START WITH 1 INCREMENT BY 1;

commit;

-----------------------------------------------------------------------------------------

-- �ӽ� ��� ������ ����
INSERT INTO TBL_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_STATUS, MEMBER_EMAIL, MEMBER_PHONE, JOIN_DATE)
VALUES ('MEM_001', 'user01', '1234', '�ӵ���', 'Y', 'dongju@example.com', '010-1111-2222', SYSDATE-150);

INSERT INTO TBL_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_STATUS, MEMBER_EMAIL, MEMBER_PHONE, JOIN_DATE)
VALUES ('MEM_002', 'user02', '1234', '����', 'Y', 'kideok@example.com', '010-3333-4444', SYSDATE-120);

INSERT INTO TBL_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_STATUS, MEMBER_EMAIL, MEMBER_PHONE, JOIN_DATE)
VALUES ('MEM_003', 'user03', '1234', '�賲��', 'Y', 'namhoo@example.com', '010-5555-6666', SYSDATE-110);

-- ������ ���� ���� ('A' ����)
INSERT INTO TBL_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_STATUS, MEMBER_EMAIL, MEMBER_PHONE, JOIN_DATE)
VALUES ('MEM_004', 'admin', '1234', '������', 'A', 'admin@myjarvis.com', '010-9999-8888', SYSDATE-200);

INSERT INTO TBL_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_STATUS, MEMBER_EMAIL, MEMBER_PHONE, JOIN_DATE)
VALUES ('MEM_005', 'user04', '1234', '������', 'Y', 'jihun@example.com', '010-7777-8888', SYSDATE-90);

-- �����Ͱ� �� ������ Ȯ��
COMMIT;

select * from tbl_company;

-- �ӽ� �ŷ�ó ������ ����
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '(��)������ �ַ��', 'ȫ�浿', '123-45-67890', '02-1111-2222', '����Ư���� ������ ������� 123', SYSDATE);

INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '����Ʈ �ڵ� ��ī����', '��ö��', '222-33-44556', '031-777-8888', '��⵵ ������ �д籸 �Ǳ����� 235', SYSDATE-10);

INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '������ ��������', '�̿���', '333-11-55887', '02-3456-7890', '����Ư���� ������ �����źϷ� 402', SYSDATE-25);

INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '��� ������ƽ��', '������', '444-22-66998', '051-987-6543', '�λ걤���� �ؿ�뱸 ���ҵ��� 57', SYSDATE-40);

INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '�۷ι� ���� ���', '�ֹ���', '555-33-77119', '032-123-4567', '��õ������ ������ �����þƴ�� 165', SYSDATE-100);

INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '(��)������ ��ũ�����', '�����', '110-86-12345', '02-555-0101', '����Ư���� ������ ���ﵿ 823-1', SYSDATE - 200);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�׸������� �ַ��', '�̼���', '211-81-67890', '031-777-0202', '��⵵ ������ �д籸 ���� 624', SYSDATE - 180);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '��彺Ÿ ����', '�ڼ���', '128-87-11223', '051-888-0303', '�λ걤���� �ؿ�뱸 �쵿 1407', SYSDATE - 150);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '���ǵ��� ����', '������', '220-81-33445', '032-444-0404', '��õ������ ������ �۵��� 29-1', SYSDATE - 145);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '���Ľý�����', '������', '301-86-55667', '042-666-0505', '���������� ������ ���浿 3-1', SYSDATE - 140);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�ؽ�Ʈ ���� ������', '������', '135-81-77889', '02-999-0606', '����Ư���� ���ʱ� ���ʵ� 1321-11', SYSDATE - 135);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '(��)���ÿ���', '������', '117-81-99001', '02-212-0707', '����Ư���� ���α� ���ε� 188-25', SYSDATE - 130);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '����Ƽ��Ʈ����', '�Ӽ���', '214-85-12123', '031-313-0808', '��⵵ ������ ���뱸 ���ǵ� 1322-1', SYSDATE - 125);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '������̵� ���', '������', '312-81-34345', '053-535-0909', '�뱸������ �߱� ���ε�1�� 29', SYSDATE - 120);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '���� F&B', '��ä��', '105-87-56567', '02-757-1010', '����Ư���� �߱� ��2�� 25-2', SYSDATE - 115);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�۽�Ʈ �Ǽ�', '������', '101-81-78789', '02-345-1111', '����Ư���� ������ ������ 278-29', SYSDATE - 110);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '����-��Ƽ �ڽ���ƽ', '�����', '208-86-90901', '02-600-1212', '����Ư���� ������ ��� 774-1', SYSDATE - 105);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '�帲���丮 ��Ʃ���', '������', '113-81-13134', '02-888-1313', '����Ư���� ������ ��ϵ� 1602', SYSDATE - 100);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '��ī�� ���� ������', 'Ȳ�ϸ�', '124-86-35356', '032-747-1414', '��õ������ �߱� ��� 2850', SYSDATE - 95);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�̷����� �����ڹ�', '�ȵ���', '120-81-57578', '02-789-1515', '����Ư���� �������� ���ǵ��� 23-4', SYSDATE - 90);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '����-�����鸮 ȭ��', '�����', '305-81-79790', '043-234-1616', '��û�ϵ� û�ֽ� ����� ������ 707', SYSDATE - 85);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '����� ��Ʈ�ʽ�', '������', '107-86-91912', '02-621-1717', '����Ư���� ������ �Ｚ�� 159', SYSDATE - 80);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�� ���� ����', '������', '215-81-14144', '02-887-1818', '����Ư���� ���Ǳ� �Ÿ��� 1523', SYSDATE - 75);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '�ｺ�ɾ� �޵���', '��ÿ�', '110-81-36366', '02-3410-1919', '����Ư���� ������ �Ͽ��� 50', SYSDATE - 70);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '(��)���ְ��ֳ���', '��ƶ�', '616-81-58588', '064-727-2020', '����Ư����ġ�� ���ֽ� �ƶ��ϵ� 3-1', SYSDATE - 65);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�۷ι� ���ͽ�', '���缮', '119-81-70701', '031-222-2121', '��⵵ ȭ���� ������ 77-1', SYSDATE - 60);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '�ڸ��� �μ�', '����ȣ', '104-81-82823', '02-2266-2222', '����Ư���� �߱� ������3�� 281', SYSDATE - 58);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�츮 ���� ��Ʈ', '����', '212-81-94945', '02-333-2323', '����Ư���� ������ ������ 395-1', SYSDATE - 56);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '��� ����', '������', '303-81-16167', '051-242-2424', '�λ걤���� �߱� ������4�� 37-1', SYSDATE - 54);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '���� ������', '�̱���', '108-81-38389', '031-987-2525', '��⵵ ������ ��쵿 876', SYSDATE - 52);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�������Դ� �����', '����ȿ', '201-81-50501', '02-778-2626', '����Ư���� ���α� �λ絿 194-4', SYSDATE - 50);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', 'ưư �����ܰ�', '������', '111-99-72723', '02-545-2727', '����Ư���� ������ �Ż絿 501-1', SYSDATE - 48);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '����¡��Ÿ �������θ�Ʈ', '���ҹ�', '138-81-94945', '02-3444-2828', '����Ư���� ������ û�㵿 40-1', SYSDATE - 46);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '���ǵ� �������', '�缼��', '207-81-16167', '02-2279-2929', '����Ư���� �߱� �湫��5�� 22-1', SYSDATE - 44);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '(��)�������', '�̵�', '101-01-00001', '02-111-1418', '����Ư���� ���α� ������ 1-1', SYSDATE - 42);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '���� ��ȹ', '����', '102-02-00002', '033-640-2323', '������ ������ ���嵿 201', SYSDATE - 40);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '��� ����', '��Ȳ', '103-03-00003', '054-850-6114', '���ϵ� �ȵ��� ����� 680', SYSDATE - 38);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�ٻ� ������', '�����', '104-04-00004', '031-579-6000', '��⵵ �����ֽ� ���ȸ� 60', SYSDATE - 36);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '�湫�� �ؿ�', '�̼���', '105-05-00005', '055-649-2222', '��󳲵� �뿵�� ������ 1062', SYSDATE - 34);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�Ż��Ӵ� ������', '���μ�', '106-06-00006', '033-640-4457', '������ ������ ���嵿 201-1', SYSDATE - 32);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '������ �Ǽ�', '���', '107-07-00007', '041-830-2114', '��û���� �ο��� �ο��� 520', SYSDATE - 30);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'P', '�´� ����', '�´�', '108-08-00008', '043-423-8820', '��û�ϵ� �ܾ籺 ����� 114', SYSDATE - 28);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�� ���� ���۴�', '��', '109-09-00009', '031-958-3333', '��⵵ ���ֽ� ������ 334', SYSDATE - 26);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'C', '�庸�� ����', '�庸��', '110-10-00010', '061-550-6114', '���󳲵� �ϵ��� �ϵ��� 1004', SYSDATE - 24);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'C', '������ �ʸ�', '������', '111-11-00011', '02-781-2222', '����Ư���� �������� ���ǵ��� 1', SYSDATE - 22);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'P', '������ ȭ��', '������', '112-12-00012', '054-779-6114', '���ϵ� ���ֽ� �οյ� 76', SYSDATE - 20);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'P', '�������� ���', '�����', '113-13-00013', '054-779-8700', '���ϵ� ���ֽ� �οյ� 839-1', SYSDATE - 18);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'P', '�������� ����', '��������', '114-14-00014', '031-953-2222', '��⵵ ���ֽ� ������ 111', SYSDATE - 16);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'P', '������ ����', '������', '111-112-12000', '02-879-5114', '����Ư���� ���Ǳ� ��õ�� 218-14', SYSDATE - 14);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'P', '���� �ܱ���', '����', '111-112-12001', '031-638-1111', '��⵵ ��õ�� ���� 333', SYSDATE - 12);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_001', 'P', '��ȿ��� ���ý�����', '��ȿ', '111-112-12002', '054-762-1111', '���ϵ� ���ֽ� ������ 15-1', SYSDATE - 10);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_002', 'P', '�ǻ� ����ġ', '�ǻ�', '111-112-12003', '054-633-2222', '���ϵ� ���ֽ� �μ��� 148', SYSDATE - 8);
INSERT INTO TBL_COMPANY (COMP_CD, MEMBER_NO, COMP_TYPE, COMP_NAME, OWNER_NAME, COMP_NO, COMP_TEL, COMP_ADDR, REG_DATE) 
VALUES ('COMP'||LPAD(SEQ_TBL_COMPANY_CD.NEXTVAL, 4, '0'), 'MEM_003', 'P', '���� �����', '����', '111-112-12000', '061-755-3333', '���󳲵� ��õ�� �۱��� 12', SYSDATE - 5);

-- �����Ͱ� �� ������ Ȯ��
COMMIT;
select*from tbl_company;


-- ��� ���� �ڵ� ������ (���� ����)
INSERT INTO TBL_CONTRACT_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('W', '����(���)');
INSERT INTO TBL_CONTRACT_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('C', '�Ϸ�(Ȯ��)');
INSERT INTO TBL_CONTRACT_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('X', '���');
INSERT INTO TBL_CONTRACT_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('T', '�ӽ�����');

-- [��� �ο� ������]

-- 31
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'C', '2024�� 1�б� SEO ������', '�˻����� ����ȭ�� ���� ������ Ʈ���� ����', TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 18000000, TO_DATE('2024-01-10', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0001', 'MEM_001', '�����');
END;
/

-- 32
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'W', '2025�� �Ϲݱ� ��Ʃ�� ����', '����ǰ ȫ���� ��Ʃ�� ���� ���� ����', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 50000000, TO_DATE('2025-06-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0002', 'MEM_002', '�����');
END;
/

-- 33
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'T', '���� ERP �ý��� ��� ��ȭ', '������ �� ȸ�� ��� ��� �߰� ����', TO_DATE('2025-10-01', 'YYYY-MM-DD'), TO_DATE('2026-02-28', 'YYYY-MM-DD'), 45000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0003', 'MEM_003', '�����');
END;
/

-- 34
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'C', '2024�� 2�б� ���� ������ ����', '�귣�� ȫ���� ���� �� 1ȸ ����', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 25000000, TO_DATE('2024-03-25', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0004', 'MEM_004', '�����');
END;
/

-- 35
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'W', '��Ʃ�� ä�� � ����', '�� 4ȸ ���� ������ ��ȹ, �Կ�, ���� �� ���ε�', TO_DATE('2025-07-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 30000000, TO_DATE('2025-06-18', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0005', 'MEM_001', '�����');
END;
/


-- 36
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'C', '�ڶ�ȸ �ν� ������ �� ��ġ', '�ڿ��� ���� IT �ڶ�ȸ ���� �ν�', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), 9000000, TO_DATE('2024-02-15', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0006', 'MEM_002', '�����');
END;
/

-- 37
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'T', 'AI ê�� ����', '�� ���� ����� AI ê�� �ַ�� ����', TO_DATE('2025-11-01', 'YYYY-MM-DD'), TO_DATE('2026-03-31', 'YYYY-MM-DD'), 60000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0007', 'MEM_003', '�����');
END;
/

-- 38
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'W', '���� ������ ���� �� ����', '24/7 ���� ����͸� �� ���� ���� ����', TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 36000000, TO_DATE('2024-12-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0008', 'MEM_004', '�����');
END;
/

-- 39
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'C', '��ǰ īŻ�α� ������ �� �μ�', '2024�� �Ϲݱ� ����ǰ īŻ�α� 1,000��', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-20', 'YYYY-MM-DD'), 5500000, TO_DATE('2024-06-25', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0009', 'MEM_001', '�����');
END;
/

-- 40
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'X', '�۷ι� ���� ����ġ', '������ ���� ������ ���� ���� ���� �� �м�', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-07-31', 'YYYY-MM-DD'), 15000000, TO_DATE('2025-05-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0010', 'MEM_002', '�����');
END;
/

-- 41
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'T', 'Ű����ũ �ý��� ����', '�ֹ� �� ������ Ű����ũ ����Ʈ���� ����', TO_DATE('2026-01-01', 'YYYY-MM-DD'), TO_DATE('2026-06-30', 'YYYY-MM-DD'), 70000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0001', 'MEM_003', '�����');
END;
/

-- 42
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'W', 'ȸ�� �Ұ��� PPT ������', '���� ��ġ�� IR �ڷ� �� ȸ�� �Ұ��� ������', TO_DATE('2025-07-15', 'YYYY-MM-DD'), TO_DATE('2025-07-30', 'YYYY-MM-DD'), 4000000, TO_DATE('2025-07-10', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0005', 'MEM_004', '�����');
END;
/

-- 43
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'C', '������Ʈ ���� ����', '������ �ε� �ӵ� ����ȭ �� ���� ���� �ӵ� ����', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 8000000, TO_DATE('2024-01-25', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0006', 'MEM_001', '�����');
END;
/

-- 44
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'T', '�¶��� ���� �÷��� ����', '������ ����, ���� ����, Ŀ�´�Ƽ ��� ���� �÷���', TO_DATE('2025-12-01', 'YYYY-MM-DD'), TO_DATE('2026-05-31', 'YYYY-MM-DD'), 90000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0007', 'MEM_002', '�����');
END;
/

-- 45
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'W', '����� ���� QA', '�ű� ��� ���� ����� ���� ��� �� ȣȯ�� �׽�Ʈ', TO_DATE('2025-08-01', 'YYYY-MM-DD'), TO_DATE('2025-09-30', 'YYYY-MM-DD'), 20000000, TO_DATE('2025-07-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0009', 'MEM_003', '�����');
END;
/

-- 46
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'C', '�系 ��Ʈ��ũ �� �и�', '�������� ���ͳݸ� �и��� ���� ���� ��ȭ', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 13000000, TO_DATE('2024-04-15', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0002', 'MEM_004', '�����');
END;
/

-- 47
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'T', '�����ͺ��̽� ���̱׷��̼�', 'Oracle DB���� PostgreSQL�� ������ ����', TO_DATE('2025-10-15', 'YYYY-MM-DD'), TO_DATE('2025-11-15', 'YYYY-MM-DD'), 10000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0004', 'MEM_001', '�����');
END;
/

-- 48
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'W', '���� ����� ����', '�� ���ø����̼� �� ���� ������ ���� ����', TO_DATE('2025-08-10', 'YYYY-MM-DD'), TO_DATE('2025-08-25', 'YYYY-MM-DD'), 9000000, TO_DATE('2025-08-01', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0008', 'MEM_002', '�����');
END;
/

-- 49
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'C', '��ǰ ȫ���� ��ν��� ����', '3�� ���� ���÷� ������ �� 2000�� �μ�', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'), 3500000, TO_DATE('2024-05-25', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0005', 'MEM_003', '�����');
END;
/

-- 50
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'X', '����Ʈ ���丮 �ý��� ���� ������', '���� ���� �ڵ�ȭ �� ������ ���� �ý��� ������', TO_DATE('2025-09-01', 'YYYY-MM-DD'), TO_DATE('2025-10-31', 'YYYY-MM-DD'), 22000000, TO_DATE('2025-08-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0001', 'MEM_004', '�����');
END;
/

-- 51
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'C', '2024�� 2�б� ���� ���� ����', '���� �˻�, ���÷���, ��Ʃ�� ���� �', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 12000000, TO_DATE('2024-03-20', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0006', 'MEM_001', '�����');
END;
/

-- 52
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'W', '������ �ð�ȭ ��ú��� ����', '���� �� ����� ������ �м��� Tableau ��ú��� ����', TO_DATE('2025-11-10', 'YYYY-MM-DD'), TO_DATE('2025-12-10', 'YYYY-MM-DD'), 13000000, TO_DATE('2025-11-01', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0009', 'MEM_002', '�����');
END;
/

-- 53
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'T', '���ü�� ��� ��ǥ �ý���', '���� �� ������ ��ȭ�� �¶��� ��ǥ �ý��� ����', TO_DATE('2026-06-01', 'YYYY-MM-DD'), TO_DATE('2026-11-30', 'YYYY-MM-DD'), 180000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0004', 'MEM_003', '�����');
END;
/

-- 54
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'C', '2024�� 1�б� ��ȣ����', 'ȸ�� ��ǥ ����Ʈ �� ��α� ��ȣ����', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 150000, TO_DATE('2023-12-28', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0010', 'MEM_004', '�����');
END;
/

-- 55
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'W', '���������� ����', '�ű� ���θ�� ȫ���� ���� �������� ���������� ����', TO_DATE('2025-09-01', 'YYYY-MM-DD'), TO_DATE('2025-09-15', 'YYYY-MM-DD'), 2500000, TO_DATE('2025-08-25', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0007', 'MEM_001', '�����');
END;
/

-- 56
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'X', '�系 �׷���� ������ ������', '���� �׷���� ��뼺 ������ ���� UI ������ ����', TO_DATE('2025-10-01', 'YYYY-MM-DD'), TO_DATE('2025-11-30', 'YYYY-MM-DD'), 14000000, TO_DATE('2025-09-22', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0002', 'MEM_002', '�����');
END;
/

-- 57
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_003', 'C', '2024�� 3�б� ī�崺�� ����', '���̽���, �ν�Ÿ�׷��� ī�崺�� �� 8�� ����', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 4500000, TO_DATE('2024-06-21', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0008', 'MEM_003', '�����');
END;
/

-- 58
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_004', 'W', '���� �� DB ���� Ʃ��', '���� ���� ���� �ذ��� ���� �ý��� ���� Ʃ��', TO_DATE('2025-11-20', 'YYYY-MM-DD'), TO_DATE('2025-12-05', 'YYYY-MM-DD'), 6000000, TO_DATE('2025-11-15', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0003', 'MEM_004', '�����');
END;
/

-- 59
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_001', 'T', '����� �Ŵ��� ����', '�ű� ����Ʈ���� ����� �� �����ڿ� �Ŵ��� ����', TO_DATE('2025-12-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 3000000, NULL)
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0005', 'MEM_001', '�����');
END;
/

-- 60
DECLARE
  v_contract_no VARCHAR2(20);
BEGIN
  INSERT INTO TBL_CONTRACT (CONTRACT_NO, MEMBER_NO, STATUS_CODE, CONTRACT_TITLE, CONTRACT_CONTENT, CONTRACT_START, CONTRACT_END, CONTRACT_DEPOSIT, CONTRACT_CONFIRM) 
  VALUES ('CNO_'||LPAD(SEQ_TBL_CONTRACT_NO.NEXTVAL, 4, '0'), 'MEM_002', 'W', '�� ������ ��������', '�¶��� ���� �ý����� �̿��� �� ������ ���� �� �м�', TO_DATE('2025-08-20', 'YYYY-MM-DD'), TO_DATE('2025-09-10', 'YYYY-MM-DD'), 3000000, TO_DATE('2025-08-15', 'YYYY-MM-DD'))
  RETURNING CONTRACT_NO INTO v_contract_no;
  INSERT INTO TBL_CONTRACT_PARTY (ID, CONTRACT_NO, COMP_CD, MEMBER_NO, ROLE) 
  VALUES (SEQ_CONTRACT_PARTY_ID.NEXTVAL, v_contract_no, 'COMP0001', 'MEM_002', '�����');
END;
/
commit;
-- [��� �ο쵥���� ��]




SELECT * FROM TBL_CONTRACT;
select * from tbl_contract_party;

delete from tbl_contract;
delete from tbl_contract_party;
commit;

-- ������ ���� �� Ȯ��
COMMIT;
SELECT * FROM TBL_CONTRACT;
SELECT * FROM TBL_CONTRACT_PARTY;

SELECT * FROM TBL_COMPANY;

UPDATE TBL_COMPANY
SET 
    TRADE_STATUS = '2'
WHERE COMP_CD IN (
    'COMP0011', 'COMP0012', 'COMP0013', 'COMP0014', 'COMP0015',
    'COMP0016', 'COMP0017', 'COMP0018', 'COMP0019', 'COMP0020',
    'COMP0021', 'COMP0022', 'COMP0023', 'COMP0024', 'COMP0025',
    'COMP0026', 'COMP0027', 'COMP0028', 'COMP0029', 'COMP0030'
);

-- ������ ���� �� ���� ����
COMMIT;

-- ��� Ȯ�� (�ŷ� ���º��� ���� �����)
SELECT TRADE_STATUS, COUNT(*)
FROM TBL_COMPANY
GROUP BY TRADE_STATUS;

commit;

-- ���� ��ȣ ������
CREATE SEQUENCE SEQ_TBL_FILE_NO START WITH 1 INCREMENT BY 1;

commit;


-- 20250715 �߰��� ��--
-- TBL_CONTRACT_PARTY ���̺� ���� �̹��� �÷� �߰�
ALTER TABLE TBL_CONTRACT_PARTY ADD (SIGNATURE_IMAGE CLOB);
-- ���� �̹��� �÷��� ���� �ּ�(����) �߰�
COMMENT ON COLUMN TBL_CONTRACT_PARTY.SIGNATURE_IMAGE IS '���� �̹��� ������ (Base64)';

-- 20250716 �߰��� ��--
-- TBL_CONTRACT_PARTY ���̺� ������ �÷��� �߰�
ALTER TABLE TBL_CONTRACT_PARTY ADD (
    SIGNED CHAR(1) DEFAULT 'N' NOT NULL,
    SIGNED_DATE DATE
);
-- �߰��� �÷��鿡 ���� �ּ�(����) �߰�
COMMENT ON COLUMN TBL_CONTRACT_PARTY.SIGNED IS '���� �Ϸ� ���� (Y/N)';
COMMENT ON COLUMN TBL_CONTRACT_PARTY.SIGNED_DATE IS '���� �Ϸ� ����';

-- û�� ���� ���̺� �߰�
CREATE TABLE TBL_INVOICE_STATUS (
    INVOICE_STATUS_CODE VARCHAR2(2) NOT NULL, -- P(�߼���) U(�̳�) O(�����ʰ�)C(�Ϸ�)
    INVOICE_STATUS_NAME VARCHAR2(50) NOT NULL, -- ���� ����(�߼���, �̳�, �����ʰ�, �Ϸ�)
    
    CONSTRAINT PK_TBL_INVOICE_STATUS PRIMARY KEY (INVOICE_STATUS_CODE) -- �����ڵ� ���� �⺻Ű        
);
-- TBL_INVOICE_STATUS ���̺� ������ ����
INSERT INTO TBL_INVOICE_STATUS (INVOICE_STATUS_CODE, INVOICE_STATUS_NAME) VALUES ('P', '�߼���');
INSERT INTO TBL_INVOICE_STATUS (INVOICE_STATUS_CODE, INVOICE_STATUS_NAME) VALUES ('U', '�̳�');
INSERT INTO TBL_INVOICE_STATUS (INVOICE_STATUS_CODE, INVOICE_STATUS_NAME) VALUES ('O', '�����ʰ�');
INSERT INTO TBL_INVOICE_STATUS (INVOICE_STATUS_CODE, INVOICE_STATUS_NAME) VALUES ('C', '���οϷ�');
COMMIT; -- ��������� Ȯ���մϴ�.

-- TBL_INVOICE ���̺� û�� ���� �÷� �߰�
ALTER TABLE TBL_INVOICE ADD (
    INVOICE_STATUS_CODE VARCHAR2(2) DEFAULT 'P' NOT NULL
);
-- TBL_INVOICE ���̺� �ܷ� Ű ���� ���� �߰�
ALTER TABLE TBL_INVOICE ADD CONSTRAINT FK_INVOICE_STATUS
FOREIGN KEY (INVOICE_STATUS_CODE)
REFERENCES TBL_INVOICE_STATUS (INVOICE_STATUS_CODE);


select * from tbl_member;
select * from tbl_company;
select * from tbl_company_member;
select * from TBL_CONTRACT_PARTY;   
select * from TBL_CONTRACT_HISTORY;
select * from tbl_contract order by contract_no desc;
select * from tbl_file;
SELECT * FROM TBL_INVOICE;

--------------------------
select * from tbl_member;
select * from tbl_schedule;
select * from tbl_meeting;

SELECT * FROM TBL_SCHEDULE WHERE ROWNUM <= 3;

SELECT * FROM user_sequences WHERE sequence_name = 'SEQ_SCHEDULE_NO';
CREATE SEQUENCE seq_schedule_no
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-------���� �߰�
CREATE TABLE TBL_SCHEDULE_STATUS (
    STATUS_CODE VARCHAR2(2) PRIMARY KEY,
    STATUS_NAME VARCHAR2(30)
);
-- ���� ���� ǥ��
INSERT INTO TBL_SCHEDULE_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('W', '���');
INSERT INTO TBL_SCHEDULE_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('C', '�Ϸ�');
INSERT INTO TBL_SCHEDULE_STATUS (STATUS_CODE, STATUS_NAME) VALUES ('D', '����');

-- TBL_SCHEDULE�� FK ����(����: FK_SCHEDULE_STATUS) ����
ALTER TABLE TBL_SCHEDULE DROP CONSTRAINT FK_SCHEDULE_STATUS;
ALTER TABLE TBL_SCHEDULE DROP CONSTRAINT FK_SCHEDULE_MEMBER;
ALTER TABLE TBL_SCHEDULE DROP CONSTRAINT FK_SCHEDULE_CONTRACT;

-- ���� ���� ���� ���� 
ALTER TABLE TBL_SCHEDULE MODIFY (SCHEDULE_TITLE VARCHAR2(50));

commit;
