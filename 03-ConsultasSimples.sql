-- Lenguaje SQL-LMD (insert, update, delete, select - CRUD)
--Consultas Simples

create database Northwind;
use Northwind;

--Mostrar todos los clientes, provedores, 
-- categorias, productos, ordenes, detalles de la orden, 
-- empleados de la empresa con todas las columnas de datos de la empresa
select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from categories;
select * from [Order Details];

--Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock 
from products;

-- Mostrar el numero de empleado, su primer nombre, 
-- su cargo, ciudad y pa�s.
select * from Employees;
select EmployeeID, FirstName, Title, city, country
from Employees;

-- Alias de columna

-- En base de la consulta anterior, mostrar el employeeid,
-- como numero empleado, firstname como primerNombre,
-- Tittle como cargo, city como ciudad, country como Pa�s.

select EmployeeID as 'Numero Empleado', FirstName as primernombre, 
Title as 'cargo', City as 'ciudad', Country as 'pa�s' from Employees;

select EmployeeID as [Numero Empleado], FirstName as primernombre, 
Title as [cargo], City as [ciudad], Country as [pa�s] from Employees;

-- Compos calculados
-- Seleccionar el importe de cada uno de 
-- los productos vendidos en una orden.

select *, (UnitPrice * Quantity) as importe from [Order Details];

-- Seleccionar las fechas de orden, a�o, mes y dia, 
-- el cliente que las ordeno y el empleado que las realizo.

select OrderDate as 'Fecha de la orden', 
year(OrderDate) as A�o, 
month(OrderDate) as Mes, 
day(OrderDate) as D�a, 
CustomerID as Cliente, 
EmployeeID as Empleado 
from Orders;

-- Eliminar Filas/Datos Duplica@s de una tabla(Distinct)

-- Mostrar los pa�ses en donde se tienen clientes,
-- mostrando pais solamente
select distinct Country from Customers
order by Country;

-- Clausula where
-- Operadores relacionales(<, >, =, <=, >=, !=, <>)
select * from Customers;

-- Seleccionar el cliente BOLID
select CustomerID as ID, CompanyName as Compa�ia, City as Ciudad, Country as Pa�s
from Customers
where CustomerID = 'BOLID';

-- Seleccionar los clientes, mostrar su identificacion,
-- nombre de empresa, contacto, ciudad y pais de alemania
select CustomerID as Identificacion,
CompanyName as Compa�ia, 
ContactName as Contacto, 
City as Ciudad, 
Country as Pa�s
from Customers where Country = 'Germany';

-- Selccionar todos los clientes que no sean 
-- de Alemania
select CustomerID as Identificacion,
CompanyName as Compa�ia, 
ContactName as Contacto, 
City as Ciudad, 
Country as Pa�s
from Customers where Country != 'Germany';

-- Seleccionar todos los productos, mostrando 
-- su nombre de producto, categoria a la que pertenece,
-- existencias y precio pero solamente 
-- donde su precio sea mayor a 100 y su corto de inventario.
select ProductName as NombreProducto,
CategoryID as Categoria, 
UnitsInStock as  Existencias,
UnitPrice as PrecioUnitario,
(UnitPrice * UnitsInStock) as [Costo inventario]
from Products where UnitPrice > 100;

-- Seleccionar las ordenes de compra
-- Mostrando la fecha de orden, la fecha de entrega,
-- la fecha de envio, el cliente a quien se vendio, 
-- de 1996.
select OrderDate as [Fecha de Orden],
RequiredDate as [Fecha de entrega],
ShippedDate as [Fecha de envio],
ShipName as [Cliente]
from Orders where year(OrderDate) = '1996';

-- Mostrar todas las ordenes de compra donde
-- la cantidad de productos comprados sea mayor a 5
select Quantity as CantidadVendida 
from [Order Details] where Quantity>40;

-- Mostrar el nombre completo del empleado, su numero de empleado,
-- fecha de nacimiento, ciudad, y fecha de contratacion la cual
-- debe ser de los que fueron contratados despues de 1993,
-- los resultados en sus encabezados deben ser mostrados en Espa�ol.
select EmployeeID as NumeroEmpleado,
FirstName as Nombre,
LastName as Apellido,
City as �iudad, 
HireDate as FechaContrato
from Employees where year(HireDate)>1993;

-- version 2
select EmployeeID as NumeroEmpleado,
(FirstName + '  ' + LastName) as 'NombreCompleto',
City as Ciudad, 
HireDate as FechaContrato
from Employees where year(HireDate)>1993;

-- version 3
select EmployeeID as NumeroEmpleado,
Concat (FirstName , '  ', LastName, ' - ' , Title) as NombreCompleto,
City as Ciudad, 
HireDate as FechaContrato
from Employees where year(HireDate)>1993;

-- Mostrar los empleados que no son dirigidos por el jefe 2.
select EmployeeID as Numero,
FirstName as Nombre
from Employees where ReportsTo != 2;

-- Seleccionar los empleados que no tengan feje
select * from Employees 
where ReportsTo is null;