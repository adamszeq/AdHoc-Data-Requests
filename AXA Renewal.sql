SELECT   --homerenewal.Customerid

  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
distinct homerenewal.Customerid
  ,homerenewal.FirstName as First_Name
  ,homerenewal.Surname as Last_Name
  ,homerenewal.IsMonthClosedOffRenewal as Is_Sale
  ,cast(homerenewal.EndDate as date) as EndDate
  ,homerenewal.HomeProductStatus as ProductStatus
  ,homerenewal.AcceptProductCode as ProductNumber
  ,homerenewal.AcceptProductNumber as RenewalProductCode
  ,homerenewal.PolicyAddOn as PolicyAddOn
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  --Quote
, 'New Business Broker Only' as  Source_of_Business
,'AA' as Intermediary
  ,'No' as EconomyProduct 
    ,NULL as Package
,homerenewal.BuildingsCoverValue as Building_Sum_Insured
,homerenewal.ContentsCoverValue as Contents_Sum_Insured
,homerenewal.OtherAmount  + homerenewal.HearingAidAmount 
    + homerenewal.MobilePhoneAmount + homerenewal.LaptopAmount + homerenewal.PictureAmount 
    + homerenewal.JewelleryAmount as All_Risks_Specified_SI
,homerenewal.UnkownAmount as All_Risks_Unspecified_SI

,Null as Standarad_Of_Construction
 ,homerenewal.YearBuilt as Year_Built
,homerenewal.YearsClaimFree as NCD_Years
--get age of customer 
,datediff(year, homerenewal.DateOfBirth, getdate()) as Age_Insured
,case when homerenewal.NumberOfSmokeAlarms > 0 then 'Y' else 'N' end as Smoke_Alarm
,CASE WHEN homerenewal.Locks = '1' THEN 'Y' ELSE 'N' END as Locks
,case when homerenewal.NeighbourhoodWatchInArea = 1 then 'Y' else 'N' end as Neighbourhood_Watch
    ,NULL as   Smoke_Locks_Watch

,case when homerenewal.AlarmType is not null then 'Y' else 'N' end as Alarm
,homerenewal.hasMotor as Motor_Insurance_Policy
,homerenewal.AcceptInsurerName as Insurer

,homerenewal.VoluntaryExcess as Voluntary_Excess
,NULL as   Claim_Free_3_years
,homerenewal.PedalCycleAmount as Bicycles
--if homerenewal.CaravanId is >1  then 'Y' , if its -1 then No else null
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
  

  FROM [OP].[OP].[RenewalHomeMonitor] homerenewal
  WHERE StartDate >= '2022-10-01' AND StartDate < '2022-11-30'
