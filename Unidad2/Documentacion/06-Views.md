# Introduccion a vistas
- Sintaxis de una vista
```sql
create view nombreVista
as 
select columnas
from tabla
where condicion
```
# Ejemplo 1 de vistas
```sql
create or alter view VistaCategorias_todas
as 
select CategoryID,CategoryName, [Description], Picture
from Categories 
where CategoryName = 'Beverages'
go
-- Seleccionar una vista
select * from VistaCategorias_todas
where CategoryName = 'Beverages'
-- Eliminar una vista
drop view VistaCategorias_todas
go
```

# Ejemplo 2 de vistas
- Crear una vista que permita visualizar solamente los clientes de mexico y brazil
```sql
create or alter view VistaClientesLatinos
as 
select *
from Customers
where Country in ('Mexico','Brazil')
go

select CompanyName as 'Cliente', 
City as 'Viudad', Country 'Pais' 
from VistaClientesLatinos
where City = 'Sao Paulo'
order by 2 desc

select *
from 
orders as o 
inner join 
VistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID
```

# Ejemplo 3 de vistas
- Crear una vista que contenga los datos de todas las ordenes los productos, categorias de productos, empleados y clientes, en la orden calcular el importe 
```sql
create or alter view [dbo].[VistaOrdenesCompra]
as
select o.OrderID as 'Numero Orden',
o.OrderDate as 'Fecha de Orden',
o.RequiredDate as 'Fecha de Requisicion',
concat(e.FirstName,' ', e.LastName) as 'Nombre Empleado',
cu.CompanyName as 'Nombre Cliente',
p.ProductName as 'Nombre Producto',
c.CategoryName as 'Nombre Categoria',
od.UnitPrice as 'Precio Venta',
od.Quantity as 'Cantidad Vendida',
(od.Quantity*od.UnitPrice) as 'Importe'
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od 
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID

select sum(Importe) as 'Importe_Total'
from VistaOrdenesCompra
where year([Fecha de Orden]) between '1995' and '1996'
go
```
# Ejemplo 4 de vistas
- Crea una vista que muestre las ordenes entre 1995 y 1996, junto con los datos del cliente y el importe
```sql
create or alter view Vista_Ordenes_1995_1996
as
select [Nombre Cliente], sum(Importe) as 'Importe_Total'
from VistaOrdenesCompra
where year([Fecha de Orden]) between '1995' and '1996'
group by [Nombre Cliente]
having count(*)>2
go
```

# vista horizontal
- Porque se le quitan campos
```sql
create or alter view rh.ViewCategoriasProductos
as
select c.CategoryID, c.CategoryName,
p.ProductID, p.ProductName
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID;

select * from rh.ViewCategoriasProductos
```