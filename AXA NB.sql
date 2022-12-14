SELECT  

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 distinct homemonitor.Customerid
  ,homemonitor.FirstName as First_Name
  ,homemonitor.LastName as Last_Name
  ,homemonitor.IsSale as Is_Sale
  ,cast(homemonitor.EndDate as date) as EndDate
  ,homemonitor.HomeProductStatus as ProductStatus
  ,homemonitor.PolicyAddOn as PolicyAddOn
  ,homemonitor.ProductCode as ProductCode
  ,homemonitor.StartDate as StartDate
  -- Non Standard <34%

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  --Quote
, 'New Business Broker Only' as  Source_of_Business
,'AA' as Intermediary
  ,'No' as EconomyProduct 
    ,NULL as Package
,homemonitor.meCoverValue as Building_Sum_Insured
,homemonitor.ContentsCoverValue as Contents_Sum_Insured
-- ,homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
--     + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
--     + homemonitor.JewelleryAmount as All_Risks_Specified_SI
-- ,homemonitor.UnspecifiedItemAmount as All_Risks_Unspecified_SI
--if policyaddon is 'U'nspecified All Risks' then sum homemonitor.OtherAmount  + homemonitor.HearingAidAmount + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
--     + homemonitor.JewelleryAmount  + homemonitor.UnspecifiedItemAmount as All_Risks_Specified_unSI 
,case when homemonitor.PolicyAddOn = 'Specified All Risk' 

then homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
    + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
    + homemonitor.JewelleryAmount  + homemonitor.UnspecifiedItemAmount+ homemonitor.MusicalInstrumentAmount + homemonitor.CamcorderAmount
    +FursAmount + TabletAmount
    else 0 end as All_Risks_Specified_SI

,case when homemonitor.PolicyAddOn = 'Unspecified All Risks' 

 then homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
    + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
    + homemonitor.JewelleryAmount  + homemonitor.UnspecifiedItemAmount+ homemonitor.MusicalInstrumentAmount + homemonitor.CamcorderAmount
    +FursAmount + TabletAmount

    else 0 end as All_Risks_Unspecified_SI





--if policyaddon is Building and Contents then sum -- -- ,homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
--     + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
--     + homemonitor.JewelleryAmount  + homemonitor.UnspecifiedItemAmount as All_Risks_Specified_SI 

-- ,CASE WHEN homemonitor.RoofConstructionType = 'Standard' THEN 'Standard' ELSE 'Non Standard' END as RoofStandard
-- ,homemonitor.RoofNonStandardPercentage as NonStandardRoofPercentage
-- convert RoofNonStandardPercentage as % and combine columns RoofConstructionType and RoofNonStandardPercentage as Standard_Of_Construction
,CASE WHEN homemonitor.RoofConstructionType = 'Standard' THEN 'Standard' ELSE 'Non Standard' + ' ' + convert(varchar(10), homemonitor.RoofNonStandardPercentage) + '%' END as Standard_Of_Construction
 ,homemonitor.YearBuilt as Year_Built
,homemonitor.YearsClaimFree as NCD_Years
--get age of customer 
,datediff(year, homemonitor.DateOfBirth, getdate()) as Age_Insured
,case when homemonitor.NumberOfSmokeAlarms > 0 then 'Y' else 'N' end as Smoke_Alarm
,CASE WHEN homemonitor.Locks = '1' THEN 'Y' ELSE 'N' END as Locks
,case when homemonitor.NeighbourhoodWatchInArea = 1 then 'Y' else 'N' end as Neighbourhood_Watch
    ,NULL as   Smoke_Locks_Watch

,case when homemonitor.AlarmType is not null then 'Y' else 'N' end as Alarm
-- ,homemonitor.hasMotor as Motor_Insurance_Policy
-- when motorpenetrataion  is 1 or motorholding is 1 then 'Yes' else 'No' end as Motor_Insurance_Policy
,case when homemonitor.motorPenetration = 1 or homemonitor.motorHolding = 1 then 'Yes' else 'No' end as Motor_Insurance_Policy
,homemonitor.AcceptInsurerName as Insurer

,homemonitor.VoluntaryExcess as Voluntary_Excess
,case when homemonitor.FirstClaimDate is not null and convert(datetime, convert(char(8), homemonitor.FirstClaimDate)) < dateadd(year,-3,getdate()) then 'Yes' else 'No' end as Claim_Free_3_years
,homemonitor.PedalCycleAmount as Bicycles
--if homemonitor.CaravanId is >1  then 'Y' , if its -1 then No else null
,case when homemonitor.CaravanId > 1 then 'Yes' when homemonitor.CaravanId = -1 then 'No' else NULL end as Caravans
,homemonitor.CaravanGrantedContentsSumInsuredAmount as  contents_SI
	,homemonitor.CaravanGrantedStructureSumInsuredAmount as structure_SI

,NULL as   Firearms
,NULL as   Childminding_7_children_or_less
,NULL as   Childminding_more_thaan_8_children
,NULL as   Music_Tutor
,NULL as   Art_Tutor
,NULL as   Surgery
,NULL as   Students
,homemonitor.Postcode as  Eircode

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  FROM [OP].[OP].[NBHomeMonitor] homemonitor
  where homemonitor.StartDate >= '2022-10-01' AND homemonitor.StartDate < '2022-11-30'
  -- and homemonitor.UnspecifiedItemAmount > 0
  -- and  PolicyAddOn = 'Buildings Accidental Damage'
