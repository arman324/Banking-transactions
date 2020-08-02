create Table Customer (
    CID INT IDENTITY(1,1),
    Name Varchar(40),
    NatCod VARCHAR(10) UNIQUE,
    Birthdate Date,
    Addr VARCHAR(100),
    Tel VARCHAR(15),
    PRIMARY KEY (CID)
)

create Table Deposit_Type (
    Dep_Type INT,
    Dep_Typ_Desc VARCHAR(100),
    PRIMARY KEY(Dep_Type)
)

create Table Deposit_Status (
    Status INT,
    Status_Desc VARCHAR(100),
    PRIMARY KEY(Status)
)

create Table Branch (
    Branch_ID INT,
    Branch_Name VARCHAR(30),
    Branch_Addr VARCHAR(100),
    Branch_Tel VARCHAR(15),
    PRIMARY KEY(Branch_ID)
)

create TABLE Trn_Src_Des (
    VoucherId VARCHAR(10),
    TrnDate date,
    TrnTime VARCHAR(10),
    Amount BIGINT,
    SourceDep INT,
    DesDep INT,
    Branch_ID INT,
    Trn_Desc VARCHAR(100),
    PRIMARY KEY (VoucherId),
    FOREIGN KEY (Branch_ID) references Branch(Branch_ID) 
)

create table Deposit (
    Dep_ID INT IDENTITY(1,1),
    Dep_Type INT,
    CID INT,
    OpenDate DATE,
    Status INT,
    PRIMARY KEY (Dep_ID),
    FOREIGN KEY (Dep_Type) references Deposit_Type(Dep_Type), 
    FOREIGN KEY (CID) references Customer(CID),
    FOREIGN KEY (Status) references Deposit_Status(Status),
)


-- Customer
INSERT INTO Customer VALUES ('Alexis Dalton','6660163549','1997-06-19','Dallas','+1-2303495331')
INSERT INTO Customer VALUES ('Archer Covel','0068960379','1987-7-25','NewYork','+1-2303495342')
INSERT INTO Customer VALUES ('Graham Dale','650716205','1999-12-05','Dallas','+1-2303495353')
INSERT INTO Customer VALUES ('Marley Flemons','0637753832','1979-04-09','Baltimore','+1-8883495455')
INSERT INTO Customer VALUES ('Maggie Clay','0480231079','1986-05-21','Baltimore','+1-8855566455')
INSERT INTO Customer VALUES ('Rylan Evens','1284922121','1994-08-15','NewYork','+1-9965566832')
INSERT INTO Customer VALUES ('Annie Courte','67062571','1994-09-26','Baltimore','+1-3455566992')
INSERT INTO Customer VALUES ('Juliet Grenfell','0719583293','1984-11-13','Baltimore','+1-7854266772')
INSERT INTO Customer VALUES ('Lane Gaunt','4889483683','1993-04-18','Dallas','+1-6644268821')
INSERT INTO Customer VALUES ('Peyton Halpert','1370372868','1979-03-05','NewYork','+1-6453267776')
INSERT INTO Customer VALUES ('Harley Hardison','4120128431','1973-09-12','NewYork','+1-9802775539')


-- Branch
INSERT INTO Branch VALUES (1,'Branch-01','Baltimore','+1-2899495399')
INSERT INTO Branch VALUES (2,'Branch-02','Dallas','+1-8093466669')
INSERT INTO Branch VALUES (3,'Branch-03','NewYork','+1-4833490944')


-- Deposit_Status
INSERT INTO Deposit_Status VALUES (1,'Active')
INSERT INTO Deposit_Status VALUES (2,'Passive')


-- Deposit_Type
INSERT INTO Deposit_Type VALUES (1,'Deposit type one')
INSERT INTO Deposit_Type VALUES (2,'Deposit type two')
INSERT INTO Deposit_Type VALUES (3,'Deposit type three')


-- Deposit
INSERT INTO Deposit VALUES (1,1,'2018-06-24',1)
INSERT INTO Deposit VALUES (1,2,'2018-11-04',1)
INSERT INTO Deposit VALUES (1,3,'2018-12-18',1)
INSERT INTO Deposit VALUES (2,4,'2018-10-15',1)
INSERT INTO Deposit VALUES (2,5,'2018-05-27',1)
INSERT INTO Deposit VALUES (2,6,'2018-05-09',1)
INSERT INTO Deposit VALUES (3,7,'2018-03-06',1)
INSERT INTO Deposit VALUES (3,8,'2018-01-10',1)
INSERT INTO Deposit VALUES (3,9,'2018-07-12',1)
INSERT INTO Deposit VALUES (3,10,'2018-11-14',1)
INSERT INTO Deposit VALUES (3,11,'2018-12-21',1)


