SELECT   homerenewal.Customerid

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ,homerenewal.FirstName as First_Name
  ,homerenewal.Surname as Last_Name
  ,homerenewal.IsMonthClosedOffRenewal as Is_Sale
  ,cast(homerenewal.EndDate as date) as EndDate
  ,homerenewal.HomeProductStatus as ProductStatus
  ,homerenewal.AcceptProductCode as ProductNumber
  ,homerenewal.AcceptProductNumber as RenewalProductCode
  ,homerenewal.PolicyAddOn as PolicyAddOn
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  ,cast(homerenewal.StartDate as date) as CoverDate

  ,homerenewal.BuildingsCoverValue as Building_Sum_Insured
  -- ,case when homerenewal.PolicyAddOn = 'Buildings Accidental Damage' then 'Y' else 'N' end as Buildings_AD
  ,homerenewal.ContentsCoverValue as Contents_Sum_Insured
  -- ,case when homerenewal.PolicyAddOn = 'Contents Accidental Damage' then 'Y' else 'N' end as Contents_AD

  ,homerenewal.VoluntaryExcess as Voluntary_Excess
  ,homerenewal.StandardCompulsoryExcess as Standard_Excess
  ,homerenewal.NonStandardCompulsoryExcess as Non_Standard_Excess
  ,NULL as Policy_Excess

  ,homerenewal.YearsClaimFree as YearsClaimFree

  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimType END as ClaimType1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimDate END as ClaimDate1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimAmount END as ClaimAmount1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.FirstClaimPropertyOccurredAt END as ClaimRelatesToProperty1
  ,CASE WHEN cast(cast(homerenewal.FirstClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homerenewal.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled1

  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimType END as ClaimType2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimDate  END as ClaimDate2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimAmount END as ClaimAmount2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homerenewal.SecondClaimPropertyOccurredAt END as ClaimRelatesToProperty2
  ,CASE WHEN cast(cast(homerenewal.SecondClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homerenewal.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled2

  ,CASE WHEN homerenewal.NeighbourhoodWatchInArea = '1' THEN 'Y' ELSE 'N' END as Neighbourhood_Watch
  ,homerenewal.NumberOfSmokeAlarms as Smoke_Detectors
 
  ,CASE WHEN homerenewal.AlarmType = 'NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'Installed to EN50131 Standard (Not Connected to Central Station)' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homerenewal.AlarmType = 'Other' THEN 'Other' 
  ELSE NULL END as Alarm

  ,CASE WHEN homerenewal.Locks = '1' THEN 'Y' ELSE 'N' END as Locks

   ,homerenewal.BuildingUnitNumber + ' ' + homerenewal.BuildingNumber + ' ' + homerenewal.StreetName
  + ' ' + homerenewal.Town + ' ' + homerenewal.County  as Risk_Address
  ,homerenewal.Postcode as  Eircode
  ,homerenewal.County as County

  ,homerenewal.DateOfBirth as Date_of_Birth

  ,homerenewal.OccupationType as Occupation
  ,homerenewal.EmploymentType as Employment_Status

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
  WHERE StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
