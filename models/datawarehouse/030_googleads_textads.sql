SELECT 
cl.CampaignName,
al.AdGroupName, 
ta.HeadlinePart1, 
ta.HeadlinePart2,
ta.ExpandedTextAdHeadlinePart3,
ta.Description,
ta.ExpandedTextAdDescription2,
im.impr Impressions, 
s.Clicks, 
s.Cost, 
s.Conversions, 
s.ISOWEEK, 
s.month,
s.year,
(s.Clicks/NULLIF(im.impr, 0)) ctr, 
(s.Conversions/NULLIF(s.Clicks, 0)) ConvRate, 
(s.Cost/NULLIF(s.Clicks,0)) cpc, 
(s.Cost/NULLIF(s.Conversions,0)) CostPerConv
FROM {{ref('stg_textAds')}} ta
LEFT JOIN {{ref('020_creativeImpressions')}} im
ON ta.CreativeId = im.CreativeId 
JOIN {{ref('020_campaignLookup')}} cl
ON cl.campaignId = ta.campaignId
LEFT JOIN {{ref('020_creativeBase')}} s
ON ta.creativeId = s.creativeId
LEFT JOIN {{ref('020_adGroupLookup')}} al
ON ta.AdGroupId = al.AdGroupId
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14