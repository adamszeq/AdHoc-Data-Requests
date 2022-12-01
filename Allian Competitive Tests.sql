SELECT   distinct homemonitor. Customerid


  -- ,ROW_NUMBER() OVER (ORDER BY StartDate) AS Number
  -- ,homemonitor.StartDate as CoverDate
  ,cast(homemonitor.StartDate as date) as CoverDate

  ,homemonitor.BuildingsCoverValue as Building_Sum_Insured
  ,NULL as Buildings_AD
  ,homemonitor.ContentsCoverValue as Contents_Sum_Insured
  ,NULL as Contents_AD

  ,homemonitor.VoluntaryExcess as Voluntary_Excess
  ,homemonitor.StandardCompulsoryExcess as Standard_Excess
  ,homemonitor.NonStandardCompulsoryExcess as Non_Standard_Excess
  ,NULL as Policy_Excess
  -- ,homemonitor.VoluntaryExcess + homemonitor.StandardCompulsoryExcess + homemonitor.NonStandardCompulsoryExcess as Policy_Excess
  --convert homemonitor.VoluntaryExcess to number and add to the other two


  ,homemonitor.YearsClaimFree as YearsClaimFree
  -- ,homemonitor.FirstClaimType as ClaimType1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimType END as ClaimType1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimDate END as ClaimDate1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimAmount END as ClaimAmount1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimPropertyOccurredAt END as ClaimRelatesToProperty1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homemonitor.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled1
  -- ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingName + ' ' + homemonitor.StreetName 
  -- + ' ' + homemonitor.Town + ' ' + homemonitor.County + ' ' + homemonitor.Postcode as ClaimsToProperty1  

  -- ,homemonitor.SecondClaimType as ClaimType2
  -- ,homemonitor.SecondClaimDate as ClaimDate2
  -- ,homemonitor.SecondClaimAmount as ClaimAmount2
  -- ,homemonitor.SecondClaimPropertyOccurredAt as ClaimRelatesToProperty2
  -- ,CASE WHEN homemonitor.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled2
  -- ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingName + ' ' + homemonitor.StreetName
  -- + ' ' + homemonitor.Town + ' ' + homemonitor.County + ' ' + homemonitor.Postcode as ClaimsToProperty2 
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimType END as ClaimType2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimDate  END as ClaimDate2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimAmount END as ClaimAmount2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimPropertyOccurredAt END as ClaimRelatesToProperty2
  -- ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE CASE WHEN homemonitor.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'NULL' END END as ClaimSettled2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homemonitor.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled2
  --if the claim date is before 2021-01-01 then set column to null else set to homemonitor.SecondClaimStatus 


  -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.ThirdClaimType END as ClaimType3
  -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.ThirdClaimDate  END as ClaimDate3
  -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.ThirdClaimAmount END as ClaimAmount3
  -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.ThirdClaimPropertyOccurredAt END as ClaimRelatesToProperty3
  -- -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE CASE WHEN homemonitor.ThirdClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END END as ClaimSettled3
  -- ,CASE WHEN cast(cast(homemonitor.ThirdClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homemonitor.ThirdClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled3



-- --  cast(cast(r1.StartDateId as char(8)) as datetime)
--   -- ,homemonitor.FirstClaimType as ClaimType1
--    --if  convert to date(homemonitor.FirstClaimDate) is <  2021-01-01 then set to null else set to homemonitor.FirstClaimType
--   ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE homemonitor.FirstClaimType END as ClaimType1


--   -- -- ,CASE WHEN homemonitor.FirstClaimDate < '2021-01-01' THEN NULL ELSE homemonitor.FirstClaimType END as ClaimType1
--   -- --if homemonitor.FirstClaimDate is < 2021-01-01 then set to null else set to homemonitor.ClaimType1
--   ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE homemonitor.FirstClaimDate END as ClaimDate1
--   -- --if homemonitor.FirstClaimDate is < 2021-01-01 then set to null else set to homemonitor.ClaimAmount1
--   ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE homemonitor.FirstClaimAmount END as ClaimAmount1
--   -- -- ,homemonitor.FirstClaimDate as ClaimDate1
--   -- -- ,homemonitor.FirstClaimAmount as ClaimAmount1
--   -- -- ,homemonitor.FirstClaimPropertyOccurredAt as ClaimRelatesToProperty1
--   ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE homemonitor.FirstClaimPropertyOccurredAt END as ClaimRelatesToProperty1
--   -- -- ,CASE WHEN homemonitor.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled1
--   ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE CASE WHEN homemonitor.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END END as ClaimSettled1
 

  -- ,homemonitor.SecondClaimType as ClaimType2
  -- ,homemonitor.SecondClaimDate as ClaimDate2
  -- ,homemonitor.SecondClaimAmount as ClaimAmount2
  -- ,homemonitor.SecondClaimPropertyOccurredAt as ClaimRelatesToProperty2
  -- ,CASE WHEN homemonitor.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled2
  -- -- ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingName + ' ' + homemonitor.StreetName
  -- -- + ' ' + homemonitor.Town + ' ' + homemonitor.County + ' ' + homemonitor.Postcode as ClaimsToProperty2 

  -- ,homemonitor.ThirdClaimType as ClaimType3
  -- ,homemonitor.ThirdClaimDate as ClaimDate3
  -- ,homemonitor.ThirdClaimAmount as ClaimAmount3
  -- ,homemonitor.ThirdClaimPropertyOccurredAt as ClaimRelatesToProperty3
  -- ,CASE WHEN homemonitor.ThirdClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled3
  -- -- ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingName + ' ' + homemonitor.StreetName
  -- -- + ' ' + homemonitor.Town + ' ' + homemonitor.County + ' ' + homemonitor.Postcode as ClaimsToProperty3

  -- ,homemonitor.FourthClaimType as ClaimType4
  -- ,homemonitor.FourthClaimDate as ClaimDate4
  -- ,homemonitor.FourthClaimAmount as ClaimAmount4
  -- ,homemonitor.FourthClaimPropertyOccurredAt as ClaimRelatesToProperty4
  -- ,CASE WHEN homemonitor.FourthClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled4
  -- -- ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingName + ' ' + homemonitor.StreetName
  -- -- + ' ' + homemonitor.Town + ' ' + homemonitor.County + ' ' + homemonitor.Postcode as ClaimsToProperty4

  -- ,homemonitor.FifthClaimType as ClaimType5
  -- ,homemonitor.FifthClaimDate as ClaimDate5
  -- ,homemonitor.FifthClaimAmount as ClaimAmount5
  -- ,homemonitor.FifthClaimPropertyOccurredAt as ClaimRelatesToProperty5
  -- ,CASE WHEN homemonitor.FifthClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled5

  -- ,homemonitor.NeighbourhoodWatchInArea as Neighbourhood_Watch
  --if homemonitor.NeighbourhoodWatchInArea = '1' then 'Y' else '0' end as Neighbourhood_Watch
  ,CASE WHEN homemonitor.NeighbourhoodWatchInArea = '1' THEN 'Y' ELSE 'N' END as Neighbourhood_Watch
  ,homemonitor.NumberOfSmokeAlarms as Smoke_Detectors
    --if homemonitor.NumberOfSmokeAlarms = ' NSAI Approved Installer to EN50131 Standard to Central Station' or 'Installed to EN50131 Standard (Not Connected to Central Station)' or 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' 
  --then 'Standard Alarm' else if 'other' then 'Other' else null end as Alarm_Type
  ,CASE WHEN homemonitor.RoofConstructionType = 'NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'Installed to EN50131 Standard (Not Connected to Central Station)' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'Other' THEN 'Other' 
  ELSE NULL END as Alarm
  ,CASE WHEN homemonitor.Locks = '1' THEN 'Y' ELSE 'N' END as Locks

   ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingNumber + ' ' + homemonitor.StreetName
  + ' ' + homemonitor.Town + ' ' + homemonitor.County  as Risk_Address
  
  ,homemonitor.Postcode as  Eircode
  ,homemonitor.County as County

  ,homemonitor.DateOfBirth as Date_of_Birth

  ,NULL as Occupation
  ,NULL as Employment_Status

  ,homemonitor.PropertyType as Dwelling_Type
  ,homemonitor.YearBuilt as Year_Built

  ,CASE WHEN homemonitor.RoofConstructionType = 'Standard' THEN 'Y' ELSE 'N' END as RoofStandard
  ,homemonitor.RoofNonStandardPercentage as NonStandardRoofPercentage

  ,homemonitor.ResidenceType as Occupancy_Type
  ,homemonitor.NumberOfPayingGuests AS Number_of_Paying_Guests
  ,homemonitor.NumberOfBedrooms as Number_of_Bedrooms
  ,homemonitor.NumberOfBathrooms as Number_of_Bathrooms
  ,homemonitor.HeatingType as Heating_Type

  ,homemonitor.UnkownAmount as Unspecified_Risks_Sum_Insured
  ,NULL as Specified_Items_Cash
  ,homemonitor.OtherAmount as Specified_Items_Other
  ,homemonitor.PedalCycleAmount as Specified_Items_Bicycles
  ,homemonitor.HearingAidAmount as Specified_Items_Hearing_Aids
  ,homemonitor.MobilePhoneAmount as Specified_Items_Mobile_Phones
  ,homemonitor.LaptopAmount as Specified_Items_Laptops
  ,homemonitor.PictureAmount as Specified_Items_Photographic
  ,NULL as Specified_Items_Glasses_Contacts
  ,homemonitor.JewelleryAmount as Specified_Items_Jewellery


  FROM [OP].[OP].[NBHomeMonitor] homemonitor
WHERE StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
  -- AND CustomerID = '2183'

-- 	,claiminfo1.min1 as FirstClaimDate
-- 	,claiminfo1.amount1 as FirstClaimAmount
-- 	 ,claiminfo1.claimtype1 as FirstClaimType
--      ,claiminfo1.claimstatus1 as FirstClaimStatus
--     ,claiminfo1.occurredat1 as FirstClaimPropertyOccurredAt

-- 	,claiminfo2.min2 as SecondClaimDate
-- 	,claiminfo2.amount2 as SecondClaimAmount
-- 	,claiminfo2.claimtype2 as SecondClaimType
-- 	,claiminfo2.claimstatus2 as SecondClaimStatus
-- 	,claiminfo2.occurredat2 as SecondClaimPropertyOccurredAt

-- 	,claiminfo3.min3 as ThirdClaimDate
-- 	,claiminfo3.amount3 as ThirdClaimAmount
-- 	,claiminfo3.claimtype3 as ThirdClaimType
-- 	,claiminfo3.claimstatus3 as ThirdClaimStatus
-- 	,claiminfo3.occurredat3 as ThirdClaimPropertyOccurredAt

-- 	,claiminfo4.min4 as FourthClaimDate
-- 	,claiminfo4.amount4 as FourthClaimAmount
-- 	,claiminfo4.claimtype4 as FourthClaimType
-- 	,claiminfo4.claimstatus4 as FourthClaimStatus
-- 	,claiminfo4.occurredat4 as FourthClaimPropertyOccurredAt

-- 	,claiminfo5.min5 as FifthClaimDate
-- 	,claiminfo5.amount5 as FifthClaimAmount
-- 	,claiminfo5.claimtype5 as FifthClaimType
-- 	,claiminfo5.claimstatus5 as FifthClaimStatus
-- 	,claiminfo5.occurredat5 as FifthClaimPropertyOccurredAt