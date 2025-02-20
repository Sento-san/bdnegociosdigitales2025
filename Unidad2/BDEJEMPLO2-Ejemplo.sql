use BDEJEMPLO2

select pd.Descripcion,
pd.Precio,
pd.Id_fab, 
p.Fab,
pd.Id_producto,
p.Producto
from Pedidos as p
inner join 
Productos as pd
on p.Fab = pd.Id_fab
and p.Producto = pd.Id_producto;