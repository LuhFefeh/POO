<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
    String errorMessage = null;
    int month = 1, year = 2023;
    String monthParam = request.getParameter("mon");
    String yearParam = request.getParameter("year");
    if (monthParam != null && yearParam != null) {
        try {
            month = Integer.parseInt(monthParam);
            year = Integer.parseInt(yearParam);
        } catch (NumberFormatException e) {
            errorMessage = "Valores inválidos para mês ou ano.";
        }
    } else {
       errorMessage = "Mês e ano devem ser especificados.";
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calendário</title>
</head>
<body style="text-align: center">
    <h1>Calendário</h1>
    <form action="index.jsp">
        <label for="mon">Mês:</label>
        <input type="number" value="<%= monthParam%>" name="mon" id="mon">
        <label for="year">Ano:</label>
        <input type="number" value="<%= yearParam%>" name="year" id="year">
        <input type="submit" name="calendar" value="Gerar">
    </form>
    <%
        if (month < 1 || month > 12 || year < 1900 || year > 2100) {
            errorMessage = "Mês ou ano inválidos.";
        } else {
            Calendar calendar = Calendar.getInstance();
            calendar.set(year, month - 1, 1);
            
            int firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            
            int numDaysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            
            SimpleDateFormat monthFormat = new SimpleDateFormat("MMMM", new Locale("pt", "BR"));
            String monthName = monthFormat.format(new Date(year - 1900, month - 1, 1));
        %>
        <h2><%= monthName %>/<%= year %></h2>
        <table border="1" align="center">
            <tr>
                <th>Domingo</th>
                <th>Segunda-feira</th>
                <th>Terça-feira</th>
                <th>Quarta-feira</th>
                <th>Quinta-feira</th>
                <th>Sexta-feira</th>
                <th>Sábado</th>
            </tr>
            <tr>
            <% for (int i = 1; i < firstDayOfWeek; i++) {%>
                <td></td>
            <%}%>
            <%
                int currentDay = 1;
                while (currentDay <= numDaysInMonth) {
             %>
                <td><%= currentDay %></td>
                <%if (firstDayOfWeek == Calendar.SATURDAY) {%>
            </tr>
            <tr>
                <%}
                    calendar.add(Calendar.DAY_OF_MONTH, 1);
                    firstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
                    currentDay++;
                }
                %>
                <%while (firstDayOfWeek <= Calendar.SATURDAY) {%>
                <td></td>
                <% firstDayOfWeek++; }%>
            </tr>
        </table>
        <% }%>
</body>
</html>
