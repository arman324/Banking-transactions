create Table Customer (
    CID INT,
    Name Varchar(40),
    NatCod VARCHAR(10),
    Birthdate Date,
    Addr VARCHAR(100),
    Tel VARCHAR(15),
    PRIMARY KEY (CID)
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
    Dep_ID INT,
    Dep_Type INT,
    CID INT,
    OpenDate DATE,
    Status INT,
    PRIMARY KEY (Dep_ID),
    FOREIGN KEY (Dep_Type) references Deposit_Type(Dep_Type), 
    FOREIGN KEY (CID) references Customer(CID),
    FOREIGN KEY (Status) references Deposit_Status(Status),
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
