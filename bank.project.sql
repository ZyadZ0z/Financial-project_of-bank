show 
columns 
from bank_project.prosperloandata;



-- first we will modify all data types for this table  to be able to make different calculations 


ALTER TABLE bank_project.prosperloandata

MODIFY ListingKey VARCHAR(255),

MODIFY ListingNumber VARCHAR(255),

MODIFY ListingCreationDate DATE,

MODIFY CreditGrade VARCHAR(5),

MODIFY Term INT,

MODIFY LoanStatus VARCHAR(50),

MODIFY ClosedDate DATE,

MODIFY BorrowerAPR DECIMAL(5, 2),

MODIFY BorrowerRate DECIMAL(5, 2),

MODIFY LenderYield DECIMAL(5, 2),

MODIFY EstimatedEffectiveYield DECIMAL(5, 2),

MODIFY EstimatedLoss DECIMAL(5, 2),

MODIFY EstimatedReturn DECIMAL(5, 2),

MODIFY `ProsperRating (numeric)` INT,

MODIFY `ProsperRating (Alpha)` VARCHAR(255),

MODIFY ProsperScore INT,

MODIFY `ListingCategory (numeric)` INT,

MODIFY BorrowerState CHAR(2),

MODIFY Occupation VARCHAR(100),

MODIFY EmploymentStatus VARCHAR(50),

MODIFY EmploymentStatusDuration INT,

MODIFY IsBorrowerHomeowner BOOLEAN,

MODIFY CurrentlyInGroup BOOLEAN,

MODIFY GroupKey VARCHAR(255),

MODIFY DateCreditPulled DATE,

MODIFY CreditScoreRangeLower INT,

MODIFY CreditScoreRangeUpper INT,

MODIFY FirstRecordedCreditLine DATE,

MODIFY CurrentCreditLines INT,

MODIFY OpenCreditLines INT,

MODIFY TotalCreditLinespast7years INT,

MODIFY OpenRevolvingAccounts INT,

MODIFY OpenRevolvingMonthlyPayment DECIMAL(10, 2),

MODIFY InquiriesLast6Months INT,

MODIFY TotalInquiries INT,

MODIFY CurrentDelinquencies INT,

MODIFY AmountDelinquent DECIMAL(10, 2),

MODIFY DelinquenciesLast7Years INT,

MODIFY PublicRecordsLast10Years INT,

MODIFY PublicRecordsLast12Months INT,

MODIFY RevolvingCreditBalance DECIMAL(10, 2),

MODIFY BankcardUtilization DECIMAL(5, 2),

MODIFY AvailableBankcardCredit DECIMAL(10, 2),

MODIFY TotalTrades INT,

MODIFY `TradesNeverDelinquent (percentage)` DECIMAL(5, 2),

MODIFY TradesOpenedLast6Months INT,

MODIFY DebtToIncomeRatio DECIMAL(5, 2),

MODIFY IncomeRange VARCHAR(50),

MODIFY IncomeVerifiable BOOLEAN,

MODIFY StatedMonthlyIncome DECIMAL(10, 2),

MODIFY LoanKey VARCHAR(255),

MODIFY TotalProsperLoans INT,

MODIFY TotalProsperPaymentsBilled INT,

MODIFY OnTimeProsperPayments INT,

MODIFY ProsperPaymentsLessThanOneMonthLate INT,

MODIFY ProsperPaymentsOneMonthPlusLate INT,

MODIFY ProsperPrincipalBorrowed DECIMAL(10, 2),

MODIFY ProsperPrincipalOutstanding DECIMAL(10, 2),

MODIFY ScorexChangeAtTimeOfListing DECIMAL(5, 2),

MODIFY LoanCurrentDaysDelinquent INT,

MODIFY LoanFirstDefaultedCycleNumber INT,

MODIFY LoanMonthsSinceOrigination INT,

MODIFY LoanNumber INT,

MODIFY LoanOriginalAmount DECIMAL(10, 2),

MODIFY LoanOriginationDate DATE,

MODIFY LoanOriginationQuarter VARCHAR(10),

MODIFY MemberKey VARCHAR(255),

MODIFY MonthlyLoanPayment DECIMAL(10, 2),

MODIFY LP_CustomerPayments DECIMAL(10, 2),

