# Inicio a los store procedures 

- Ejemplo de la estructura de un sp
- Que selecciona todos los clientes de la db

``` sql
create or alter procedure spu_mostrar_clientes
as 
begin
select * from Customers;
end
go
```

- Ejecutar un sp en transact
```sql
exec spu_mostrar_clientes
```

- Ejemplo 1 de sp
```sql
-- Crear que muestre un sp que muestra los clientes por pais
create or alter proc spu_customersporpais
-- Parametros
@pais nvarchar(15), --parametro de entrada
@pais2 nvarchar(15)
as
begin
	select * from Customers
	where Country in (@pais,@pais2);
end;
-- Fin del store
```
- Ejecicion de un sp con declaracion de variables
```sql
-- Ejecuta un store procedure
declare @p1 nvarchar(15) = 'spain'
declare @p2 nvarchar(15) = 'germany'
exec spu_customersporpais @p1,@p2
go
```
- Ejemplo 2 de sp
```sql
-- Generar un reporte que permita visualizar los datos de compra de un
-- determinado cliente, en un rango de fechas, mostrando,
-- el monto total de compras por producto, mediante un sp.

create or alter proc spu_informe_venta_clientes
--parametros
@Nombre nvarchar(40)='Berglunds snabbköp',--parametro de entrada con valor por default
@fechaInicial Datetime,
@fechaFinal Datetime 
as 
begin
select [Nombre Producto],
[Nombre Cliente],
sum(Importe) as 'MontoTotal'
from VistaOrdenesCompra
where [Nombre Cliente] = @Nombre
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [Nombre Producto], [Nombre Cliente]
end
```
- Ejecucion de un store con parametros de entreda
```sql
exec spu_informe_venta_clientes 
'Berglunds snabbköp',
'1996-07-04','1997-01-01'
```

- Ejecucion de un store procedure con parametros en diferente posicion
```sql
exec spu_informe_venta_clientes 
@fechaFinal = '1997-01-01',
@Nombre='Berglunds snabbköp',
@fechaInicial = '1996-07-04'
```

- Ejecucion de un store procedure con paramtros de entrada con un campo que tiene un valor por default
```sql
exec spu_informe_venta_clientes 
@fechaInicial = '1996-07-04',
@fechaFinal='1997-01-01'
```

- Store procedure con parametros de salida
```sql
create or alter proc spu_obtener_numero_cliente
@customerid nchar(5), --parametro de entrada
@totalCustomers int output --parametro de salida
as
begin
select @totalCustomers=count(*) from Customers
where CustomerID = @customerid;
end;
go

declare @numero int;
exec spu_obtener_numero_cliente @customerid='ANATR' ,@totalCustomers = @numero output;
print @numero
go
```

- Ejemplo 3 de sp
```sql
-- crear un store procedure que permita saber si un alumno
-- aprobo o reprobo
create or alter proc spu_comparar_calificaion
@calif decimal(10,2) --parametro de entrada
as 
begin
	if @calif >= 0 and @calif <= 10
	begin
		if @calif >= 8
		print 'La calificaion es aprobatoria'
		else
		print 'La calificaion es reprobatoria'
end;
else
print 'Calificacion no valida'
go

exec spu_comparar_calificaion @calif = 7
go
```

- Ejemplo 4 de sp
```sql
-- Crear un sp que permita verificar si un cliente
-- existe antes de devolver su informacion
create or alter proc spu_obtenr_cliente_siexiste
@numeroCliente nchar(5)
as
begin
	if exists (select 1 from Customers where CustomerID = @numeroCliente)
		select * from Customers where CustomerID = @numeroCliente;
	else
		print 'El cliente no existe'
end;
go

exec spu_obtenr_cliente_siexiste @numeroCliente = 'Arout'
```

- Ejemplo 5 de sp
```sql
-- crear un sp que permita insertar un cliente,
-- pero se debe verificar primero que no exista
create or alter proc spu_obtener_cliente_noexiste
@ID nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @ID)
	begin
		print ('El cliente ya existe')
		return 1
	end
	insert into Customers (CustomerID, CompanyName)
	values(@ID,@nombre);
	print ('Cliente insertado exitosamente')
	return 0;
end;
go
exec spu_obtener_cliente_noexiste 'ALFKI', 'Patito de Hule'
exec spu_obtener_cliente_noexiste 'ALFKI', 'Patito de Hule'
select * from Customers
go

create or alter proc spu_agregar_cliente_try_catch
@ID nchar(5),
@nombre nvarchar(40),
@city nvarchar(15) = 'San Miguel'
as 
begin
	begin try 
		insert into Customers (CustomerID, CompanyName)
		values(@ID,@nombre);
		print ('Cliente insertado exitosamente')
	end try
	begin catch
		print ('El cliente ya existe')
	end catch
end;
exec spu_agregar_cliente_try_catch 'ALFIK', 'Muñeca vieja'
```

- Manejo de ciclos en stores procedures
```sql
-- Imprimir el numero de veces que indique el ususario
create or alter proc spu_imprimir
@numero int 
as
begin
if @numero <=0 
begin
print ('El numero no puede ser 0 o negativo')
return
end
	declare @i int 
		set @i = 1
		while(@i<=@numero)
	begin
		print concat('Numero ',@i)
		set @i = @i+1
	end;	
end;
go
exec spu_imprimir @numero = 10
```