# Introduccion a las consultas de agregado
-  NOTA: solo devuelven un solo registro
sum, avg, count, count(*), max y min
```sql
-- Cuantos clientes tengo
select count(*) as NumneroDeClientes
from Customers;

-- Cuantas reguiones hay
select count(distinct Region) 
from Customers
where Region is not null;

select count(*) from Orders;
select count(ShipRegion) from Orders;

-- Selecciona el precio mas bajo de los productos
select min(UnitPrice), 
max(UnitPrice),
avg(UnitsInStock),
sum(UnitsInStock)
from Products;

-- Seleccionar cuantos pedidos existes
select count(*) as 'NumeroPedidos' 
from Orders;

-- Calcula el total de dinero vendido
select sum(UnitPrice*Quantity-(UnitPrice*Quantity*Discount)) as 'Total'
from [Order Details];

select sum(UnitPrice*Quantity) as 'Total'
from [Order Details];

-- Calcula el total de unidades en stock
-- de todos los productos
select sum(UnitsInStock) as 'Total de Stock'
from Products;

-- Seleccionar el total de dinero 
-- que se gano en el untimo trimestre 
-- de 1996


-- Seleccionar el numero de productos 
-- por categoria
select CategoryID, count(*) as 'Numero de Productos'
from Products
group by CategoryID;

Select Categories.CategoryName, 
count(*) as 'Numero de Productos'
from Categories
inner join Products as p
on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName;

-- Calcular el precio promedio de los
-- productos por cada categoria
select * from Products;
select CategoryID, avg(UnitPrice) as 'Precio Promedio' 
from Products
group by CategoryID;

-- Seleccionar el numero de pedidos
-- realizados por cada empleado en el
-- ultimo trimestre de 1996
select EmployeeID, count(*) as 'Total de Ordenes'
from Orders
group by EmployeeID;

select EmployeeID, count(*) from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by EmployeeID;

-- Seleccionar la suma total de
-- unidades vendidas por cada producto
select ProductID, sum(Quantity) as 'Total Vendido'
from [Order Details]
group by ProductID
order by 1 desc;

select OrderID, ProductID, sum(Quantity) as 'Total Vendido'
from [Order Details]
group by OrderID, ProductID
order by 2 desc;

-- Seleccinar el numero de productos por categoria
-- pero solo aquellos que tengan mas de 10 productos

-- Paso 1
select * from Products;

-- Paso 2
select CategoryID, UnitsInStock
from Products 
where CategoryID in (2,4,8)
order by CategoryID

-- Paso 3
select CategoryID, sum(UnitsInStock)
from Products
where CategoryID in (2,4,8)
group by CategoryID
order by CategoryID;

-- Paso 4
select CategoryID, sum(UnitsInStock)
from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*) > 10
order by CategoryID;

-- Listar las ordenes agrupadas por empleado,
-- pero que solo muestre aquellos que hayan
-- gestionado mas de 10 pedidos
select OrderID from Orders;
```