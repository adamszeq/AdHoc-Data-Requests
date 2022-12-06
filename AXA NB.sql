SELECT  

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distinct homemonitor.Customerid
  ,homemonitor.FirstName as First_Name
  ,homemonitor.LastName as Last_Name
  ,homemonitor.IsSale as Is_Sale
  ,cast(homemonitor.EndDate as date) as EndDate
  ,homemonitor.HomeProductStatus as ProductStatus
  ,homemonitor.PolicyAddOn as PolicyAddOn
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  --Quote
, 'New Business Broker Only' as  Source_of_Business
,'AA' as Intermediary
  ,'No' as EconomyProduct 
    ,NULL as Package
,homemonitor.BuildingsCoverValue as Building_Sum_Insured
,homemonitor.ContentsCoverValue as Contents_Sum_Insured
,homemonitor.OtherAmount  + homemonitor.HearingAidAmount 
    + homemonitor.MobilePhoneAmount + homemonitor.LaptopAmount + homemonitor.PictureAmount 
    + homemonitor.JewelleryAmount as All_Risks_Specified_SI
,homemonitor.UnkownAmount as All_Risks_Unspecified_SI

,Null as Standarad_Of_Construction
 ,homemonitor.YearBuilt as Year_Built
,homemonitor.YearsClaimFree as NCD_Years
--get age of customer 
,datediff(year, homemonitor.DateOfBirth, getdate()) as Age_Insured
,case when homemonitor.NumberOfSmokeAlarms > 0 then 'Y' else 'N' end as Smoke_Alarm
,CASE WHEN homemonitor.Locks = '1' THEN 'Y' ELSE 'N' END as Locks
,case when homemonitor.NeighbourhoodWatchInArea = 1 then 'Y' else 'N' end as Neighbourhood_Watch
    ,NULL as   Smoke_Locks_Watch

,case when homemonitor.AlarmType is not null then 'Y' else 'N' end as Alarm
,homemonitor.hasMotor as Motor_Insurance_Policy
,homemonitor.AcceptInsurerName as Insurer

,homemonitor.VoluntaryExcess as Voluntary_Excess
,NULL as   Claim_Free_3_years
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
  where StartDate >= '2022-10-01' AND StartDate < '2022-11-30'