-- Trn_Src_Des
-- deposit above with 1000 means in-person
INSERT INTO Trn_Src_Des VALUES ('1000000000','2019-02-16','100101',19,101,1,2,'Another Bank pays $19 to 3')
INSERT INTO Trn_Src_Des VALUES ('1000000001','2019-04-05','100101',65,1000,2,2,'in-person')

INSERT INTO Trn_Src_Des VALUES ('1000000002','2019-03-16','100101',20,1,3,2,'1 pays $20 to 3')
INSERT INTO Trn_Src_Des VALUES ('1000000003','2019-03-26','100101',20,1001,3,2,'in-person')
INSERT INTO Trn_Src_Des VALUES ('1000000004','2019-04-06','110101',60,2,3,3,'2 pays $60 to 3')

INSERT INTO Trn_Src_Des VALUES ('1000000005','2019-04-16','110101',100,3,4,2,'3 pays $100 to 4')

INSERT INTO Trn_Src_Des VALUES ('1000000006','2019-04-17','110101',100,4,5,1,'4 pays $100 to 5')
INSERT INTO Trn_Src_Des VALUES ('1000000007','2019-04-17','110102',40,4,6,1,'4 pays $40 to 6')
INSERT INTO Trn_Src_Des VALUES ('1000000008','2019-04-17','110103',50,4,7,1,'4 pays $50 to 7')
INSERT INTO Trn_Src_Des VALUES ('1000000009','2019-04-18','110101',20,4,8,1,'4 pays $20 to 8')
INSERT INTO Trn_Src_Des VALUES ('1000000010','2019-04-18','110102',40,4,11,1,'4 pays $40 to 11')
INSERT INTO Trn_Src_Des VALUES ('1000000011','2019-04-18','110103',100,4,10,1,'4 pays $100 to 10')

INSERT INTO Trn_Src_Des VALUES ('1000000012','2019-04-18','110101',30,7,9,1,'7 pays $30 to 9')
INSERT INTO Trn_Src_Des VALUES ('1000000013','2019-04-18','110102',25,7,100,1,'7 pays $25 to Another Bank')
INSERT INTO Trn_Src_Des VALUES ('1000000014','2019-04-19','110101',30,9,1002,2,'in-person')

INSERT INTO Trn_Src_Des VALUES ('1000000015','2019-04-26','110101',50,5,20,2,'5 pays $50 to 20')
INSERT INTO Trn_Src_Des VALUES ('1000000016','2019-04-27','110101',20,20,21,2,'20 pays $20 to 21')
INSERT INTO Trn_Src_Des VALUES ('1000000017','2019-04-29','110101',30,20,22,2,'20 pays $30 to 22')
INSERT INTO Trn_Src_Des VALUES ('1000000018','2019-05-05','110101',20,22,23,2,'22 pays $20 to 23')
INSERT INTO Trn_Src_Des VALUES ('1000000019','2019-05-08','110101',5,23,24,2,'23 pays $5 to 24')
INSERT INTO Trn_Src_Des VALUES ('1000000020','2019-05-10','110101',5,23,25,2,'20 pays $5 to 25')


