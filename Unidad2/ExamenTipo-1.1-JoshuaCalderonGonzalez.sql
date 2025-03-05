use BDEJEMPLO2;

-- 1.
select * from Clientes;
select Num_Cli as 'Numero Cliente',
Empresa as 'Cliete',
Rep_Cli as 'Numero de Representante',
r.Nombre as 'Nombre Representante',
r.Puesto as 'Puesto de Representante',
Limite_Credito as 'Limite de Credito'
from Clientes as c
inner join 
Representantes as r
on c.Rep_Cli = r.Num_Empl
where Limite_Credito > 5000;

-- 2. 
select * from Pedidos
select c.Num_Cli as 'Numero Cliente',
c.Empresa as 'Empresa de Cliente',
c.Rep_Cli as 'Representante',
Cantidad as 'Cantidad Pedido', 
Importe as 'Importe de Pedido'
from Pedidos as p
inner join 
Clientes as c
on p.Cliente = c.Num_Cli
where Cantidad > 100 or Importe > 5000;

-- 3.
select * from Oficinas;
select o.Oficina as 'Numero de Oficina',
Ciudad as 'Ciudad de Oficina',
r.Nombre 'Nombre de Jefe'
from Oficinas as o
inner join 
Representantes as r
on o.Oficina = r.Oficina_Rep
where Region between 'Este' and 'Oeste';

-- 4.
select * from Clientes;
select c.Num_Cli as 'Numero de Cliente',
o.Ciudad as 'Ciudad de Cliente',
c.Empresa as 'Empresa Cliente',
r.Nombre as 'Nombre de Representante'
from Clientes as c
inner join 
Representantes as r
on c.Rep_Cli = r.Num_Empl
inner join 
Oficinas as o 
on o.Oficina = r.Oficina_Rep
where o.Ciudad in ('Navarra','Castellón','Daimiel');

-- 5. 
select * from Clientes;
select c.Num_Cli as 'Numero de Cliente',
c.Empresa as 'Empresa Cliente',
c.Rep_Cli as 'Numero de Representante',
r.Nombre as 'Nombre Representante',
c.Limite_Credito as 'Limite de Credito'
from Clientes as c
inner join 
Representantes as r
on c.Rep_Cli = r.Num_Empl
order by Limite_Credito desc;

-- 6.
select * from Pedidos;
select count(p.Cliente) as 'Cantidad de Pedidos'
from Pedidos as p
inner join 
Clientes as c
on p.Cliente = c.Num_Cli
inner join 
Representantes as r
on c.Rep_Cli = r.Num_Empl
group by p.Cliente
having p.Cliente > 3;

-- 7.
select * from Representantes;
select o.Oficina as 'Numero de Oficina',
o.Ciudad as 'Ciudad de Oficina',
r.Num_Empl as 'Numero de Representante',
r.Nombre as 'Nombre Representante',
r.Ventas as 'Ventas Totales'
from Pedidos as p
inner join 
Representantes as r
on p.Rep = r.Num_Empl
inner join 
Oficinas as o
on r.Oficina_Rep = o.Oficina
where p.Importe > 10000;

-- 8.
select * from Oficinas;
select * from Representantes;

-- 9.
select * from Productos;
select count(pd.Fab)
from Productos as p
inner join 
Pedidos as pd
on p.Id_fab = pd.Fab
group by pd.Fab
having p.Stock < 50;