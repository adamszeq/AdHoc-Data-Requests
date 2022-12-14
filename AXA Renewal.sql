SELECT   --homerenewal.Customerid

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distinct homerenewal.Customerid
  ,homerenewal.FirstName as First_Name
  ,homerenewal.Surname as Last_Name
  ,homerenewal.IsMonthClosedOffRenewal as Is_Sale
  ,cast(homerenewal.EndDate as date) as EndDate
  ,homerenewal.HomeProductStatus as ProductStatus
  ,homerenewal.PolicyAddOn as PolicyAddOn
  ,homerenewal.OfferProductCode as ProductCode
  ,homerenewal.StartDate as StartDate


  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
, 'Renewal' as  Source_of_Business
,'AA' as Intermediary
  ,'No' as EconomyProduct 
    ,NULL as Package
,homerenewal.BuildingsCoverValue as Building_Sum_Insured
,homerenewal.ContentsCoverValue as Contents_Sum_Insured
-- ,homerenewal.OtherAmount  + homerenewal.HearingAidAmount 
--     + homerenewal.MobilePhoneAmount + homerenewal.LaptopAmount + homerenewal.PictureAmount 
--     + homerenewal.JewelleryAmount as All_Risks_Specified_SI
-- ,homerenewal.UnspecifiedItemAmount as All_Risks_Unspecified_SI
--if policyAddOn UnSpecifiedAllRisks then add 
,case when homerenewal.PolicyAddOn = 'Specified All Risk' then 
homerenewal.OtherAmount  + homerenewal.HearingAidAmount 
    + homerenewal.MobilePhoneAmount + homerenewal.LaptopAmount + homerenewal.PictureAmount 
    + homerenewal.JewelleryAmount  + homerenewal.UnspecifiedItemAmount+ homerenewal.MusicalInstrumentAmount + homerenewal.CamcorderAmount
    +FursAmount + TabletAmount
    else 0 end as All_Risks_Specified_SI

,case when homerenewal.PolicyAddOn = 'Unspecified All Risks' then homerenewal.OtherAmount  + homerenewal.HearingAidAmount 
    + homerenewal.MobilePhoneAmount + homerenewal.LaptopAmount + homerenewal.PictureAmount 
    + homerenewal.JewelleryAmount  + homerenewal.UnspecifiedItemAmount + homerenewal.MusicalInstrumentAmount + homerenewal.CamcorderAmount
    +FursAmount + TabletAmount
    else 0 end as All_Risks_Unspecified_SI

,CASE WHEN homerenewal.RoofConstructionType = 'Standard' THEN 'Standard' ELSE 'Non Standard' + ' ' + convert(varchar(10), homerenewal.RoofNonStandardPercentage) + '%' END as Standard_Of_Construction

,homerenewal.YearBuilt as Year_Built
,homerenewal.YearsClaimFree as NCD_Years
,datediff(year, homerenewal.DateOfBirth, getdate()) as Age_Insured
,case when homerenewal.NumberOfSmokeAlarms > 0 then 'Y' else 'N' end as Smoke_Alarm
,CASE WHEN homerenewal.Locks = '1' THEN 'Y' ELSE 'N' END as Locks
,case when homerenewal.NeighbourhoodWatchInArea = 1 then 'Y' else 'N' end as Neighbourhood_Watch
    ,NULL as   Smoke_Locks_Watch

,case when homerenewal.AlarmType is not null then 'Y' else 'N' end as Alarm
-- ,homerenewal.hasMotor as Motor_Insurance_Policy
-- if motorHolding is 1 or motorProductCode is not null then 'Yes' else 'No' as Motor_Insurance_Policy
,case when homerenewal.MotorHolding = 1 or homerenewal.MotorProductCode is not null then 'Yes' else 'No' end as Motor_Insurance_Policy
,homerenewal.AcceptInsurerName as Insurer

,homerenewal.VoluntaryExcess as Voluntary_Excess
-- ,case when homerenewal.FirstClaimDate is not null and homerenewal.FirstClaimDate > dateadd(year,-3,getdate()) then 'Yes' else 'No' end as Claim_Free_3_years
--convert first claim date from integer to date  and then check if it is greater than 3 years ago
,case when homerenewal.FirstClaimDate is not null and convert(datetime, convert(char(8), homerenewal.FirstClaimDate)) < dateadd(year,-3,getdate()) then 'Yes' else 'No' end as Claim_Free_3_years

,homerenewal.PedalCycleAmount as Bicycles
,case when homerenewal.CaravanId > 1 then 'Yes' when homerenewal.CaravanId = -1 then 'No' else NULL end as Caravans
,homerenewal.CaravanGrantedContentsSumInsuredAmount as  contents_SI
	,homerenewal.CaravanGrantedStructureSumInsuredAmount as structure_SI

,NULL as   Firearms
,NULL as   Childminding_7_children_or_less
,NULL as   Childminding_more_thaan_8_children
,NULL as   Music_Tutor
,NULL as   Art_Tutor
,NULL as   Surgery
,NULL as   Students
,homerenewal.Postcode as  Eircode

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

  FROM [OP].[OP].[Renewalhomemonitor] homerenewal
  WHERE homerenewal.StartDate >= '2022-10-01' AND homerenewal.StartDate < '2022-11-30'
  -- and homerenewal.UnspecifiedItemAmount > 0
