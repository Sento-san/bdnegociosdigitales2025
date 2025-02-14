
use Northwind;
-- Seleccionar todas las categorias y productos

select * from 
Categories inner join Products
on Categories.CategoryID = Products.CategoryID;

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice 
from Categories inner join Products
on Categories.CategoryID = Products.CategoryID;

select C.CategoryID as 'Numero de Categoria', 
CategoryName as 'Nombre Categoria', 
ProductName as 'Nombre del Producto', 
UnitsInStock as 'Existencias', 
UnitPrice as 'Precio'
from Categories as C 
inner join 
Products as P
on C.CategoryID = P.CategoryID;

-- Seleccionar los productos de la categoria Beverages
-- o Condiments donde la exitencia este entre 18 y 30
select * 
from Categories as C
inner join 
Products as P
on C.CategoryID = P.CategoryID
where (C.CategoryName in ('Beverages','Condiments'))
and P.UnitsInStock between 18 and 30;

-- Seleccionar los productos y sus importes realizados
-- de Marzo a Junio de 1996, mostrando la fecha de la orden
-- el id del producto, y el importe
select O.OrderDate as 'Fecha de Orden',
O.OrderID as 'Numero de Order',
OD.ProductID as 'Numero de Producto',
(OD.UnitPrice * OD.Quantity) as 'Inporte'
from Orders as O
inner join 
[Order Details] as OD
on Od.OrderID = O.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31';

-- Seleccionar el importe total de ventas de la consulta anterior
select concat('$',' ',sum(OD.UnitPrice * OD.Quantity)) as 'Inporte'
from Orders as O
inner join 
[Order Details] as OD
on Od.OrderID = O.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31';

-- Consultas basicas con Inner Join

-- 1. Obtener el nombre de los clientes y los paises 
-- a los que se enviaron sus pedidos
select c.CompanyName as 'Nombre Cliente',
o.ShipCountry as 'Pais de Envio'
from Orders as o
inner join 
Customers as c
on o.CustomerID = c.CustomerID
order by 2 desc;

-- 2. Obtener los productos y sus respectivos proveedores
select p.ProductName as 'Nombre Producto',
s.CompanyName as 'Nombre Provedor'
from Products as p
inner join 
Suppliers as s
on p.SupplierID = s.SupplierID;

-- 3. obtener los pedidos y los empleados que los gestionarion
select e.EmployeeID as 'Numero Empleado',
concat(FirstName , ' ', LastName) as 'Nombre Empleado',
OrderID as 'Numero Orden',
OrderDate as 'Fecha de Orden'
from Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID

-- 4. Listar los productos junto con sus precios
-- y el nombre de la categoria a la que pertenecen
select ProductName as 'Nombre Producto',
UnitPrice as 'Precio Producto',
c.CategoryID as 'Numero Categoria',
CategoryName as 'Nombre Categoria'
from Products as p
inner join
Categories as c
on p.CategoryID = c.CategoryID
order by 3;

-- 5. Obtener el nombre del cliente, 
-- el numero de orden y la fecha de orden
select c.CompanyName as 'Nombre Cliente',
o.OrderID as 'Numero Orden',
o.OrderDate as 'Fecha Orden'
from Customers as c
inner join 
Orders as o
on c.CustomerID = o.CustomerID;

-- 6. Listar las ordenes mostrando el numero de orden,
-- el nombre del producto y la cantidad vendida
select od.OrderID as 'Numero Orden',
p.ProductName as 'Nombre Producto',
od.Quantity as 'Cantidad Vendida'
from Products as p
inner join 
[Order Details] as od
on p.ProductID = od.ProductID
order by 3 desc;

select od.OrderID as 'Numero Orden',
p.ProductName as 'Nombre Producto',
od.Quantity as 'Cantidad Vendida'
from Products as p
inner join 
[Order Details] as od
on p.ProductID = od.ProductID
where od.orderID = '11031'
order by 3 desc;

select od.OrderID as 'Numero Orden',
count(*) as 'Cantidad de Productos Vendida'
from Products as p
inner join 
[Order Details] as od
on p.ProductID = od.ProductID
group by od.OrderID
order by od.OrderID desc;

select * from [Order Details] as od
where od.OrderID = 11077;

