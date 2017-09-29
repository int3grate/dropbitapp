-- Part 1

-- Wine Column (b)

--Spirits Column (c)

-- 1 (c) previous month
select sum(
proof.Value) as [OnHandFirstOfMonthBulk]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 3
and prod.ProductionEndTime < '08/01/2017'

-- 2 (c) current month
select sum(
proof.Value) as [ReceivedBulk]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 3
and prod.ProductionEndTime >= '08/01/2016' and prod.ProductionEndTime <= '08/31/2017'

-- 9 (c) Bottled or Packaged
select sum(
proof.Value) as [BottledPackagedBulk]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 4
and prod.ProductionEndTime >= '01/01/2016' and prod.ProductionEndTime <= '08/01/2017'

-- 25 (c) On hand end of month
select sum(
proof.Value) as [OnHandEndOfMonthBulk]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 3
and prod.ProductionEndTime >= '01/01/2016' and prod.ProductionEndTime <= '08/01/2017'

-- Part 2

--Bottled Column (b)
-- 27 (c) previous month
select sum(
proof.Value) as [OnHandFirstOfMonthBottled]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 4
and prod.ProductionEndTime < '08/01/2017'

-- 28 (b) Bottled or Packaged
select sum(
proof.Value) as [BottledPackagedBottled]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 4
and prod.ProductionEndTime >= '01/01/2016' and prod.ProductionEndTime <= '08/01/2017'

-- 28 (b) On hand End of Month
select sum(
proof.Value) as [OnHandEndOfMonth]
from Production as prod
left join Proof as proof on prod.ProofID = proof.ProofID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerId
where
distillers.UserId = 1 
and prod.ProductionTypeID = 4


-- Packaged Column (c)


-- Part 4
select 
prod.ProductionID,
prod.StateID,
spiritTypeRep.ProductTypeName,
prodReport.Redistilled,
prodReport.Weight,
prodReport.Volume,
prodReport.Alcohol,
prodReport.Proof,
spiritTypeRep.SpiritTypeReportingID

from Production as prod
left join Production4Reporting as prodReport on prod.ProductionID = prodReport.ProductionID
left join AspNetUserToDistiller as distillers on prod.DistillerID = distillers.DistillerID
left join ProductionToSpiritTypeReporting as prod2SpiritType on prod.ProductionID = prod2SpiritType.ProductionID
left join SpiritTypeReporting as spiritTypeRep  on prod2SpiritType.SpiritTypeReportingID = spiritTypeRep.SpiritTypeReportingID
left join ProductionToPurchase as prod2Purch on prod.ProductionID = prod2Purch.ProductionID
left join Purchase4Reporting as purch4Reprt on prod2Purch.PurchaseID = purch4Reprt.PurchaseID
where distillers.UserId = 1 and
prod.Gauged = true and
(prod.StatusID = 1 or prod.StatusID = 2) and prod.StateID in (4,5) and
prod.ProductionEndTime >= '09-01-2017' and
prod.ProductionEndTime <= '09-31-2017'