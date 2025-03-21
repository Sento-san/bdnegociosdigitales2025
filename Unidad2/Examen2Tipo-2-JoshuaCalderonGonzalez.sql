use Northwind
-- Vistas
create or alter view dbo.VistaExamenVentas
as
select concat(e.FirstName, ' ', e.LastName) as 'NombreEmpleado',
o.OrderID as 'NumeroOrden', o.OrderDate as 'FechaOrden',
c.CompanyName as 'NombreCliente', c.Country as 'País',
sum((od.UnitPrice * od.Quantity)-(od.UnitPrice * od.Quantity * od.Discount)) as 'MontoTotal'
from Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID

create or alter view dbo.VistaExamenProductos
as
select 
from Products as p
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as c
on o.CustomerID = c.CustomerID

-- Store Procedure
go
create or alter proc sp_ActualizaPrecioProducto
@ProductID int, @NuevoPrecio money
as
begin 
	if not exists (select 1 from Products where Discontinued = 0)
	begin 
		print 'El producto esta descontinuado'
		return
	end
	if not exists (select 1 from Products where @NuevoPrecio <= 0)
	begin 
		print 'El nuevo precio no es valido (>0)'
		return
	end
	if exists (select 1 from Products where @ProductID = ProductID)
	begin
		print 'Precio actualizado correctamente'
	end
end;
go