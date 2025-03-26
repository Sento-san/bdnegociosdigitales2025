# Las funciones de cadena

- Las funciones de cadena premiten manipular tipos de datos como varchar, nvarchar, char, nchar.

# Declaracion de una variable
```sql
declare @Numero int;
set @Numero = 10;
print @Numero;
```

# Funcion Len
- Devuelve la longitud de una cadena
```sql
-- Obtener el tamaño de la cadena almacenada en la variable Texto
use Northwind
declare @Text varchar(50) = 'Hola, Mundo!';
select len(@Text) as longitud;
```
# Funcion Left  
- Extrae un determinado numero de caracteres desde el incio de la cadena
```sql
declare @Texto varchar(50) = 'Hola, Mundo!';
select left(@Texto, 4) as inicio;
go
```

 # Funcion Right 
 - Extrae un determinado numero de caracteres desde el final de la cadena
 ```sql
declare @Texto varchar(50) = 'Hola, Mundo!';
select right(@Texto, 6) as final
go
```

# Substring 
- Extrae una parte de la cadena
```sql
declare @Texto varchar(50) = 'Hola, Mundo!';
select substring(@Texto, 7,5);
```

# Ejemplo 1 de cadena
- Uso de right, left y substring
```sql
select CompanyName, len(CompanyName) as 'Numero de Caracteres',
left(CompanyName, 4) as inicio,
right(CompanyName, 6) as final,
substring(CompanyName, 7,4) as 'SubCadena'
from Customers
go
```

# Funcion Replace 
- Remplaza una subcadena por otra
```sql
declare @Texto varchar(50) = 'Hola, Mundo!';
select replace(@Texto, 'Mundo!', 'Amigo!')
go
 ```

 # Funcion Upper
 - Convierte una cadena en mayusculas
```sql
declare @Texto varchar(50) = 'Hola, Mundo!';
-- Convierte solo la palabra Mundo en mayusculas
select concat(left(@Texto,5),upper(substring(@Texto,7,5)),
right(@Texto, 1)) as TextoNuevo
```

# Ejemplo 2 de cadena
- Canviar todos los nombres de clientes a mayusculas
```sql
select * from Customers
update Customers 
set CompanyName = Upper(CompanyName)
where Country in ('Mexico', 'Germany')
```