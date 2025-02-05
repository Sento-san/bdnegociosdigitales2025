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
-- su cargo, ciudad y país.
select * from Employees;
select EmployeeID, FirstName, Title, city, country
from Employees;

-- Alias de columna

-- En base de la consulta anterior, mostrar el employeeid,
-- como numero empleado, firstname como primerNombre,
-- Tittle como cargo, city como ciudad, country como País.

select EmployeeID as 'Numero Empleado', FirstName as primernombre, 
Title as 'cargo', City as 'ciudad', Country as 'país' from Employees;

select EmployeeID as [Numero Empleado], FirstName as primernombre, 
Title as [cargo], City as [ciudad], Country as [país] from Employees;

-- Compos calculados
-- Seleccionar el importe de cada uno de 
-- los productos vendidos en una orden.

select *, (UnitPrice * Quantity) as importe from [Order Details];

-- Seleccionar las fechas de orden, año, mes y dia, 
-- el cliente que las ordeno y el empleado que las realizo.

select OrderDate as 'Fecha de la orden', 
year(OrderDate) as Año, 
month(OrderDate) as Mes, 
day(OrderDate) as Día, 
CustomerID as Cliente, 
EmployeeID as Empleado 
from Orders;

-- Eliminar Filas/Datos Duplica@s de una tabla(Distinct)

-- Mostrar los países en donde se tienen clientes,
-- mostrando pais solamente
select distinct Country from Customers
order by Country;

-- Clausula where
-- Operadores relacionales(<, >, =, <=, >=, !=, <>)
select * from Customers;

-- Seleccionar el cliente BOLID
select CustomerID as ID, CompanyName as Compañia, City as Ciudad, Country as País
from Customers
where CustomerID = 'BOLID';

-- Seleccionar los clientes, mostrar su identificacion,
-- nombre de empresa, contacto, ciudad y pais de alemania
select CustomerID as Identificacion,
CompanyName as Compañia, 
ContactName as Contacto, 
City as Ciudad, 
Country as País
from Customers where Country = 'Germany';

-- Selccionar todos los clientes que no sean 
-- de Alemania
select CustomerID as Identificacion,
CompanyName as Compañia, 
ContactName as Contacto, 
City as Ciudad, 
Country as País
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
-- los resultados en sus encabezados deben ser mostrados en Español.
select EmployeeID as NumeroEmpleado,
FirstName as Nombre,
LastName as Apellido,
City as Çiudad, 
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

-- Seleccionar los empleados que no tengan jefe
select * from Employees 
where ReportsTo is null;

