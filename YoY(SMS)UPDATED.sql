IF OBJECT_ID('tempdb..#RenewalSMSCampaign') IS NOT NULL
DROP TABLE #RenewalSMSCampaign

SELECT 
    distinct [CustomerId]
    ,[StartDate]
    ,[OfferProductCode]
    ,[LYTotalAmount]
    ,TotalAmountTY
    ,[FirstName]
    ,[Surname]
    ,[HomePhoneNumber]
    ,[WorkPhoneNumber]
    ,[MobilePhoneNumber]
    ,[OfferTotalAmount]
    ,[OfferInsurerName]
    ,case when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) > 150 then '150'
	  when (TotalAmountTY + isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) < 0 then '0'
	  else cast(floor((TotalAmountTY + isnull(TotalYOYDiscount,0)) - (LYTotalAmount * 1.50)) as varchar) end as Discount
    ,(TotalAmountTY+ isnull(TotalYOYDiscount,0)) -(LYTotalAmount * 1.50) as DiffMaxAndOffered
    ,[YoYreal]
    ,[ContactMethod]
    ,[CanBeContacted]
    ,[Product]
    into #RenewalSMSCampaign
  FROM [OP].[OP].[RenewalHomeMonitor] ren


where StartDate > CAST( GETDATE() AS Date )
and IsMonthClosedOffRenewal = 0
and IsCancelled =0
and IsLapsed =0
and StartDate > CAST( GETDATE() AS Date ) -- greater than today
and YOYreal > 0.50
-- order by OfferProductCode

SELECT * FROM #RenewalSMSCampaign

-- WHERE StartDate > '2023-01-01'