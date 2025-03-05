
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

select s.CompanyName as 'Émpresa Transporte',
count(*) as 'Cantidad de pedidos'
from
Shippers as s
INNER JOIN
Orders AS o
on s.ShipperID = o.ShipVia
group by s.CompanyName;

-- Consultas Avanzadas

-- 19. Obtener los clientes que han realizado 
-- pedidos de productos distintos
select distinct ProductID as 'Numero de Productos'
from 
Customers as c
inner join
Orders as o
on c.CustomerID = o.CustomerID
inner join 
[Order Details] as od
on od.OrderID = o.OrderID
group by ProductID
order by 1 desc;

-- Listar los empleados con la cantidad total 
-- de pedidos que han gestionado, y a que clientes
-- los han vendido, agrupandolos po nombre completo y
-- dentro de este nombre por clien, ordenandolos por la
-- cantidad de mayor pedido.
select concat(FirstName, '', LastName) as 'Nombre', 
c.CompanyName as 'Cliente',
count(OrderID) as 'Numero de Ordenes'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
inner join
Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by 'Nombre' asc, 'Cliente';

select concat(FirstName, '', LastName) as 'Nombre', 
count(OrderID) as 'Numero de Ordenes'
from
Orders as o
inner join
Employees as e
on o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName
order by 'Nombre' asc;

-- 21. Listar las categorias con el total 
-- de ingresos generados por sus produstos
select c.CategoryName as 'Categoria',
count(p.ProductName) as 'Productos Totales',
sum((od.UnitPrice*od.Quantity)-(od.Quantity * od.UnitPrice)*od.Discount) as 'Dinero Total'
from Categories as c
inner join
Products as p
on c.CategoryID = p.CategoryID
inner join 
[Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName;

-- 22. Listar los clientes con el dinero 
-- total que ha gastado en pedidos
select c.CompanyName as 'Cliente',
sum(od.Quantity * od.UnitPrice) as 'Total'
from Customers as c
inner join 
Orders as o
on c.CustomerID = o.CustomerID
inner join 
[Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName;

select c.CompanyName as 'Cliente',
count(o.OrderID) as 'Cantidad de Pedido',
sum((od.UnitPrice*od.Quantity)-(od.Quantity * od.UnitPrice)*od.Discount) as 'Dinero Gastado'
from Customers as c
inner join
Orders as o
on c.CustomerID = o.CustomerID
inner join 
[Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName;

-- 23. Listar los pedidos realizados entre
-- el 1 de enero de 1997 y el 30 de junio de 1997
-- y mostrar el total de dinero 
select o.OrderDate as 'Fecha Pedido',
sum(od.Quantity*od.UnitPrice) as 'Total Dinero'
from Orders as o
inner join 
[Order Details] as od
on o.OrderID = od.OrderID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate;

-- 24. Listar los productos con las categorias Beverages,
-- seafood y confections
select * from Categories
select c.CategoryName as 'Categoria',
p.ProductName as 'Producto'
from Products as p
inner join 
Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName in ('Beverages','Seafood','Confections');

-- 25. Listar los clientes ubicados en Alemania y que hayan
-- hayan realizado pedidos entes del 1 de enero de 1997
select c.CompanyName as 'Cliente',
c.Country as 'Pais',
o.OrderDate as 'Fecha Pedido'
from Customers as c
inner join 
Orders as o
on c.CustomerID = o.CustomerID
where c.Country = 'Germany' and o.OrderDate = '1997-01-01'

-- 26. Listar los clientes que han realizado pedidos
-- con un total de entre $500 y $2000
select c.CompanyName as 'Clientes',
sum(od.Quantity*od.UnitPrice) as 'Total'
from Customers as c 
inner join 
Orders as o
on c.CustomerID = o.CustomerID
inner join 
[Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
having sum(od.Quantity*od.UnitPrice) between 500 and 2000;

-- Seleccionar los datos que se van a utilizar para insertar
-- en la tabla products-new

-- product_id, productName, customer, category, unitprice,
-- discontinued, inserted-date