-- Operadores lógicos (or, and y not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50
select ProductName as Nombre,
UnitPrice as Precio,
UnitsInStock as Existencia
from Products 
where UnitPrice>=10 and UnitPrice<=50;

-- Mostrar todos los pedidos realizados por 
-- clientes que no son enviados a Alemania.
select * from Orders where ShipCountry != 'Germany';
select * from Orders where not ShipCountry = 'Germany';

-- Seleccionar clientes de Mexico o Estados Unidos.
select * from Customers where Country = 'Mexico' or Country = 'USA';

-- Seleccionar los empleados que nacieron entre 1955 y 1958
-- y que vivan en Londres.
select * from Employees 
where (year(BirthDate) >= '1955' or year(BirthDate) <=1958) and City = 'Londono';

-- Seleccionar los pedidos con flete de peso (Freight) mayor 
-- a 100 y enviados a Francia o España.
select OrderID, OrderDate, ShipCountry, Freight from Orders 
where Freight >= 100 and (ShipCountry = 'France' or ShipCountry = 'Spain');

-- Seleccionar las primeras 5(top 5) ordenes de compra.
select top 5 * from Orders;

-- Seleccionar los productos con precio entre $10 y $50,
-- que NO esten descontinuados y tengan mas de 20 unidades de stock.
select ProductName, UnitPrice, UnitsInStock, Discontinued
from Products 
where (UnitPrice >= 10 and UnitPrice <= 50) and
(not Discontinued = 1 and UnitsInStock > 20);

-- Seleccionar los pedidos enviados a Francia o Alemania, 
-- pero con un flete menor a 50.
select OrderID, CustomerID, ShipCountry, Freight
from Orders 
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight < 50;

-- Seleccionar los clientes que NO sean de Mexico o USA
-- y que tengan fax registrado.
select CompanyName, City, Country, Fax
from Customers
where not (Country = 'Mexico' or Country = 'USA') 
and Fax is not null;

-- Seleccionar los pedidos con un flete mayor a 100
-- enviados a Brasil o Argentina,
-- pero NO enviados por el transportista 1.

-- Seleccionar Empleados que NO viven en Londren o Seattle
-- y que fueron contratados despues de 1995
select concat(FirstName, ' ', LastName) as NombreCompleto,
HireDate, City, Country
from Employees
where not(City = 'London' or City = 'Seattle')
and year(HireDate)>=1992;

select concat(FirstName, ' ', LastName) as NombreCompleto,
HireDate, City, Country
from Employees
where City != 'London' and City != 'Seattle'
and year(HireDate)>=1992;

-- Clausula IN (or)
-- seleccionar los productos con categoria 1, 3 o 5
select ProductName, CategoryID, UnitPrice 
from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5;

select ProductName, CategoryID, UnitPrice 
from Products
where CategoryID in (1,3,5);

-- Seleccionar todas las ordenes de la region RJ, Tachira
-- y que no tengan region asignada.
select OrderID, OrderDate,ShipRegion
from Orders
where ShipRegion in ('RJ', 'Táchira') or ShipRegion is null;

-- Seleccionar las ordenes que tengan cantidades de 12, 9 o 40
-- y descuento de 0.15 y 0.5.
select OrderID, Quantity, Discount
from [Order Details]
where Quantity in (12, 9, 40) and Discount in (0.15, 0.05);

-- Clausula Betwin
-- Mostrar los productos con precio entre 10 y 50
select * from Products
where UnitPrice >= 10 and UnitPrice <= 50;

select * from Products
where UnitPrice between 10 and 50;

-- Seleccionar todos los pedidos realizados entre 
-- el 1 de Enero y el 30 de Junio de 1997.
select OrderDate as FechaOrden
from Orders 
where year(OrderDate) = 1997 and ((day(OrderDate) between 1 and 30)
and month(OrderDate) between 'Enero' and 'Junio');

select * from Orders
where OrderDate >= '1997-01-01' and
OrderDate <= '1997-05-30';

select * from Orders
where OrderDate between '1997-01-01' and '1997-05-30';

-- Seleccionar todos los empleados contratados entre 
-- 1990 y 1995 que trabajan en Londres.
select FirstName as Nombre,
LastName as Apellido, 
HireDate as FechaContrato, 
City as Ciudad
from Employees 
where (year(HireDate) between '1992' and '1994') 
and City = 'London';

-- Seleccionar los pedidos con flete entre 50 y 200 enviados
-- a Alemania y a Francia.
select OrderID as NumeroOrden,
Freight as Peso,
ShipCountry as PaisEntrega
from Orders
where Freight between 50 and 200
and ShipCountry in( 'France', 'Germany');

-- Seleccionar todos los produntos que tengan un precio 
-- entre 5 y 20 dolares o que sean de la categoria 1,2 o 3
select ProductName as NombreProducto,
CategoryID as Categoria,
UnitPrice as Precio
from Products
where (UnitPrice between 5 and 20) 
and (CategoryID in (1, 2, 3));

select ProductID as NumeroProducto,
CategoryID as Categoria,
UnitPrice as Precio
from Products 
where UnitPrice >= 5 and UnitPrice <= 20
and (CategoryID = 1 or CategoryID = 2 or CategoryID = 3);

-- Seleccionar los empleados con numero de trabajador entre 3 y 7
-- que no trabajan en Londres ni Seattle.
select FirstName as Nombre,
EmployeeID as NumeroEmpleado,
City as Ciudad
from Employees
where (EmployeeID between 3 and 7)
and not(City in ('London', 'Seattle'));

select EmployeeID as NumeroEmpleado,
concat(FirstName, ' ',LastName) as NombreEmpleado,
City as Ciudad
from Employees
where EmployeeID >= 3 and EmployeeID <= 7
and (City<>'London' and City!='Seattle');

-- Clausula Like
-- patrones
	-- 1) % (porcentaje) Representa cero o mas caracteres en el patron.
	-- 2) _ (guion bajo) Representa exactamente un caracter en el patron
	-- de busqueda.
	--3) [] (corchetes) Se uriliza para definir un conjunto de caracteres
	-- buscando cualquiera de ellos en la posicion especifica.
	--4) [^] (potencia) Se utiliza para buscar caracteres que no estan
	-- dentro del conjunto especifico.

-- Buscar los productos que comienzan con "C"
select * from Products
where ProductName like 'Cha%';

select * from Products
where ProductName like 'Cha%'
and UnitPrice = 18;

-- Mostrar todos los productos que terminen con "e".
select * from Products
where ProductName like '%e';

-- Seleccionar todos lo clientes cuyo nombre de empresa
-- contiene la palabra "co" en cualquier parte.
select * from Customers
where CompanyName like '%co%';

-- Seleccionar los empleados cuyo nombre comience con "A"
-- y que tenga exactamente 5 caracteres
select FirstName, LastName
from Employees
where FirstName like 'A_____';

-- Seleccionar los productos que comiencen con A o B
select * from Products
where ProductName like '[ABC]%';

select * from Products
where ProductName like '[A-M]%';

-- Seleccionar todos los productos que no comiencen 
-- con A o B.
select * from Products
where ProductName like '[^AB]%';

-- Seleccionar todos los productos donde el nombre
-- comience con A pero no contenga la E.
select * from Products
where ProductName like 'A[e]%';

-- Clausula order by 
select ProductID as NumeroProducto,
ProductName as NombreProducto,
UnitPrice as PrecioUnico,
UnitsInStock as CantidadSobrante
from Products
order by UnitPrice; 

select ProductID as NumeroProducto,
ProductName as NombreProducto,
UnitPrice as PrecioUnico,
UnitsInStock as CantidadSobrante
from Products
order by 1;

-- Seleccionar los clientes ordenados por el pais
-- y dentro por ciudad
select CustomerID, Country, City, Region
from Customers
where Country in ('Germany', 'Brazil')
and Region is not null
order by Country, City;

select CustomerID, Country, City, Region
from Customers
where Country in ('Germany', 'Brazil')
and Region is not null
order by Country, City desc;