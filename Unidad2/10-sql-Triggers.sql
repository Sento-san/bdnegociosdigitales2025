use BDEJEMPLO2

-- Realizar un trigger que se dispare cuando 
-- se inserte un pedido y modifique el stock
-- del producto vendido, verificar si hay suficiente
-- stock, si no se cancela el pedido

select * from Pedidos;

go
create or alter trigger tg_pedidos_insertar
on Pedidos 
after insert 
as 
begin 
	declare @existencia int
	declare @fab char(3)
	declare @prod char(5)
	declare @cantdad int

	select @fab = Fab, @prod = producto,
	@cantdad = Cantidad
	from inserted

	select @existencia = stock from Productos
	where Id_fab = @fab and Id_producto = @prod

	if @existencia > (select cantidad from inserted)
	begin 
		update Productos 
		set stock = stock - @cantdad
		where Id_fab = @fab and 
		Id_producto = @prod;
	end;
	else 
	begin 
		raiserror('No hay suficiente stock para el pedido', 16,1)
		rollback;
	end;
end;

select * from Pedidos
select * from Productos
select max(Num_Pedido) from Pedidos

declare @importe money
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto

insert into pedidos (Num_Pedido, Fecha_Pedido, Cliente, 
Rep, Fab, Producto, Cantidad, Importe)
values (113071, getdate(), 2103, 106, 'ACI', '41001', 77, @importe)

select * from Productos
where Id_fab = 'ACI' and Id_producto = '41001'

select * from Pedidos
where Num_Pedido = 113071

go

-- Crear un trigger que cada vez que se
-- elimine un pedido se debe actualizar
-- el stock de los productos con la cantidad eliminada

select * from Pedidos

go
create or alter trigger tg_pedidos_eliminar
on pedidos
after delete 
as
begin
	declare @existencia int
	declare @fab char(3)
	declare @prod char(5)
	declare @cantdad int

	select @fab = Fab, @prod = producto,
	@cantdad = Cantidad
	from deleted

	select @existencia = stock from Productos
	where Id_fab = @fab and Id_producto = @prod

	update Productos 
	set stock = stock + @cantdad
	where Id_fab = @fab and 
	Id_producto = @prod;
end;

declare @importe money
select @importe = (p.Cantidad * pr.Precio)
from Pedidos as p
inner join Productos as pr
on p.Fab = pr.Id_fab
and p.Producto = pr.Id_producto

delete into pedidos (Num_Pedido, Fecha_Pedido, Cliente, 
Rep, Fab, Producto, Cantidad, Importe)
values (113071, getdate(), 2103, 106, 'ACI', '41001', 77, @importe)