--Realizar un pedido
-- Validar que el pedido no exista
-- Validar que el cliente, el empleado y producto exista
-- Validar que la cantidad a vender tenga suficiente stock
-- Insertar el pedido y calcular el importe
--(multiplicando el precio del producto por la cantidad vendida)
-- Actualizar el stock del priducto(restando el stock menos la cantidad)
create or alter proc spu_realizar_pedido
@IDpedido int, @IDcliente int,
@IDempleado int, @fab char(3),
@producto char(5), @cantidad int
as 
begin
	if exists (select 1 from Pedidos where Num_Pedido = @IDpedido)
	begin
		print 'El pedido ya existe'
		return
	end
	if not exists (select 1 from Clientes where Num_Cli = @IDcliente) or
	not exists (select 1 from Representantes where Num_Empl = @IDempleado) or
	not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
	begin
	print 'Los datos no son validos'
	return
	end 
	if @cantidad <= 0
	begin
	print 'La cantidad no puede ser 0 o negativo'
	return;
	end
	declare @stockValido int
	select @stockValido = stock from Productos where Id_fab = @fab and Id_producto = @producto
	if @cantidad > @stockValido 
	begin
	print 'No hay suficiente stock'
	return
	end
	declare @precio money
	declare @importe money
	select @precio from Productos where Id_fab = @fab and Id_producto = @producto
	set @importe = @cantidad * @precio
	insert into Pedidos 
	values (@IDpedido, getdate(), @IDcliente, @IDempleado, @fab, @producto, @cantidad, @importe)
end;
go
exec spu_realizar_pedido @IDpedido = 112961,@IDcliente = 2117,
@IDempleado = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @IDpedido = 113070,@IDcliente = 2117,
@IDempleado = 111, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @IDpedido = 112961,@IDcliente = 2117,
@IDempleado = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

select * from Pedidos