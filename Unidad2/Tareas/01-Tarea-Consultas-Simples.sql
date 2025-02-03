-- Tareas de consultas simples
use Northwind;
--1.    Productos con categoría 1, 3 o 5
select * from Products;
select ProductName as NombreProducto,
UnitPrice as PrecioUnico,
CategoryID as Categoria
from Products
where CategoryID in (1,3,5);

--2.    Clientes de México, Brasil o Argentina
select * from Customers;
select CompanyName as NombreCliente,
Country as PaisCliente
from Customers
where Country in ('Mexico','Brazil','Argentina');

--3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
select * from Orders;
select OrderDate as FechaOrden,
ShipVia as Transportista,
Freight as Peso
from Orders
where (ShipVia in (1,2,3)) and Freight > 50;

--4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
select * from Employees;
select concat(FirstName, ' ', LastName) as Nombre,
City as Ciudad
from Employees 
where City in ('London','Seattle','Buenos Aires');

--5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
select * from Orders;
select OrderDate as FechaOrden,
ShipCountry as PaisCliente,
Freight as Peso
from Orders
where (ShipCountry in ('Germany','France')) and Freight < 100;

--6.    Productos con categoría 2, 4 o 6 y que NO estén descontinuados
select * from Products;
select ProductName as Nombre,
CategoryID as Categoria,
Discontinued
from Products 
where (CategoryID in (2,4,6)) and not (Discontinued = 1);

--7.    Clientes que NO son de Alemania, Reino Unido ni Canadá
select * from Customers;
select CompanyName as NombreCliente,
Country as PaisCliente
from Customers
where not Country in ('Germany','UK','Canada');

--8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá
select * from Orders;
select OrderDate as FechaOrden,
ShipVia as Transportista,
ShipCountry as PaisEnviado
from Orders
where (ShipVia in (2,3)) and not ShipCountry in ('USA','Canada');

--9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995
select * from Employees;
select concat(FirstName, ' ', LastName) as Nombre,
City as Ciudad
from Employees 
where City in ('London','Seattle') 
and year(HireDate) > 1995;

--10.    Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados
select * from Products;
select ProductName as Nombre,
CategoryID as Categoria,
UnitsInStock as CantidadSobrante,
Discontinued
from Products
where CategoryID in (1,3,5) and UnitsInStock > 50 and Discontinued = 0;