alter view vCustomer AS 
    select Name, NatCod, Tel, case
                            when LEN(NatCod) = 8 then case 
                                                    when ((CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),9,1))*2)) % 11) < 2 then case 
                                                                                                                                                                                                                                                                                                                        when ((CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),9,1))*2)) % 11) = SUBSTRING(CONCAT('00',NatCod),10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    when ((CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),9,1))*2)) % 11) >= 2 then case 
                                                                                                                                                                                                                                                                                                                        when 11 - ((CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('00',NatCod),9,1))*2)) % 11) = SUBSTRING(CONCAT('00',NatCod),10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    END 
                            when LEN(NatCod) = 9 then case 
                                                    when ((CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),9,1))*2)) % 11) < 2 then case 
                                                                                                                                                                                                                                                                                                                        when ((CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),9,1))*2)) % 11) = SUBSTRING(CONCAT('0',NatCod),10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    when ((CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),9,1))*2)) % 11) >= 2 then case 
                                                                                                                                                                                                                                                                                                                        when 11 - ((CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),1,1))*10) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),2,1))*9) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),3,1))*8) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),4,1))*7) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),5,1))*6) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),6,1))*5) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),7,1))*4) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),8,1))*3) + CONVERT(INT,(SUBSTRING(CONCAT('0',NatCod),9,1))*2)) % 11) = SUBSTRING(CONCAT('0',NatCod),10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    END 
                            when LEN(NatCod) = 10 then case 
                                                    when ((CONVERT(INT,(SUBSTRING(NatCod,1,1))*10) + CONVERT(INT,(SUBSTRING(NatCod,2,1))*9) + CONVERT(INT,(SUBSTRING(NatCod,3,1))*8) + CONVERT(INT,(SUBSTRING(NatCod,4,1))*7) + CONVERT(INT,(SUBSTRING(NatCod,5,1))*6) + CONVERT(INT,(SUBSTRING(NatCod,6,1))*5) + CONVERT(INT,(SUBSTRING(NatCod,7,1))*4) + CONVERT(INT,(SUBSTRING(NatCod,8,1))*3) + CONVERT(INT,(SUBSTRING(NatCod,9,1))*2)) % 11) < 2 then case 
                                                                                                                                                                                                                                                                                                                        when ((CONVERT(INT,(SUBSTRING(NatCod,1,1))*10) + CONVERT(INT,(SUBSTRING(NatCod,2,1))*9) + CONVERT(INT,(SUBSTRING(NatCod,3,1))*8) + CONVERT(INT,(SUBSTRING(NatCod,4,1))*7) + CONVERT(INT,(SUBSTRING(NatCod,5,1))*6) + CONVERT(INT,(SUBSTRING(NatCod,6,1))*5) + CONVERT(INT,(SUBSTRING(NatCod,7,1))*4) + CONVERT(INT,(SUBSTRING(NatCod,8,1))*3) + CONVERT(INT,(SUBSTRING(NatCod,9,1))*2)) % 11) = SUBSTRING(NatCod,10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    when ((CONVERT(INT,(SUBSTRING(NatCod,1,1))*10) + CONVERT(INT,(SUBSTRING(NatCod,2,1))*9) + CONVERT(INT,(SUBSTRING(NatCod,3,1))*8) + CONVERT(INT,(SUBSTRING(NatCod,4,1))*7) + CONVERT(INT,(SUBSTRING(NatCod,5,1))*6) + CONVERT(INT,(SUBSTRING(NatCod,6,1))*5) + CONVERT(INT,(SUBSTRING(NatCod,7,1))*4) + CONVERT(INT,(SUBSTRING(NatCod,8,1))*3) + CONVERT(INT,(SUBSTRING(NatCod,9,1))*2)) % 11) >= 2 then case 
                                                                                                                                                                                                                                                                                                                        when 11 - ((CONVERT(INT,(SUBSTRING(NatCod,1,1))*10) + CONVERT(INT,(SUBSTRING(NatCod,2,1))*9) + CONVERT(INT,(SUBSTRING(NatCod,3,1))*8) + CONVERT(INT,(SUBSTRING(NatCod,4,1))*7) + CONVERT(INT,(SUBSTRING(NatCod,5,1))*6) + CONVERT(INT,(SUBSTRING(NatCod,6,1))*5) + CONVERT(INT,(SUBSTRING(NatCod,7,1))*4) + CONVERT(INT,(SUBSTRING(NatCod,8,1))*3) + CONVERT(INT,(SUBSTRING(NatCod,9,1))*2)) % 11) = SUBSTRING(NatCod,10,1) then 'True' 
                                                                                                                                                                                                                                                                                                                        ELSE 'False'
                                                                                                                                                                                                                                                                                                                        END
                                                    END 
                            END as VerifyNatCod
    from Customer


select * from Customer
select * from Branch
select * from Deposit_Status
select * from Deposit_Type
select * from Deposit
select * from Trn_Src_Des

select * from vCustomer

drop table Customer
drop table Deposit
drop table Trn_Src_Des
drop table Branch
drop table Deposit_Status
drop table Deposit_Type
drop table myOutput
drop table tr
drop table tempTableOfTrans

create table myOutput (
    VoucherId VARCHAR(10),
    TrnDate date,
    TrnTime VARCHAR(10),
    Amount BIGINT,
    SourceDep INT,
    DesDep INT,
    Branch_ID INT,
    Trn_Desc VARCHAR(100),
    RowNumber INT
)

create table tr (
    VoucherId VARCHAR(10),
    TrnDate date,
    TrnTime VARCHAR(10),
    Amount BIGINT,
    SourceDep INT,
    DesDep INT,
    Branch_ID INT,
    Trn_Desc VARCHAR(100),
    RowNumber INT
)

create table tempTableOfTrans (
    VoucherId VARCHAR(10),
    TrnDate date,
    TrnTime VARCHAR(10),
    Amount BIGINT,
    SourceDep INT,
    DesDep INT,
    Branch_ID INT,
    Trn_Desc VARCHAR(100),
    RowNumber INT
)

create table myOutputLEFT (
    VoucherId VARCHAR(10),
    TrnDate date,
    TrnTime VARCHAR(10),
    Amount BIGINT,
    SourceDep INT,
    DesDep INT,
    Branch_ID INT,
    Trn_Desc VARCHAR(100),
    RowNumber INT
)