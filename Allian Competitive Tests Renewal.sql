SELECT   distinct homerenewal. Customerid


  -- ,ROW_NUMBER() OVER (ORDER BY StartDate) AS Number
  -- ,homerenewal.StartDate as CoverDate
  ,cast(homerenewal.StartDate as date) as CoverDate

  ,homerenewal.BuildingsCoverValue as Building_Sum_Insured
  ,NULL as Buildings_AD
  ,homerenewal.ContentsCoverValue as Contents_Sum_Insured
  ,NULL as Contents_AD

  ,homerenewal.VoluntaryExcess as Voluntary_Excess
  ,homerenewal.StandardCompulsoryExcess as Standard_Excess
  ,homerenewal.NonStandardCompulsoryExcess as Non_Standard_Excess
  ,NULL as Policy_Excess
  -- ,homerenewal.VoluntaryExcess + homerenewal.StandardCompulsoryExcess + homerenewal.NonStandardCompulsoryExcess as Policy_Excess
  --convert homerenewal.VoluntaryExcess to number and add to the other two
-- BuildingName

  ,homerenewal.YearsClaimFree as YearsClaimFree

  
  -- ,homerenewal.FirstClaimType as ClaimType1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimType END as ClaimType1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimDate END as ClaimDate1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimAmount END as ClaimAmount1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimPropertyOccurredAt END as ClaimRelatesToProperty1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homerenewal.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled1
  -- ,homerenewal.BuildingUnitNumber + ' ' + homerenewal.BuildingName + ' ' + homerenewal.StreetName 
  -- + ' ' + homerenewal.Town + ' ' + homerenewal.County + ' ' + homerenewal.Postcode as ClaimsToProperty1  

  -- ,homerenewal.SecondClaimType as ClaimType2
  -- ,homerenewal.SecondClaimDate as ClaimDate2
  -- ,homerenewal.SecondClaimAmount as ClaimAmount2
  -- ,homerenewal.SecondClaimPropertyOccurredAt as ClaimRelatesToProperty2
  -- ,CASE WHEN homerenewal.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled2
  -- ,homerenewal.BuildingUnitNumber + ' ' + homerenewal.BuildingName + ' ' + homerenewal.StreetName
  -- + ' ' + homerenewal.Town + ' ' + homerenewal.County + ' ' + homerenewal.Postcode as ClaimsToProperty2 
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimType END as ClaimType2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimDate  END as ClaimDate2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimAmount END as ClaimAmount2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimPropertyOccurredAt END as ClaimRelatesToProperty2
  -- ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE CASE WHEN homerenewal.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'NULL' END END as ClaimSettled2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homerenewal.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled2
  --if the claim date is before 2021-01-01 then set column to null else set to homerenewal.SecondClaimStatus 


  -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.ThirdClaimType END as ClaimType3
  -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.ThirdClaimDate  END as ClaimDate3
  -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.ThirdClaimAmount END as ClaimAmount3
  -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.ThirdClaimPropertyOccurredAt END as ClaimRelatesToProperty3
  -- -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) < '2021-01-01' THEN NULL ELSE CASE WHEN homerenewal.ThirdClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END END as ClaimSettled3
  -- ,CASE WHEN cast(cast(homerenewal.ThirdClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homerenewal.ThirdClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled3


  -- -- ,homerenewal.FourthClaimType as ClaimType4
  -- ,homerenewal.FourthClaimDate as ClaimDate4
  -- ,homerenewal.FourthClaimAmount as ClaimAmount4
  -- ,homerenewal.FourthClaimPropertyOccurredAt as ClaimRelatesToProperty4
  -- ,CASE WHEN homerenewal.FourthClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled4
  -- -- ,homerenewal.BuildingUnitNumber + ' ' + homerenewal.BuildingName + ' ' + homerenewal.StreetName
  -- -- + ' ' + homerenewal.Town + ' ' + homerenewal.County + ' ' + homerenewal.Postcode as ClaimsToProperty4

  -- ,homerenewal.FifthClaimType as ClaimType5
  -- ,homerenewal.FifthClaimDate as ClaimDate5
  -- ,homerenewal.FifthClaimAmount as ClaimAmount5
  -- ,homerenewal.FifthClaimPropertyOccurredAt as ClaimRelatesToProperty5
  -- ,CASE WHEN homerenewal.FifthClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END as ClaimSettled5

  -- ,homerenewal.NeighbourhoodWatchInArea as Neighbourhood_Watch
  --if homerenewal.NeighbourhoodWatchInArea = '1' then 'Y' else '0' end as Neighbourhood_Watch
  ,CASE WHEN homerenewal.NeighbourhoodWatchInArea = '1' THEN 'Y' ELSE 'N' END as Neighbourhood_Watch
  ,homerenewal.NumberOfSmokeAlarms as Smoke_Detectors
    --if homerenewal.NumberOfSmokeAlarms = ' NSAI Approved Installer to EN50131 Standard to Central Station' or 'Installed to EN50131 Standard (Not Connected to Central Station)' or 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' 
  --then 'Standard Alarm' else if 'other' then 'Other' else null end as Alarm_Type
  ,CASE WHEN homerenewal.RoofConstructionType = 'NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'Installed to EN50131 Standard (Not Connected to Central Station)' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'Other' THEN 'Other' 
  ELSE NULL END as Alarm
  -- ,homerenewal.Locks as Locks
  --if locks is 1 then 'Y' else 'N' end as Locks
  ,CASE WHEN homerenewal.Locks = '1' THEN 'Y' ELSE 'N' END as Locks

   ,homerenewal.BuildingUnitNumber + ' ' + homerenewal.BuildingNumber + ' ' + homerenewal.StreetName
  + ' ' + homerenewal.Town + ' ' + homerenewal.County  as Risk_Address
  
  ,homerenewal.Postcode as  Eircode
  ,homerenewal.County as County

  ,customerdim.DateOfBirth as Date_of_Birth

  ,NULL as Occupation
  ,NULL as Employment_Status

  ,homerenewal.PropertyType as Dwelling_Type
  ,homerenewal.YearBuilt as Year_Built

  ,CASE WHEN homerenewal.RoofConstructionType = 'Standard' THEN 'Y' ELSE 'N' END as RoofStandard
  ,homerenewal.RoofNonStandardPercentage as NonStandardRoofPercentage

  ,homerenewal.ResidenceType as Occupancy_Type
  ,homerenewal.NumberOfPayingGuests AS Number_of_Paying_Guests
  ,homerenewal.NumberOfBedrooms as Number_of_Bedrooms
  ,homerenewal.NumberOfBathrooms as Number_of_Bathrooms
  ,homerenewal.HeatingType as Heating_Type

  ,homerenewal.UnkownAmount as Unspecified_Risks_Sum_Insured
  ,NULL as Specified_Items_Cash
  ,homerenewal.OtherAmount as Specified_Items_Other
  ,homerenewal.PedalCycleAmount as Specified_Items_Bicycles
  ,homerenewal.HearingAidAmount as Specified_Items_Hearing_Aids
  ,homerenewal.MobilePhoneAmount as Specified_Items_Mobile_Phones
  ,homerenewal.LaptopAmount as Specified_Items_Laptops
  ,homerenewal.PictureAmount as Specified_Items_Photographic
  ,NULL as Specified_Items_Glasses_Contacts
  ,homerenewal.JewelleryAmount as Specified_Items_Jewellery


  FROM [OP].[OP].[RenewalHomeMonitor] homerenewal
  LEFT JOIN [EDW_PROD].[dbo].[CustomerDim] customerdim ON homerenewal.CustomerId = customerdim.CustomerId
  WHERE StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
