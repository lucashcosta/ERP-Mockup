SELECT id_cliente, nombre_cliente, cantidad_compras, MONTH(fechaAbrio_orden) Mes, COUNT(*) AS Compras FROM View_ClientesPedido
            WHERE fechaAbrio_orden BETWEEN DATEADD(month, -4, GETDATE()) AND GETDATE()
            Group by id_cliente, MONTH(fechaAbrio_orden), nombre_cliente, cantidad_compras Order by cantidad_compras desc, id_cliente

-- Compras por mes / Compras desde el primero de este año hasta el final de este
SET LANGUAGE Spanish;
SELECT COUNT(*) as CC, MONTH(fechaEntrega_orden) AS NMes, DATENAME(month, DateAdd( MONTH, MONTH(fechaEntrega_orden), -1 )) AS Mes, nombre_distribuidor FROM View_ClientesPedido 
WHERE fechaEntrega_orden BETWEEN DATEADD(yy, DATEDIFF(yy,0,getdate()), 0) AND DATEADD(yy, DATEDIFF(yy,0,getdate()) + 1, -1)
Group by nombre_distribuidor, MONTH(fechaEntrega_orden)

-- Compras por día / Compras desde el primero de este mes hasta el final de este
SET LANGUAGE Spanish;
SELECT COUNT(*) as CN, DATENAME(DAY, DateAdd( DAY, DAY(fechaEntrega_orden), -1 )) AS Día FROM Pedido 
WHERE fechaEntrega_orden BETWEEN DATEADD(dd,-(DAY(GETDATE())-1), GETDATE()) AND DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE()))
Group by DAY(fechaEntrega_orden)

SELECT DATEADD(yy, DATEDIFF(yy,0,getdate()), 0), DATEADD(yy, DATEDIFF(yy,0,getdate()) + 1, -1)

SELECT CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(GETDATE())-1),GETDATE()),103) AS Date_Value,
'First Day of Current Month' AS Date_Type

SELECT fechaEntrega_orden FROM Pedido