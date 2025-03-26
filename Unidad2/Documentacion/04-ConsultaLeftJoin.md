# Consulta de left join
- Mostrar las categorias que no tengan productos asignado

```sql
select c.CategoryName, 
c.CategoryID,
p.CategoryID,
p.ProductName
from Products as p
left join 
Categories as c
on c.CategoryID = p.CategoryID
where p.CategoryID is null;
```

- Insertar una nueva fila en la tabla Product de la db
```sql
insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Hamburgesa Sabrosa', 1, 9, 'xyz', 68.7, 45, 12, 2, 0)

insert into Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values('Guaracha Sabrosona', 1, null, 'xyz', 68.7, 45, 12, 2, 0)
```
# Eliminar una tabla
```sql
delete Products
```