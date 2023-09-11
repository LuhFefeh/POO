/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Random;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.Date;
/**
 *
 * @author Vs Studio
 */
@WebServlet(name = "ApiLoteriaServlet", urlPatterns = {"/loteria.json"})
public class ApiLoteriaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int[] numerosSorteados = new int[6];
            Random random = new Random();
            JSONArray arr = new JSONArray();
            JSONObject obj = new JSONObject();
            for(int i = 1; i <= 6; i++){
                int numeroSorteado;
                boolean numeroRepetido;
                do {
                    numeroSorteado = random.nextInt(100) + 1;
                    numeroRepetido = false;
                   
                    for (int j = 0; j < i - 1; j++) {
                        if (numerosSorteados[j] == numeroSorteado) {
                            numeroRepetido = true;
                            break;
                        }
                    }
                } while (numeroRepetido);
                
                numerosSorteados[i - 1] = numeroSorteado;
                arr.put(numeroSorteado);
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm");
            String dataFormatada = dateFormat.format(new Date());
            
            obj.put("Numeros:", arr);
            obj.put("Data:", dataFormatada);
            out.print(obj.toString());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
