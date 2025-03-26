-- Ejemplo de left join aplicado

use northwind

select * from Products_New

drop table Products_New

-- Crear un tabla a partir de una consulta 
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- crea la tabla con solo la estructura
select top 0 p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- Con alias
select top 0 0 as [productbk] ,p.ProductID, p.ProductName as [producto]
,[cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- Carga Full
insert into products_new
select 0 as [bkproduct], p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE()
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

alter table products_new
add constraint pk_products_new
primary key (productbk) 

-- Crear la tabla mediante consulta y se agrega el campo identidad
-- y calve primaria despues

drop table products_new

select top 0 p.ProductID, p.ProductName as [producto]
,[cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

alter table products_new
add productbk int not null identity(1,1)

alter table products_new
add constraint pk_products_new
primary key (productbk)
Go


-- Carga Full
insert into Products_New (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' 
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- Carga delta 

insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join products_new as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null

select pn.ProductID, pn.producto, pn.Customer,
pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date,
p.ProductID, p.ProductName
from Products as p
inner join 
products_new as pn
on p.ProductID = pn.ProductID
where p.ProductName = 'Elote feliz';

select pn.ProductID, pn.producto, pn.Customer,
pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date,
p.ProductID, p.ProductName
from Products as p
left join 
products_new as pn
on p.ProductID = pn.ProductID
where pn.ProductID is null;


select pn.ProductID, pn.producto, pn.Customer,
pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date,
p.ProductID, p.ProductName
from Products as p
left join 
products_new as pn
on p.ProductID = pn.ProductID
where pn.ProductID is null;

-- Repaso

-- Agrega los primeros 10 registros de la tabal Productos a la tabla recien creada products2
select top 10 *
into products2
from Products;

select * 
from Products as p
inner join products2 as p2
on p.ProductID = p2.ProductID;

select * 
from Products as p
left join products2 as p2
on p.ProductID = p2.ProductID;

select * 
from Products as p
right join products2 as p2
on p.ProductID = p2.ProductID;