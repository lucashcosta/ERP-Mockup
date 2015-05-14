ffgSELECT Clientes.id_cliente, nombre_cliente, apellido_cliente, telefono_cliente,
MAX(CAST(DAY(fechaEntrega_orden) AS VARCHAR(2)) + ' ' + DATENAME(MM, fechaEntrega_orden) + ' ' + CAST(YEAR(fechaEntrega_orden) AS VARCHAR(4))) AS Ser,
cantidad_compras
FROM Clientes LEFT JOIN Pedido ON Clientes.id_cliente = Pedido.id_cliente
WHERE fechaAbrio_orden NOT BETWEEN DATEADD(month, -0, GETDATE()) AND GETDATE() OR fechaAbrio_orden IS NULL
GROUP BY Clientes.id_cliente, nombre_cliente, apellido_cliente, telefono_cliente, cantidad_compras