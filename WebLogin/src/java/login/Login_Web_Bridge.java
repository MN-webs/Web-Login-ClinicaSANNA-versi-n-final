package login;

import Login_Modelo.Login_Modelo;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "login", urlPatterns = {"/Login_Web_Bridge", "/LoginControlador"})
public class Login_Web_Bridge extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion != null) {
            if (accion.equalsIgnoreCase("mapa")) {
                response.sendRedirect("https://www.google.com/maps/search/Clinica+Sanna+Lima/");
                return; // Cortamos el flujo para que no intente validar credenciales
            } 
            else if (accion.equalsIgnoreCase("abrirCorreo")) {
                try {
                    if (java.awt.Desktop.isDesktopSupported()) {
                        java.awt.Desktop desktop = java.awt.Desktop.getDesktop();
                        
                        // Construimos la URL oficial de Gmail Web para redactar directamente un nuevo correo
                        String urlGmail = "https://mail.google.com/mail/?view=cm&fs=1"
                                        + "&to=soporte@sanna.pe"
                                        + "&su=Soporte%20Ecosistema%20Digital%20Clinico";
                        
                        // Forzamos al sistema a abrir esta URL en el navegador predeterminado
                        desktop.browse(new java.net.URI(urlGmail));
                    }
                } catch (Exception e) {
                    System.out.println("Error al redirigir al entorno de Gmail Web: " + e.getMessage());
                }
                // Redirigimos inmediatamente de vuelta a la vista de contacto para que el panel no quede en blanco
                response.sendRedirect("principal.jsp?vista=contacto");
                return; // Cortamos el flujo de ejecución
            }
            // CORRECCIÓN SOLUCIÓN ERROR 500: Interceptamos horarios y cortamos el flujo inmediatamente
            else if (accion.equalsIgnoreCase("horarios")) {
                response.sendRedirect("principal.jsp?vista=horarios");
                return; // IMPORTANTE: Evita que continúe hacia abajo y busque credenciales nulas
            }
        }

        // 1. Obtener los parámetros enviados desde index.jsp
        String user = request.getParameter("txtUsuario");
        // CORRECCIÓN: Cambiado de "txtPassword" a "txtClave" para coincidir exactamente con el HTML
        String pass = request.getParameter("txtClave");

        // 2. CORRECCIÓN PATRÓN SINGLETON: Acceso a la instancia única compartida en memoria
        Login_Modelo modelo = Login_Modelo.getInstancia();
        boolean esValido = modelo.validarCredenciales(user, pass);

        if (esValido) {
            // 3. Simulación de carga de datos de Citas Pendientes (Resumen rápido)
            List<String> citasPendientes = new ArrayList<>();
            citasPendientes.add("📋 Consulta General - Sede Javier Prado Oeste (Mañana 10:00 AM)");
            citasPendientes.add("🦷 Odontología Preventiva - Sede San Borja (Viernes 4:30 PM)");

            List<String[]> listaCitasProgramadas = new ArrayList<>();
            listaCitasProgramadas.add(new String[]{"101", "Marco Alva", "Dr. Carlos Mendoza", "Consulta General", "18/06/2026 10:00", "Pendiente"});
            listaCitasProgramadas.add(new String[]{"102", "Juan Pérez", "Dra. Ana Peralta", "Odontología Preventiva", "19/06/2026 15:30", "Pendiente"});
            listaCitasProgramadas.add(new String[]{"103", "Lucía Torres", "Dr. Luis Delgado", "Cardiología", "22/06/2026 09:00", "Confirmada"});

            // PASAR LO HECHO EN GESTIÓN (Simulación de la lista de Doctores)
            List<String[]> listaDoctores = new ArrayList<>();
            listaDoctores.add(new String[]{"10234567", "Dr. Carlos Mendoza", "CMP-85421", "Consulta General"});
            listaDoctores.add(new String[]{"74125896", "Dra. Ana Peralta", "CMP-96325", "Odontología Preventiva"});
            listaDoctores.add(new String[]{"45871239", "Dr. Luis Delgado", "CMP-63214", "Cardiología"});
            
            List<String[]> listaConfiguracion = new ArrayList<>();
            listaConfiguracion.add(new String[]{"Proyecto Base", "Login (Estructura Apache ANT)"});
            listaConfiguracion.add(new String[]{"Interfaz Gráfica", "Java Swing / NetBeans Matisse"});
            listaConfiguracion.add(new String[]{"Versión JDK del Runtime", "JDK 17 - Eclipse Temurin"});
            listaConfiguracion.add(new String[]{"Gestor de Base de Datos", "Pool de Conexiones Habilitado"});
            listaConfiguracion.add(new String[]{"Estado del Software", "Ambiente de Desarrollo (Local / En Línea)"});

            // OBTENER LA SESIÓN Y GUARDAR LAS LISTAS CORRECTAS
            jakarta.servlet.http.HttpSession misession = request.getSession();
            
            // Guardamos las listas con datos en la sesión
            misession.setAttribute("listaCitas", citasPendientes); 
            misession.setAttribute("listaCitasDetalle", listaCitasProgramadas);
            misession.setAttribute("listaDoctores", listaDoctores);
            misession.setAttribute("listaConfig", listaConfiguracion); 

            // Redireccionar de forma limpia a la vista del panel central
            response.sendRedirect("principal.jsp");
            
        } else {
            // Si es incorrecto, guardamos un mensaje de error y volvemos al login
            request.setAttribute("errorLogin", "Usuario o Contraseña incorrectos para Clínica Sanna.");
            
            response.setContentType("text/html;charset=UTF-8");
            try (java.io.PrintWriter out = response.getWriter()) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Usuario o Contraseña incorrectos para Clínica Sanna.');");
                out.println("window.location='index.jsp';"); 
                out.println("</script>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}