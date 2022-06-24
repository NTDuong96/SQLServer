create database Lab10
go

use AdventureWorks2019
select * into Lab10.dbo.WorkOrder from Production.WorkOrder

use Lab10
select * into WorkOrderIX from WorkOrder

select * from WorkOrder
select * from WorkOrderIX

create index IX_WorkOrderID on WorkOrderIX(WorkOrderID)

select * from WorkOrder where WorkOrderID=72000
select * from WorkOrderIX where WorkOrderID=72000