MODIFY LP_CustomerPrincipalPayments DECIMAL(10, 2),

MODIFY LP_InterestandFees DECIMAL(10, 2),

MODIFY LP_ServiceFees DECIMAL(10, 2),

MODIFY LP_CollectionFees DECIMAL(10, 2),

MODIFY LP_GrossPrincipalLoss DECIMAL(10, 2),

MODIFY LP_NetPrincipalLoss DECIMAL(10, 2),

MODIFY LP_NonPrincipalRecoverypayments DECIMAL(10, 2),

MODIFY PercentFunded DECIMAL(5, 2),

MODIFY Recommendations INT,

MODIFY InvestmentFromFriendsCount INT,

MODIFY InvestmentFromFriendsAmount DECIMAL(10, 2),

MODIFY Investors INT;







--  Data cleanning Phase 


select 
case when 
BorrowerAPR is null then 1  end  as Miss_BorrowerAPR, 
case when 
CreditScoreRangeLower is null then 1 end  as Miss_CreditScoreRangeLower,
case when 
LoanStatus is null then 1 end as Miss_LoanStatus

from bank_project.prosperloandata;







SELECT 
    COUNT(CASE WHEN BorrowerAPR IS NULL THEN 1 END) AS MissingAPR,
    COUNT(CASE WHEN CreditScoreRangeLower IS NULL THEN 1 END) AS MissingCreditScoreLower,
    COUNT(CASE WHEN LoanStatus IS NULL THEN 1 END) AS MissingLoanStatus,
    COUNT(CASE WHEN ListingKey IS NULL THEN 1 END) AS MissingListingKey,
    COUNT(CASE WHEN ProsperPaymentsLessThanOneMonthLate IS NULL THEN 1 END) AS MissingProsperPaymentsLessThan,
    COUNT(CASE WHEN ProsperPaymentsOneMonthPlusLate IS NULL THEN 1 END) AS MissingProsperPaymentsOneMonthPlusLate,
    COUNT(CASE WHEN ProsperPrincipalBorrowed IS NULL THEN 1 END) AS MissingProsperPrincipalBorrowed,
    COUNT(CASE WHEN ProsperPrincipalOutstanding IS NULL THEN 1 END) AS MissingProsperPrincipalOutstanding,
    COUNT(CASE WHEN LoanCurrentDaysDelinquent IS NULL THEN 1 END) AS MissingLoanCurrentDaysDelinquent,
    COUNT(CASE WHEN Investors IS NULL THEN 1 END) AS MissingInvestors,
    COUNT(CASE WHEN LP_CustomerPayments IS NULL THEN 1 END) AS MissingLP_CustomerPayments
    
FROM bank_project.prosperloandata;





-- ProsperRating &ListingCategory delete 

select 
*,
LoanNumber,
LoanMonthsSinceOrigination,
LoanFirstDefaultedCycleNumber,
LoanOriginationDate 

from bank_project.prosperloandata
where  TotalTrades  
is null ;





select 
ListingNumber  ,
ListingCreationDate,
COALESCE( ListingCreationDate,'N/a') as nul_ofListingCreationDate
from bank_project.prosperloandata;





select 
CreditGrade,
ClosedDate,
COALESCE (CreditGrade, 'N/A')AS CreditGrade_NULLS,
coalesce(ClosedDate,'n/a') as ClosedDate_null
from bank_project.prosperloandata
group by 1;







-- Handel outliers 


SELECT 
    LoanOriginalAmount,
    COUNT(*)
FROM bank_project.prosperloandata
WHERE LoanOriginalAmount > 100000 OR LoanOriginalAmount < 500
GROUP BY LoanOriginalAmount;








-- deping in Exploratory data analysis {EDA} 





select 
* 
from bank_project .prosperloandata ;





select 
distinct ( BorrowerState) as BorrowerState_distinct_values,
BorrowerState
from bank_project .prosperloandata
where BorrowerState is not  null 
 group by  2  ; 





select 
distinct ( LoanStatus)  as LoanStatus_distinct_values ,
LoanStatus
from bank_project .prosperloandata
group by 2 ;





SELECT 
    BorrowerState, 
    EmploymentStatus, 
    COUNT(*) AS TotalLoans, 
    SUM(CASE WHEN LoanStatus = 'Defaulted' THEN 1 ELSE 0 END) AS DefaultedLoans
