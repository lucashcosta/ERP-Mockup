CREATE PROCEDURE [dbo].[GetCustomers_Pager]
       @SearchTerm VARCHAR(100) = ''
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (
            ORDER BY [fechaAbrio_orden] DESC
      )AS RowNumber
      ,id_cliente
      ,nombre_cliente
      ,apellido_cliente
      ,telefono_cliente
	  ,plano_cliente
      ,fechaEntrega_orden
      ,horarioEntrega_orden
      ,totalProductos_orden
	  ,status_orden
      INTO #Results
      FROM View_ClientesPedido
      WHERE nombre_cliente LIKE @SearchTerm + '%' OR @SearchTerm = ''
	  OR apellido_cliente LIKE @SearchTerm + '%' OR @SearchTerm = ''
	  OR id_cliente LIKE @SearchTerm + '%' OR @SearchTerm = ''
	  OR status_orden LIKE @SearchTerm + '%' OR @SearchTerm = ''
      SELECT @RecordCount = COUNT(*)
      FROM #Results
          
      SELECT * FROM #Results
      WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
    
      DROP TABLE #Results
END

