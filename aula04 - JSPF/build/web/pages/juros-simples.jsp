<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String errorMessage = null;
    double taxaJuros = 0, montante = 0;
    int meses = 0;
    try{
        taxaJuros = Double.parseDouble(request.getParameter("taxaJuros"));
        montante = Double.parseDouble(request.getParameter("montante"));
        meses = Integer.parseInt(request.getParameter("quantidadeMeses"));
        if (taxaJuros <= 0 || montante <= 0 || meses <= 0) {
            errorMessage = "Os valores devem ser maiores que zero.";
        }
    } catch (Exception e){
        errorMessage = "Valores invalidos";
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/menu.jspf" %>
        <h1>Juros Simples</h1>
        
        <form action="juros-simples.jsp">
            <label for="montante">Montante (R$):</label>
            <input type="number" id="montante" name="montante">
            <br><br>
            <label for="taxaJuros">Taxa de Juros (%):</label>
            <input type="number" id="taxaJuros" name="taxaJuros">
            <br><br>
            <label for="quantidadeMeses">Quantidade de Meses:</label>
            <input type="number" id="quantidadeMeses" name="quantidadeMeses">
            <br><br>
            <input type="submit" value="Calcular juros" name="jurosSimples">
        </form>
        <hr>
        <%if(errorMessage == null && (taxaJuros != 0 && meses != 0 && montante != 0)){%>
            valor de juros R$:<%=String.format("%.2f",(montante * (taxaJuros / 100 * meses)))%>
        <%} else if(errorMessage != null){%>
            <div style="color: red;"><%= errorMessage%></div>
        <%}%>      
    </body>
</html>
