SELECT   distinct homemonitor. Customerid
  ,homemonitor.FirstName as First_Name
  ,homemonitor.LastName as Last_Name
  ,homemonitor.IsSale as Is_Sale
  ,cast(homemonitor.EndDate as date) as EndDate
  ,homemonitor.HomeProductStatus as ProductStatus
  ,cast(homemonitor.StartDate as date) as CoverDate
  

  ,homemonitor.BuildingsCoverValue as Building_Sum_Insured
  ,case when homemonitor.PolicyAddOn = 'Buildings Accidental Damage' then 'Y' else 'N' end as Buildings_AD

  ,homemonitor.ContentsCoverValue as Contents_Sum_Insured
  ,case when homemonitor.PolicyAddOn = 'Contents Accidental Damage' then 'Y' else 'N' end as Contents_AD
  -- ,homemonitor.PolicyAddOn as Contents_AD

  ,homemonitor.VoluntaryExcess as Voluntary_Excess
  ,homemonitor.StandardCompulsoryExcess as Standard_Excess
  ,homemonitor.NonStandardCompulsoryExcess as Non_Standard_Excess
  ,NULL as Policy_Excess

  ,homemonitor.YearsClaimFree as YearsClaimFree

  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimType END as ClaimType1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimDate END as ClaimDate1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimAmount END as ClaimAmount1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.FirstClaimPropertyOccurredAt END as ClaimRelatesToProperty1
  ,CASE WHEN cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homemonitor.FirstClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled1

  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimType END as ClaimType2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimDate  END as ClaimDate2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimAmount END as ClaimAmount2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) < '2020-01-01' THEN NULL ELSE homemonitor.SecondClaimPropertyOccurredAt END as ClaimRelatesToProperty2
  ,CASE WHEN cast(cast(homemonitor.SecondClaimDate as char(8)) as datetime) > '2020-01-01' THEN  (CASE WHEN homemonitor.SecondClaimStatus = 'Settled' THEN 'Y' ELSE 'N' END) ELSE NULL END as ClaimSettled2
 
  ,CASE WHEN homemonitor.NeighbourhoodWatchInArea = '1' THEN 'Y' ELSE 'N' END as Neighbourhood_Watch
  ,homemonitor.NumberOfSmokeAlarms as Smoke_Detectors
  

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
-- WHERE StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
where homemonitor.PolicyAddon = 'Buildings Accidental Damage'
and StartDate >= '2022-01-01' AND StartDate < '2022-11-30'

