--This data was generated from the central bank of Nigeria website,
--the aims was to filter out and determine how many the Nigerian Naira 
--has been devalued against  major foreign currencies like the USD and GB Pounds


SELECT *
FROM PortfolioProject.dbo.exchange24082021


-- Standardize the date format

SELECT RateDate, CONVERT(Date,RateDate)
FROM PortfolioProject.dbo.exchange24082021

UPDATE PortfolioProject.dbo.exchange24082021
SET RateDate = CONVERT(Date, RateDate)


ALTER TABLE PortfolioProject.dbo.exchange24082021
ADD RateDateConverted Date;

UPDATE PortfolioProject.dbo.exchange24082021
SET RateDateConverted = CONVERT(Date, RateDate)


--To know how many currencies were listed on the CBN rate table
SELECT DISTINCT(Currency)
FROM PortfolioProject.dbo.exchange24082021


-- Round up the exhchange rates into whole numbers

SELECT ROUND(BuyingRate, 0), ROUND(CentralRate, 0), ROUND(SellingRate, 0)
FROM PortfolioProject.dbo.exchange24082021

UPDATE PortfolioProject.dbo.exchangRateDateConvertede24082021
SET BuyingRate = ROUND(BuyingRate, 0), CentralRate = ROUND(CentralRate, 0), SellingRate = ROUND(SellingRate, 0)



SELECT  RateDateConverted, Currency, RateYear, RateMonth, CentralRate
FROM PortfolioProject.dbo.exchange24082021
WHERE Currency like '%US%'


SELECT  RateDateConverted, Currency, RateYear, RateMonth, CentralRate
FROM PortfolioProject.dbo.exchange24082021
WHERE Currency like '%STERLING%'

-- Standardize the date formats on the newly created tables(USDExchangeRate)

SELECT CONVERT(Date,RateDateConverted)
FROM USDExchangeRate

UPDATE USDExchangeRate
SET RateDateConverted = CONVERT(Date,RateDateConverted)

ALTER TABLE USDExchangeRate
Add RateDateNew Date;

UPDATE USDExchangeRate
SET RateDateNew = CONVERT(Date,RateDateConverted)


-- Standardize the date formats on the newly created tables(PoundsExchangeRate)

SELECT CONVERT(Date,RateDateConverted)
FROM PoundsExchangeRate

UPDATE PoundsExchangeRate
SET RateDateConverted = CONVERT(Date,RateDateConverted)

ALTER TABLE PoundsExchangeRate
Add RateDateNew Date;

UPDATE PoundsExchangeRate
SET RateDateNew = CONVERT(Date,RateDateConverted)


-- Pull out the last two queries for USD and POUNDS and attempt to do a join in order to transform the table to a vertical data frame

SELECT  *
FROM PortfolioProject.dbo.USDExchangeRate

SELECT  *
FROM PortfolioProject.dbo.PoundsExchangeRate


SELECT Dollars.RateDateNew, Dollars.RateMonth, Dollars.RateYear, Dollars.Currency, Dollars.CentralRate, Pounds.Currency, Pounds.CentralRate
FROM USDExchangeRate AS Dollars
JOIN PoundsExchangeRate AS Pounds
	ON Dollars.RateDateNew = Pounds.RateDateNew