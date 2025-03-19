-- Funciones de cadena

-- Las funciones de cadena premiten manipular
-- tipos de datos como varchar, nvarchar, char, nchar

-- Funcion Len -> Devuelve la longitud de una cadena

-- Declaracion de una variable

declare @Numero int;
set @Numero = 10;
print @Numero;

-- Obtener el tamaño de la cadena almacenada en la variable Texto
declare @Text varchar(50) = 'Hola, Mundo!';
select len(@Texto) as longitud;

select CompanyName, len(CompanyName) as 'Numero de Caracteres',
left(CompanyName, 4) as inicio,
right(CompanyName, 6) as final,
substring(CompanyName, 7,4) as 'SubCadena'
from Customers
go

-- Funcion Left -> Extrae un determinado numero de caracteres
-- desde el incio de la cadena
declare @Texto varchar(50) = 'Hola, Mundo!';
select left(@Texto, 4) as inicio;
go
-- Funcion Right -> Extrae un determinado numero de caracteres
-- desde el final de la cadena
declare @Texto varchar(50) = 'Hola, Mundo!';
select right(@Texto, 6) as final

-- Substring -> Extrae una parte de la cadena
declare @Texto varchar(50) = 'Hola, Mundo!';
select substring(@Texto, 7,5);

-- Replace Remplaza una subcadena por otra
declare @Texto varchar(50) = 'Hola, Mundo!';
select replace(@Texto, 'Mundo!', 'Amigo!')

-- CharIndex
declare @Texto varchar(50) = 'Hola, Mundo!';
select charindex('hola', @Texto);

-- Upper -> Convierte una cadena en mayusculas
declare @Texto varchar(50) = 'Hola, Mundo!';
-- Convierte solo la palabra Mundo en mayusculas
select concat(left(@Texto,5),upper(substring(@Texto,7,5)),
right(@Texto, 1)) as TextoNuevo

-- Canviar todos los nombres de clientes a mayusculas
select * from Customers
update Customers 
set CompanyName = Upper(CompanyName)
where Country in ('Mexico', 'Germany')

-- Trim
go
