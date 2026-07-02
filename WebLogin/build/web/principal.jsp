<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clínica Sanna - Panel Principal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --azul-corporativo: #002d62;
            --azul-claro: #004b93;
            --verde-sanna: #02b396;
            --verde-hover: #019980;
            --gris-fondo: #f4f7fa;
            --blanco-puro: #ffffff;
            --texto-oscuro: #2d3748;
            --texto-mutado: #718096;
            --borde: #e2e8f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--gris-fondo);
            color: var(--texto-oscuro);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* --- CONTENEDOR LATERAL (SIDEBAR) --- */
        .sidebar {
            width: 260px;
            background-color: var(--azul-corporativo);
            color: var(--blanco-puro);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 25px 0;
            box-sizing: border-box;
        }

        .sidebar-brand {
            padding: 0 25px;
            font-size: 22px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            letter-spacing: 0.5px;
        }

        .sidebar-brand i {
            color: var(--verde-sanna);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 35px 0 0 0;
            flex-grow: 1;
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 14px 25px;
            color: #cbd5e0;
            text-decoration: none;
            font-size: 14.5px;
            font-weight: 500;
            transition: all 0.2s ease;
            border-left: 4px solid transparent;
        }

        .sidebar-menu li a:hover, .sidebar-menu li.active a {
            color: var(--blanco-puro);
            background-color: rgba(255, 255, 255, 0.05);
            border-left-color: var(--verde-sanna);
        }

        .sidebar-menu li a i {
            font-size: 16px;
            width: 20px;
        }

        .sidebar-footer {
            padding: 0 25px;
        }

        .btn-logout {
            width: 100%;
            background-color: rgba(255, 255, 255, 0.08);
            color: #fc8181;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 12px;
            border-radius: 10px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .btn-logout:hover {
            background-color: #e53e3e;
            color: white;
        }

        /* --- CONTENEDOR PRINCIPAL --- */
        .main-layout {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* Navbar Superior */
        .top-navbar {
            height: 70px;
            background-color: var(--blanco-puro);
            border-bottom: 1px solid var(--borde);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
        }

        .page-title h2 {
            margin: 0;
            font-size: 20px;
            color: var(--azul-corporativo);
            font-weight: 600;
        }

        .user-profile-nav {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14.5px;
            font-weight: 600;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background-color: #edf2f7;
            color: var(--azul-corporativo);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            border: 2px solid var(--verde-sanna);
        }

        /* Espacio de Contenido Scrolleable */
        .content-workspace {
            padding: 30px;
            overflow-y: auto;
            flex: 1;
            box-sizing: border-box;
        }

        /* --- TARJETAS METRICAS (KPI CARDS) --- */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .metric-card {
            background-color: var(--blanco-puro);
            border-radius: 16px;
            padding: 20px;
            border: 1px solid var(--borde);
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.01);
        }

        .metric-info h3 {
            margin: 0;
            font-size: 26px;
            color: var(--azul-corporativo);
            font-weight: 700;
        }

        .metric-info p {
            margin: 4px 0 0 0;
            color: var(--texto-mutado);
            font-size: 13.5px;
            font-weight: 500;
        }

        .metric-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-blue { background-color: rgba(0, 45, 98, 0.06); color: var(--azul-corporativo); }
        .icon-green { background-color: rgba(2, 179, 150, 0.06); color: var(--verde-sanna); }
        .icon-orange { background-color: rgba(237, 137, 54, 0.06); color: #ed8936; }

        /* --- BLOQUE DE TABLAS / INFORMACIÓN --- */
        .data-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
        }

        .card-panel {
            background-color: var(--blanco-puro);
            border-radius: 16px;
            border: 1px solid var(--borde);
            padding: 25px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.01);
        }

        .card-panel-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .card-panel-header h3 {
            margin: 0;
            font-size: 16.5px;
            color: var(--azul-corporativo);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-panel-header h3 i {
            color: var(--verde-sanna);
        }

        /* Tablas de datos */
        .custom-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 14px;
        }

        .custom-table th {
            background-color: #f7fafc;
            color: var(--texto-mutado);
            padding: 12px 16px;
            font-weight: 600;
            border-bottom: 1px solid var(--borde);
        }

        .custom-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #edf2f7;
            color: var(--texto-oscuro);
        }

        .custom-table tr:last-child td {
            border-bottom: none;
        }

        /* Estado del registro */
        .badge-status {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-pendiente { background-color: #feebc8; color: #c05621; }
        .badge-confirmada { background-color: #c6f6d5; color: #22543d; }

        /* Listas Simples (Panel Derecho) */
        .config-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .config-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 12px;
            border-bottom: 1px dashed var(--borde);
        }

        .config-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .config-label {
            font-size: 13.5px;
            color: var(--texto-mutado);
            font-weight: 500;
        }

        .config-val {
            font-size: 13.5px;
            color: var(--azul-corporativo);
            font-weight: 600;
        }

        /* Adaptabilidad en pantallas chicas */
        @media (max-width: 1100px) {
            .data-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <%
        // 1. Detectar de manera temprana qué sección del panel solicita el usuario
        String vistaActiva = request.getParameter("vista");
        if (vistaActiva == null || vistaActiva.trim().isEmpty()) {
            vistaActiva = "resumen";
        }

        // 2. Recuperar los datos almacenados desde el Servlet Puente
        List<String[]> listaCitasDetalle = (List<String[]>) session.getAttribute("listaCitasDetalle");
        List<String[]> listaDoctores = (List<String[]>) session.getAttribute("listaDoctores");
        List<String[]> listaConfig = (List<String[]>) session.getAttribute("listaConfig");
        
        int totalCitas = (listaCitasDetalle != null) ? listaCitasDetalle.size() : 0;
        int totalDoctores = (listaDoctores != null) ? listaDoctores.size() : 0;
    %>

    <div class="sidebar">
        <div>
            <div class="sidebar-brand">
                <i class="fa-solid fa-house-medical"></i> SANNA
            </div>
            <ul class="sidebar-menu">
    <li class="<%= vistaActiva.equals("resumen") ? "active" : "" %>">
        <a href="principal.jsp?vista=resumen"><i class="fa-solid fa-chart-pie"></i> Panel Resumen</a>
    </li>
    <li class="<%= vistaActiva.equals("citas") ? "active" : "" %>">
        <a href="principal.jsp?vista=citas"><i class="fa-solid fa-calendar-check"></i> Citas Médicas</a>
    </li>
    <li class="<%= vistaActiva.equals("doctores") ? "active" : "" %>">
        <a href="principal.jsp?vista=doctores"><i class="fa-solid fa-user-doctor"></i> Staff Médico</a>
    </li>

    <li class="<%= vistaActiva.equals("sedes") ? "active" : "" %>">
        <a href="LoginControlador?accion=mapa">
            <i class="fa-solid fa-map-location-dot"></i> Mapa
        </a>
    </li>
    <li class="<%= vistaActiva.equals("contacto") ? "active" : "" %>">
        <a href="principal.jsp?vista=contacto">
            <i class="fa-solid fa-envelope"></i> Contáctanos
        </a>
    </li>

    <li class="<%= vistaActiva.equals("infraestructura") ? "active" : "" %>">
        <a href="principal.jsp?vista=infraestructura"><i class="fa-solid fa-sliders"></i> Configuración</a>
    </li>
    <li class="<%= vistaActiva.equals("horarios") ? "active" : "" %>">
    <a href="principal.jsp?vista=horarios"><i class="fa-solid fa-clock"></i> Horarios de Atención</a>
    </li>
</ul>
        </div>
        
        <div class="sidebar-footer">
            <button class="btn-logout" onclick="window.location='index.jsp'">
                <i class="fa-solid fa-right-from-bracket"></i> Cerrar Sesión
            </button>
        </div>
    </div>

    <div class="main-layout">
        
        <div class="top-navbar">
            <div class="page-title">
                <h2>Ecosistema Digital Clínico</h2>
            </div>
            <a href="principal.jsp?vista=perfil" style="text-decoration: none; color: inherit;">
                <div class="user-profile-nav" style="cursor: pointer;">
                    <span>Administrador</span>
                    <div class="user-avatar" style="<%= vistaActiva.equals("perfil") ? "background-color: var(--verde-sanna); color: white;" : "" %>">
                        <i class="fa-solid fa-user-gear"></i>
                    </div>
                </div>
            </a>
        </div>

        <div class="content-workspace">
            
            <div class="metrics-grid">
                <div class="metric-card">
                    <div class="metric-info">
                        <h3><%= totalCitas %></h3>
                        <p>Citas Registradas</p>
                    </div>
                    <div class="metric-icon icon-blue">
                        <i class="fa-solid fa-notes-medical"></i>
                    </div>
                </div>
                
                <div class="metric-card">
                    <div class="metric-info">
                        <h3><%= totalDoctores %></h3>
                        <p>Médicos Activos</p>
                    </div>
                    <div class="metric-icon icon-green">
                        <i class="fa-solid fa-user-md"></i>
                    </div>
                </div>
                
                <div class="metric-card">
                    <div class="metric-info">
                        <h3>98.4%</h3>
                        <p>Disponibilidad</p>
                    </div>
                    <div class="metric-icon icon-orange">
                        <i class="fa-solid fa-server"></i>
                    </div>
                </div>
            </div>

            <div class="data-section" style="<%= (vistaActiva.equals("doctores") || vistaActiva.equals("perfil") || vistaActiva.equals("sedes") || vistaActiva.equals("contacto")) ? "grid-template-columns: 1fr;" : "" %>">
                
                <% if (vistaActiva.equals("resumen") || vistaActiva.equals("citas")) { %>
                <div class="card-panel">
                    <div class="card-panel-header">
                        <h3><i class="fa-solid fa-clock"></i> Control de Citas de la Jornada</h3>
                    </div>
                    
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Paciente</th>
                                <th>Médico Asignado</th>
                                <th>Especialidad</th>
                                <th>Fecha / Hora</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (listaCitasDetalle != null && !listaCitasDetalle.isEmpty()) {
                                    for (String[] cita : listaCitasDetalle) {
                                        String badgeClase = cita[5].equalsIgnoreCase("Pendiente") ? "badge-pendiente" : "badge-confirmada";
                            %>
                            <tr>
                                <td><strong>#<%= cita[0] %></strong></td>
                                <td><%= cita[1] %></td>
                                <td><%= cita[2] %></td>
                                <td><%= cita[3] %></td>
                                <td><%= cita[4] %></td>
                                <td><span class="badge-status <%= badgeClase %>"><%= cita[5] %></span></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" style="text-align: center; color: var(--texto-mutado);">No hay datos de citas disponibles.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>

                <% if (vistaActiva.equals("doctores")) { %>
                <div class="card-panel">
                    <div class="card-panel-header">
                        <h3><i class="fa-solid fa-user-md"></i> Staff de Médicos Integrados</h3>
                    </div>
                    
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Documento Identidad</th>
                                <th>Médico Colegiado</th>
                                <th>Código CMP</th>
                                <th>Especialidad Clínico-Médica</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (listaDoctores != null && !listaDoctores.isEmpty()) {
                                    for (String[] medico : listaDoctores) {
                            %>
                            <tr>
                                <td><strong><%= medico[0] %></strong></td>
                                <td><%= medico[1] %></td>
                                <td><span style="color: var(--azul-claro); font-weight: 600;"><%= medico[2] %></span></td>
                                <td><%= medico[3] %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="4" style="text-align: center; color: var(--texto-mutado);">No hay personal médico registrado en sesión.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>

                <% if (vistaActiva.equals("sedes")) { %>
                <div class="card-panel" style="text-align: center; padding: 40px;">
                    <i class="fa-solid fa-map-location-dot" style="font-size: 48px; color: var(--verde-sanna); margin-bottom: 15px;"></i>
                    <h3>Búsqueda Externa de Sedes Activa</h3>
                    <p style="color: var(--texto-mutado);">Se ha solicitado abrir el mapa en una pestaña independiente.</p>
                    <a href="LoginControlador?accion=mapa" target="_blank" class="btn-logout" style="background-color: var(--azul-corporativo); color: white; display: inline-flex; width: auto; padding: 10px 20px; text-decoration: none; margin-top: 10px;">
                        <i class="fa-solid fa-arrow-up-right-from-square"></i> Volver a abrir Mapa
                    </a>
                </div>
                <% } %>

                <% if (vistaActiva.equals("contacto")) { %>
<div class="card-panel" style="text-align: center; padding: 40px;">
    <i class="fa-solid fa-envelope-open-text" style="font-size: 48px; color: var(--verde-sanna); margin-bottom: 15px;"></i>
    <h3>Módulo de Soporte Clínico</h3>
    <p style="color: var(--texto-mutado);">El sistema solicitará al gestor local abrir el correo para escribir a <strong>soporte@sanna.pe</strong>.</p>
    
    <button onclick="window.location.href='Login_Web_Bridge?accion=abrirCorreo';" 
            class="btn-logout" 
            style="background-color: var(--azul-claro); color: white; display: inline-flex; width: auto; padding: 10px 25px; border: none; font-family: inherit; margin-top: 15px; cursor: pointer;">
        <i class="fa-solid fa-envelope"></i> Redactar Correo Ahora
    </button>
</div>
<% } %>
            <% if (vistaActiva.equals("horarios")) { %>
<div class="card-panel" style="max-width: 850px; margin: 0 auto; width: 100%;">
    <div class="card-panel-header" style="margin-bottom: 20px;">
        <h2 style="font-size: 20px; color: var(--color-primario); display: flex; align-items: center; gap: 10px; margin: 0;">
            <i class="fa-solid fa-clock font-accent"></i> Horarios de Atención Disponibles
        </h2>
    </div>
    
    <p style="color: var(--texto-mutado); margin-bottom: 25px; font-size: 14px;">
        A continuación se detallan los turnos operativos y horarios de atención al paciente de las principales sedes asistenciales y el centro de soporte técnico clínico.
    </p>

    <div class="table-responsive" style="overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 14px;">
            <thead>
                <tr style="border-bottom: 2px solid rgba(0,0,0,0.08); background-color: rgba(2, 179, 150, 0.04);">
                    <th style="padding: 12px 15px; font-weight: 600; color: #1e293b;">Sede / Módulo</th>
                    <th style="padding: 12px 15px; font-weight: 600; color: #1e293b;">Lunes a Viernes</th>
                    <th style="padding: 12px 15px; font-weight: 600; color: #1e293b;">Sábados</th>
                    <th style="padding: 12px 15px; font-weight: 600; color: #1e293b;">Emergencias</th>
                </tr>
            </thead>
            <tbody>
                <tr style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                    <td style="padding: 14px 15px; font-weight: 600; color: #334155;">Sede San Borja</td>
                    <td style="padding: 14px 15px; color: #64748b;">07:00 AM - 09:00 PM</td>
                    <td style="padding: 14px 15px; color: #64748b;">07:00 AM - 01:00 PM</td>
                    <td style="padding: 14px 15px;"><span style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 3px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">24 Horas Habilitado</span></td>
                </tr>
                <tr style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                    <td style="padding: 14px 15px; font-weight: 600; color: #334155;">Sede El Polo (Surco)</td>
                    <td style="padding: 14px 15px; color: #64748b;">08:00 AM - 08:00 PM</td>
                    <td style="padding: 14px 15px; color: #64748b;">08:00 AM - 01:00 PM</td>
                    <td style="padding: 14px 15px;"><span style="background: rgba(239, 68, 68, 0.1); color: #ef4444; padding: 3px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">24 Horas Habilitado</span></td>
                </tr>
                <tr style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                    <td style="padding: 14px 15px; font-weight: 600; color: #334155;">Sede La Molina</td>
                    <td style="padding: 14px 15px; color: #64748b;">08:00 AM - 07:00 PM</td>
                    <td style="padding: 14px 15px; color: #64748b;">08:00 AM - 12:00 PM</td>
                    <td style="padding: 14px 15px; color: #94a3b8;">No disponible</td>
                </tr>
                <tr style="border-bottom: 1px solid rgba(0,0,0,0.05);">
                    <td style="padding: 14px 15px; font-weight: 600; color: #334155;">Soporte Técnico Digital</td>
                    <td style="padding: 14px 15px; color: #64748b;">08:30 AM - 06:00 PM</td>
                    <td style="padding: 14px 15px; color: #64748b;">09:00 AM - 01:00 PM</td>
                    <td style="padding: 14px 15px; color: #94a3b8;">Vía Ticket de Correo</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div style="margin-top: 25px; background: rgba(2, 179, 150, 0.05); border-left: 4px solid var(--color-primario); padding: 15px; border-radius: 0 8px 8px 0;">
        <h4 style="margin: 0 0 5px 0; font-size: 14px; color: #0f172a; font-weight: 600;"><i class="fa-solid fa-circle-info"></i> Recordatorio para Operadores:</h4>
        <p style="margin: 0; font-size: 13px; color: #475569; line-height: 1.5;">
            Las citas programadas fuera del horario regular asistencial deben pasar por auditoría médica obligatoria antes de ser asignadas a un especialista del staff médico.
        </p>
    </div>
</div>
<% } %>
                <% if (vistaActiva.equals("perfil")) { %>
                <div class="card-panel" style="max-width: 600px; margin: 0 auto; width: 100%;">
                    <div class="card-panel-header" style="justify-content: center; flex-direction: column; gap: 15px; text-align: center;">
                        <div class="user-avatar" style="width: 80px; height: 80px; font-size: 32px; border-width: 3px;">
                            <i class="fa-solid fa-user-gear"></i>
                        </div>
                        <div>
                            <h3 style="font-size: 22px; justify-content: center;"><i class="fa-solid fa-address-card"></i> Perfil del Operador</h3>
                            <p style="color: var(--texto-mutado); margin: 5px 0 0 0; font-size: 14px;">Administrador del Sistema Clínico</p>
                        </div>
                    </div>
                    
                    <div class="config-list" style="margin-top: 25px; gap: 18px;">
                        <div class="config-item">
                            <span class="config-label"><i class="fa-solid fa-id-card"></i> Nombre Completo</span>
                            <span class="config-val">Personal Administrador</span>
                        </div>
                        <div class="config-item">
                            <span class="config-label"><i class="fa-solid fa-envelope"></i> Correo Institucional</span>
                            <span class="config-val">admin@sanna.pe</span>
                        </div>
                        <div class="config-item">
                            <span class="config-label"><i class="fa-solid fa-user-shield"></i> Rol Asignado</span>
                            <span class="config-val" style="color: var(--verde-sanna); background: rgba(2, 179, 150, 0.1); padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: 600;">Súper Usuario</span>
                        </div>
                        <div class="config-item">
                            <span class="config-label"><i class="fa-solid fa-building-user"></i> Sede Local</span>
                            <span class="config-val">Clínica Sanna - San Borja</span>
                        </div>
                    </div>
                </div>
                <% } %>

                <% if (vistaActiva.equals("resumen") || vistaActiva.equals("infraestructura")) { %>
                <div class="card-panel">
                    <div class="card-panel-header">
                        <h3><i class="fa-solid fa-circle-info"></i> Infraestructura</h3>
                    </div>
                    
                    <div class="config-list">
                        <%
                            if (listaConfig != null && !listaConfig.isEmpty()) {
                                for (String[] itemConfig : listaConfig) {
                        %>
                        <div class="config-item">
                            <span class="config-label"><%= itemConfig[0] %></span>
                            <span class="config-val"><%= itemConfig[1] %></span>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <p style="font-size: 13px; color: var(--texto-mutado);">Sin parámetros de configuración detectados.</p>
                        <% } %>
                    </div>
                </div>
                <% } %>
                
            </div>
        </div>
    </div>
</body>
</html>