FROM bank_project.prosperloandata
GROUP BY 1,2
ORDER BY DefaultedLoans DESC;





select 
CreditScoreRangeLower ,
CreditScoreRangeUpper,
avg(BorrowerRate) as BRO_rate 
from bank_project.prosperloandata
group by 1,2 
order by 3;



-- To clear the difference between Completed status and Defaulted status in loanstatues 


SELECT 
    DebtToIncomeRatio, 
    COUNT(*) AS TotalLoans, 
    SUM(CASE WHEN LoanStatus = 'Completed' THEN 1 ELSE 0 END) AS ApprovedLoans
FROM bank_project.prosperloandata
GROUP BY DebtToIncomeRatio
ORDER BY DebtToIncomeRatio;




SELECT 
    BorrowerAPR, 
    COUNT(*) AS TotalLoans, 
    SUM(CASE WHEN LoanStatus = 'Defaulted' THEN 1 ELSE 0 END) AS DefaultedLoans
FROM bank_project.prosperloandata
GROUP BY BorrowerAPR
ORDER BY BorrowerAPR DESC;






-- Rank loans by  how quickly they defaulted


SELECT 
    ListingNumber, 
    LoanStatus, 
    LoanCurrentDaysDelinquent,
    ROW_NUMBER() OVER (PARTITION BY LoanStatus ORDER BY LoanCurrentDaysDelinquent DESC) AS DefaultRank
FROM bank_project.prosperloandata
WHERE LoanStatus = 'Defaulted'
ORDER BY DefaultRank;



-- calculate a running total of loan amounts issued to borrowers 

SELECT 
    BorrowerState, 
    LoanOriginationDate, 
    LoanOriginalAmount, 
    SUM(LoanOriginalAmount) OVER (PARTITION BY BorrowerState ORDER BY LoanOriginationDate) AS RunningTotalLoanAmount
FROM bank_project.prosperloandata
ORDER BY BorrowerState, LoanOriginationDate;



--  to track the average APR of the last 5 loans made per state 


SELECT 
    BorrowerState, 
    LoanOriginationDate, 
    BorrowerAPR, 
    AVG(BorrowerAPR) OVER (PARTITION BY BorrowerState ORDER BY LoanOriginationDate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS MovingAvgAPR
FROM bank_project.prosperloandata
ORDER BY BorrowerState, LoanOriginationDate;




-- To analyze how borrower credit scores rank within each state


SELECT 
    BorrowerState, 
    ListingNumber, 
    CreditScoreRangeLower, 
    RANK() OVER (PARTITION BY BorrowerState ORDER BY CreditScoreRangeLower DESC) AS CreditScoreRank
FROM bank_project.prosperloandata
ORDER BY BorrowerState, CreditScoreRank;



-- compare rows with preceding or following rows.

SELECT 
    BorrowerState, 
    LoanOriginationDate, 
    BorrowerAPR, 
    LAG(BorrowerAPR, 1) OVER (PARTITION BY BorrowerState ORDER BY LoanOriginationDate) AS PrevBorrowerAPR,
    BorrowerAPR - LAG(BorrowerAPR, 1) OVER (PARTITION BY BorrowerState ORDER BY LoanOriginationDate) AS APRDifference
FROM bank_project.prosperloandata
ORDER BY BorrowerState, LoanOriginationDate;



-- If you want to divide your borrowers into quartiles based on their income range 


SELECT 
    ListingNumber, 
    LoanOriginalAmount, 
    NTILE(4) OVER (ORDER BY LoanOriginalAmount DESC) AS IncomeQuartile
FROM bank_project.prosperloandata
ORDER BY LoanOriginalAmount DESC;



-- If you want to calculate the time difference between loan origination and default for each loan


SELECT 
    ListingNumber, 
    LoanOriginationDate, 
    ClosedDate, 
    DATEDIFF(ClosedDate, LoanOriginationDate) AS DaysToDefault,
    RANK() OVER (ORDER BY DATEDIFF(ClosedDate, LoanOriginationDate) DESC) AS DefaultDurationRank
FROM bank_project.prosperloandata
WHERE LoanStatus = 'Defaulted';