-- 7. Obtener los empleados y sus respectivos jefes
select concat(e1.FirstName, '', e1.LastName) as 'Empleado',
concat(j1.FirstName, '', j1.LastName) as 'Jefe'
from Employees as e1
inner join
Employees as j1
on e1.ReportsTo = j1.EmployeeID;
 
 -- 8. Listar los pedidos y el nombre de la empresa de transporte utilizadas
 select o.OrderID as 'Numero de Pedido',
 o.OrderID as 'Numero Orden',
 s.CompanyName as 'Transportista'
 from Orders as o
 inner join Shippers as s
 on o.ShipVia = s.ShipperID;

 -- Consultas inner Join intermedias

 -- 9. Obtener la cantidad total de productos vendidos por categorias
 select sum(Quantity) from [Order Details];

 select c.CategoryName as 'Nombre Categoria',
 sum(Quantity) as 'Productos Vendidos'
 from Categories as c
 inner join Products as p
 on c.CategoryID = p.CategoryID
 inner join [Order Details] as od
 on od.ProductID = p.ProductID
 group by c.CategoryName
 order by c.CategoryName;

 -- 10. Obtener el total de ventas por empleado
 select * from [Order Details];
 select concat(e.FirstName, '', LastName) as 'Nombre Empleado',
 sum((od.UnitPrice*od.Quantity)-(od.Quantity * od.UnitPrice)*od.Discount) as 'Dineto Total'
 from Employees as e
 inner join 
 Orders as o
 on e.EmployeeID = o.EmployeeID
 inner join [Order Details] as od
 on o.OrderID = od.OrderID
 group by e.FirstName, e.LastName;

-- 11. Listar los clientes y la cantidad
-- de pedidos que han realizado
select c.CompanyName as 'Nombre Cliente',
count(*) as 'Cantidad de Pedidos'
from Customers as c
inner join 
Orders as o
on c.CustomerID = o.CustomerID
group by c.CompanyName
order by 2 desc;

-- 12. Obtener los empleados que han gestionado 
-- pedidos enviados a Alemania
select distinct e.EmployeeID as 'Numero Empleado',
concat(FirstName, ' ', LastName) as 'Nombre empleado',
o.ShipCountry as 'Pais de Envio'
from Employees as e
inner join 
Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany';

-- 13. Listar los productos junto con el nombre
-- del provedor y el país de origen
select p.ProductName as 'Nombre Producto',
s.CompanyName as 'Provedor',
s.Country as 'Pais de Origen'
from Products as p
inner join 
Suppliers as s
on p.SupplierID = s.SupplierID
order by 1 asc;

-- 14. Obtener los pedidos agruopados por pais de envio
select o.ShipCountry as 'Pais Envio'
from Orders as p


-- 15. Obtener los empleados y la cantidad
-- de territorios en los que trabajan
select concat(e.FirstName, ' ', e.LastName) as 'Nombre',
count(et.TerritoryID) as 'Cantidad Territorio',
t.TerritoryDescription as 'Nombre Territorio'
from Employees as e
inner join 
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by 'Nombre', t.TerritoryDescription desc;

-- 16. Listar las categorias y la cantidad de
-- productos que contienen.
select c.CategoryName as 'Categoria',
count(p.ProductID) as 'Cantidad de Productos'
from Categories as c
inner join 
Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc;

-- 17. Obtener la cantidad total de productos
-- vendidos por provedor

-- MAL
select s.CompanyName as 'Nombre Provedor',
count(p.ProductID) as 'Cantidad de Productos'
from Products as p
inner join 
Suppliers as s
on p.SupplierID = s.SupplierID
group by s.CompanyName;

-- BIEN
select s.CompanyName as 'Provedor',
sum(od.Quantity) as 'Total de Productos Vendidos'
from Suppliers as s
inner join 
Products as p
on s.SupplierID = p.SupplierID
inner join 
[Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName
order by 2 desc;

-- 18. Obtener la cantidad de pedidos enviados
-- por cada empresa de transporte
select o.ShipName as 'Nombre Empresa',
count(o.OrderID) as 'Cantidad'
from Orders as o
inner join 
Shippers as s
on o.ShipVia = s.ShipperID
group by o.ShipName;

-- Consultas Avanzadas