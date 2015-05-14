SET LANGUAGE Spanish;
	--SELECT	id_cliente, 
	--	CONCAT(nombre_cliente, ' ', apellido_cliente) AS nombre_cliente,
	--	telefono_cliente FROM Clientes WHERE Clientes.id_cliente NOT IN
	--(
	--	SELECT id_cliente FROM View_ClientesPedido WHERE fechaAbrio_orden BETWEEN @StartDate AND @EndDate
	--)
	SELECT Clientes.id_cliente,
	cantidad_compras, 
	CONCAT(nombre_cliente, ' ', apellido_cliente) AS nombre_cliente,
	Clientes.telefono_cliente,
	MAX(CAST(DAY(fechaEntrega_orden) AS VARCHAR(2)) + ' ' + DATENAME(MM, fechaEntrega_orden) + ' ' + CAST(YEAR(fechaEntrega_orden) AS VARCHAR(4))) AS UltimaEntrega 
	FROM Clientes LEFT JOIN Pedido ON Clientes.id_cliente = Pedido.id_cliente
	--WHERE fechaEntrega_orden = CONVERT(date, DATEADD(DD,-37,GETDATE()))
	--WHERE fechaEntrega_orden BETWEEN CONVERT(date, DATEADD(DD,-2,GETDATE())) AND CONVERT(date, GETDATE())
			--OR fechaAbrio_orden IS NULL
	GROUP BY Clientes.id_cliente, nombre_cliente, apellido_cliente, telefono_cliente, cantidad_compras
	HAVING MAX(fechaEntrega_orden) = CONVERT(date, DATEADD(DD,-1,GETDATE()))

	SELECT id_pedido, fechaEntrega_orden from Pedido WHERE id_cliente = 1016