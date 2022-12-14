SELECT    distinct homemonitor.ProductCode AS ProductCode

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  ,homemonitor.FirstName as First_Name
  ,homemonitor.LastName as Last_Name
  ,homemonitor.IsSale as Is_Sale
  ,cast(homemonitor.EndDate as date) as EndDate
  ,homemonitor.HomeProductStatus as ProductStatus
  ,homemonitor.PolicyAddOn as PolicyAddOn
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  --populate column QuoteID with 100000000 + row number
  

  ,cast(homemonitor.StartDate as date) as CoverDate
  

  ,homemonitor.BuildingsCoverValue as Building_Sum_Insured
  -- ,case when homemonitor.PolicyAddOn = 'Buildings Accidental Damage' then 'Y' else 'N' end as Buildings_AD
  ,NULL AS Buildings_AD
  ,homemonitor.ContentsCoverValue as Contents_Sum_Insured
  -- ,case when homemonitor.PolicyAddOn = 'Contents Accidental Damage' then 'Y' else 'N' end as Contents_AD
  ,null as Contents_AD

  ,CONVERT(INT,
        CASE
        WHEN IsNumeric(CONVERT(VARCHAR(12), homemonitor.VoluntaryExcess)) = 1 THEN CONVERT(VARCHAR(12),homemonitor.VoluntaryExcess)
        ELSE 0 END) as Voluntary_Excess
  -- ,cast(homemonitor.VoluntaryExcess as int) as Voluntary_Excess
  -- ,cast(homemonitor.StandardCompulsoryExcess as int) as StandardCompulsoryExcess

  ,CONVERT(INT,
        CASE
        WHEN IsNumeric(CONVERT(VARCHAR(12), homemonitor.StandardCompulsoryExcess)) = 1 THEN CONVERT(VARCHAR(12),homemonitor.StandardCompulsoryExcess)
        ELSE 0 END) as Standard_Excess
  -- ,cast(homemonitor.NonStandardCompulsoryExcess as int) as NonStandardCompulsoryExcess

  ,CONVERT(INT,
        CASE
        WHEN IsNumeric(CONVERT(VARCHAR(12), homemonitor.NonStandardCompulsoryExcess)) = 1 THEN CONVERT(VARCHAR(12),homemonitor.NonStandardCompulsoryExcess)
        ELSE 0 END) as Non_Standard_Excess
  ,NULL as Policy_Excess


  ,CASE WHEN homemonitor.FirstClaimDate is not null THEN DATEDIFF(year, cast(cast(homemonitor.FirstClaimDate as char(8)) as datetime), getdate()) ELSE NULL END as YearsClaimFree


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
  ,CASE WHEN homemonitor.AlarmType = 'NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'Installed to EN50131 Standard (Not Connected to Central Station)' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'PSA/NSAI Approved Installer to EN50131 Standard to Central Station' THEN 'Standard Alarm' 
  WHEN homemonitor.AlarmType = 'Other' THEN 'Other' 
  ELSE NULL END as Alarm
  ,CASE WHEN homemonitor.Locks = '1' THEN 'Y' ELSE 'N' END as Locks


--    ,homemonitor.BuildingUnitNumber + ' ' + homemonitor.BuildingNumber + ' ' + homemonitor.StreetName
--   + ' ' + homemonitor.Town + ' ' + homemonitor.County  as Risk_Address
--   ,homemonitor.Postcode as  Eircode
--   ,homemonitor.County as County

  ,homemonitor.Postcode as  Eircode
,homemonitor.StreetName as StreetName
	,homemonitor.Town as Town
	,homemonitor.TownCode as TownCode
	,homemonitor.County as County
	,homemonitor.CountyCode as CountyCode
,homemonitor.membershipPenetrationFact as AA_Membership_Discount

  ,homemonitor.DateOfBirth as Date_of_Birth
  ,homemonitor.OccupationType as Occupation
  ,homemonitor.EmploymentType as Employment_Status


  ,homemonitor.PropertyType as Dwelling_Type
  ,homemonitor.YearBuilt as Year_Built
  ,CASE WHEN homemonitor.RoofConstructionType = 'Standard' THEN 'Y' ELSE 'N' END as RoofStandard
  ,homemonitor.RoofNonStandardPercentage as NonStandardRoofPercentage
  ,homemonitor.ResidenceType as Occupancy_Type
  ,homemonitor.NumberOfPayingGuests AS Number_of_Paying_Guests
  ,homemonitor.NumberOfBedrooms as Number_of_Bedrooms
  ,homemonitor.NumberOfBathrooms as Number_of_Bathrooms
  ,homemonitor.HeatingType as Heating_Type



  ,case when homemonitor.PolicyAddOn = 'Unspecified All Risks' then homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
    + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
    + homemonitor.JewelleryAmount  + homemonitor.UnspecifiedItemAmount + homemonitor.MusicalInstrumentAmount + homemonitor.CamcorderAmount
    +FursAmount + TabletAmount
    else 0 end as Unspecified_Risks_Sum_Insured

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
  where StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
