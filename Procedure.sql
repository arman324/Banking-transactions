alter PROCEDURE BankingTransactions (@VoucherId VARCHAR(10))
AS
    BEGIN

    declare @Amount BIGINT;
    declare @Source INT;
    declare @Dest INT;
    declare @TrnDate Date;
    declare @TrnTime Varchar(10);
    declare @RowNumber INT; 

    declare @A_Date date;
    declare @OneDayAfterA date;

    set @Amount = (select Amount from tempTableOfTrans where VoucherId = @VoucherId)
    set @Source = (select SourceDep from tempTableOfTrans where VoucherId = @VoucherId)
    set @Dest = (select DesDep from tempTableOfTrans where VoucherId = @VoucherId)
    set @TrnDate = (select TrnDate from tempTableOfTrans where VoucherId = @VoucherId)
    set @TrnTime = (select TrnTime from tempTableOfTrans where VoucherId = @VoucherId)
    set @RowNumber = (select RowNumber from tempTableOfTrans where VoucherId = @VoucherId)

    set @A_date = (select MIN(TrnDate) from tempTableOfTrans where (tempTableOfTrans.SourceDep = @Dest) and (tempTableOfTrans.RowNumber > @RowNumber))

    set @OneDayAfterA = DATEADD(DAY, 1, @A_date)

-- first case 
    insert into tr select * from tempTableOfTrans where TrnDate = @A_Date and Amount = @Amount and SourceDep = @Dest
    
-- second case 
    declare @TotalOfRowNumber int;
    set @TotalOfRowNumber = (select COUNT(*) from tempTableOfTrans)
    
    declare @i int;
    set @i = @RowNumber + 1
    
    declare @TotalAmount BIGINT;
    set @TotalAmount = 0

--case 2
    while @i <> @TotalOfRowNumber+1
        BEGIN
            if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount) is not NULL
                BEGIN
                    set @TotalAmount = @TotalAmount + (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount)
                    insert into tr select * from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount
                END    
            set @i = @i + 1
        END
-- case 3
    set @i = @RowNumber
    while @i <> @TotalOfRowNumber+1
        BEGIN
            if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest) is not NULL
                begin 
                    if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest) + @TotalAmount <= CONVERT(INT,(@Amount + @Amount * 0.1))
                        BEGIN
                            set @TotalAmount = @TotalAmount + (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest)
                            insert into tr select * from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest
                        END
                END        
            set @i = @i + 1
        END

insert into myOutput select * from tr


-- case 4
    declare @trCount int;
    set @trCount = (select COUNT(*) from tr)

    while @trCount > 0 
        BEGIN
            set @Amount = (select top 1 Amount from tr order by RowNumber ASC)
            set @Source = (select top 1 SourceDep from tr order by RowNumber ASC)
            set @Dest = (select top 1 DesDep from tr order by RowNumber ASC)
            set @TrnDate = (select top 1 TrnDate from tr order by RowNumber ASC)
            set @TrnTime = (select top 1 TrnTime from tr order by RowNumber ASC)
            set @RowNumber = (select top 1 RowNumber from tr order by RowNumber ASC)

            set @A_date = (select MIN(TrnDate) from tempTableOfTrans where (tempTableOfTrans.SourceDep = @Dest) and (tempTableOfTrans.RowNumber > @RowNumber))

-- case 1 in case 4
            insert into tr select * from tempTableOfTrans where TrnDate = @A_Date and Amount = @Amount and SourceDep = @Dest
            insert into myOutput select * from tempTableOfTrans where TrnDate = @A_Date and Amount = @Amount and SourceDep = @Dest
-- case 2 in case 4        
            set @TotalAmount = 0
            set @i = @RowNumber
            while @i <> @TotalOfRowNumber+1
                BEGIN
                    if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount) is not NULL
                        begin 
                            set @TotalAmount = @TotalAmount + (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount)
                            insert into tr select * from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount
                            insert into myOutput select * from tempTableOfTrans where RowNumber = @i and TrnDate = @A_Date and SourceDep = @Dest and Amount <> @Amount                        
                        END    
                    set @i = @i + 1
                END
-- case 3 in case 4
                set @i = @RowNumber
                while @i <> @TotalOfRowNumber+1
                    BEGIN
                        if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest) is not NULL
                            begin 
                                if (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest) + @TotalAmount <= CONVERT(INT,(@Amount + @Amount * 0.1))
                                    BEGIN
                                        set @TotalAmount = @TotalAmount + (select Amount from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest)
                                        insert into tr select * from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest
                                        insert into myOutput select * from tempTableOfTrans where RowNumber = @i and TrnDate > @A_Date and SourceDep = @Dest                          
                                    END
                            END        
                        set @i = @i + 1
                    END
            delete from tr where RowNumber = (select MIN(RowNumber) from tr)
            set @trCount = (select COUNT(*) from tr)
        END


        EXECUTE LeftSide @VoucherId
    END





delete from myOutput
delete from myOutputLEFT
delete from tr
delete from tempTableOfTrans

insert into tempTableOfTrans
select *, ROW_NUMBER() over (order by TrnDate, TrnTime)
from Trn_Src_Des

EXECUTE BankingTransactions 1000000005


-- select * from tempTableOfTrans
-- select * from Trn_Src_Des
-- select * from tr

select * from myOutput
select * from myOutputLEFT


delete from myOutput
delete from myOutputLEFT
delete from tr

