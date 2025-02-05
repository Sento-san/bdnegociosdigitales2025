-- Consultas de agregado
-- NOTA: solo devuelven un solo registro
-- sum, avg, count, count(*), max y min

-- Cuantos clientes tengo
select count(*) as NumneroDeClientes
from Customers;

-- Cuantas reguiones hay
select count(distinct Region) 
from Customers
where Region is not null;

