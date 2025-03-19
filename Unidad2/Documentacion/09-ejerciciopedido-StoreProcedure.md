# Ejercicio de pedidos con store procedure

- Realizar un pedido
- Validar que el pedido no exista
- Validar que el cliente, el empleado y producto exista
- Validar que la cantidad a vender tenga suficiente stock
- Insertar el pedido y calcular el importe
(multiplicando el precio del producto por la cantidad vendida)
- Actualizar el stock del priducto(restando el stock menos la cantidad)--Realizar un pedido

``` sql
go;
create or alter proc spu_realizar_pedido
@numPedido int, @cliente int,
@repre int, @fab char(3),
@producto char(5), @cantidad int
as 
begin
	if exists (select 1 from Pedidos where Num_Pedido = @numPedido)
	begin
		print 'El pedido ya existe'
		return
	end
	if not exists (select 1 from Clientes where Num_Cli = @cliente) or
	not exists (select 1 from Representantes where Num_Empl = @repre) or
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
	
	select @precio = Precio from Productos where Id_fab = @fab and Id_producto = @producto
	set @importe = @cantidad * @precio
	
	begin try 
	insert into Pedidos 
	values (@numPedido, getdate(), @cliente, @repre, @fab, @producto, @cantidad, @importe)
	
	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and Id_producto = @producto

	end try 
	begin catch
	print 'Error al actualizar los datos'
	return;
	end catch
end;
go
```

## Pruebas
``` sql
exec spu_realizar_pedido @numPedido = 112961,@cliente = 2117,
@repre = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @numPedido = 113070,@cliente = 2117,
@repre = 111, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @numPedido = 112961,@cliente = 2117,
@repre = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20

exec spu_realizar_pedido @numPedido = 113070,@cliente = 2117,
@repre = 101, @fab = 'ACI',
@producto = '4100X', @cantidad = 20

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100X'

select * from Pedidos