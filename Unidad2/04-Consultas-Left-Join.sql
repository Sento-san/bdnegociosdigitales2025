-- 
use Northwind;

-- Mostrar las categorias que no tengan
-- productos asignado
select c.CategoryName, 
c.CategoryID,
p.CategoryID,
p.ProductName
from Products as p
left join 
Categories as c
on c.CategoryID = p.CategoryID
where p.CategoryID is null;



insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Hamburgesa Sabrosa', 1, 9, 'xyz', 68.7, 45, 12, 2, 0)

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Guaracha Sabrosona', 1, null, 'xyz', 68.7, 45, 12, 2, 0)

delete Products

-- 1.Listar los empleados y los pedidos que han
-- gestionado, incluyendo los empleados que no 
-- han hecho pedidos
select *
from Products
where CategoryID is null