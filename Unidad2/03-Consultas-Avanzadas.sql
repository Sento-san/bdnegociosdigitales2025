
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