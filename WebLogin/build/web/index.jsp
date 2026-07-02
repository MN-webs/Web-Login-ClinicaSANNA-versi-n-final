<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clínica Sanna - Portal de Acceso</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Variables de Paleta Médica Sanna */
        :root {
            --azul-corporativo: #002d62;
            --verde-sanna: #02b396;
            --verde-hover: #019980;
            --gris-fondo: #f4f7fa;
            --texto-oscuro: #2d3748;
            --texto-mutado: #718096;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            background-color: var(--gris-fondo);
            color: var(--texto-oscuro);
            overflow: hidden;
        }

        /* Contenedor Split-Screen (Pantalla Dividida) */
        .login-container {
            display: flex;
            width: 100%;
            height: 100vh;
        }

        /* PANEL IZQUIERDO: Branding Inmersivo Médico */
        .brand-panel {
            flex: 1;
            background: linear-gradient(135deg, #002d62 0%, #004b93 100%);
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 50px;
            color: white;
        }

        /* Efecto de curvas orgánicas abstractas de fondo (Simulando ondas de salud) */
        .brand-panel::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at 80% 20%, rgba(2, 179, 150, 0.15) 0%, transparent 50%),
                        radial-gradient(circle at 20% 80%, rgba(2, 179, 150, 0.1) 0%, transparent 60%);
            z-index: 1;
        }

        .brand-content {
            position: relative;
            z-index: 2;
            max-width: 520px;
            margin: auto 0;
        }

        .logo-area {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }
        
        .logo-area i {
            color: var(--verde-sanna);
        }

        .tagline-badge {
            background-color: rgba(2, 179, 150, 0.2);
            color: #46fcd5;
            border: 1px solid rgba(2, 179, 150, 0.3);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
        }

        .brand-content h1 {
            font-size: 42px;
            font-weight: 600;
            line-height: 1.2;
            margin: 0 0 20px 0;
        }

        .brand-content p {
            color: #cbd5e0;
            font-size: 16px;
            line-height: 1.6;
            margin: 0;
        }

        /* Características (Features Inferiores) */
        .features-list {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 30px;
        }

        .feature-item {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            padding: 16px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .feature-item i {
            color: var(--verde-sanna);
            font-size: 20px;
        }

        .feature-text h4 {
            margin: 0;
            font-size: 14px;
            font-weight: 600;
        }
        
        .feature-text p {
            margin: 2px 0 0 0;
            font-size: 12.5px;
            color: #a0aec0;
        }

        .brand-footer {
            position: relative;
            z-index: 2;
            font-size: 13px;
            color: #a0aec0;
        }


        /* PANEL DERECHO: Formulario de Acceso Flotante */
        .form-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f7fafc;
            padding: 40px;
        }

        .login-card {
            background: white;
            padding: 50px 45px;
            border-radius: 24px;
            box-shadow: 0 15px 35px rgba(0, 45, 98, 0.06);
            width: 100%;
            max-width: 440px;
            box-sizing: border-box;
            text-align: center;
        }

        .portal-badge {
            background-color: #edf2f7;
            color: var(--azul-corporativo);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 20px;
        }

        .login-card h2 {
            font-size: 28px;
            color: var(--azul-corporativo);
            margin: 0 0 8px 0;
            font-weight: 600;
        }

        .subtitle {
            color: var(--texto-mutado);
            font-size: 14px;
            margin-bottom: 35px;
        }

        /* Campos de Entrada Estilo Inputs de la Imagen */
        .input-group {
            margin-bottom: 22px;
            text-align: left;
            position: relative;
        }

        .input-group label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            color: var(--texto-oscuro);
            margin-bottom: 8px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper input {
            width: 100%;
            padding: 14px 45px 14px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14.5px;
            color: var(--texto-oscuro);
            background-color: white;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .input-wrapper input:focus {
            outline: none;
            border-color: var(--verde-sanna);
            box-shadow: 0 0 0 3px rgba(2, 179, 150, 0.15);
        }

        /* Iconos de Validación / Identificadores laterales */
        .input-icon-right {
            position: absolute;
            right: 16px;
            color: var(--texto-mutado);
            font-size: 16px;
            cursor: pointer;
            transition: color 0.2s ease;
        }
        
        .input-icon-right:hover {
            color: var(--azul-corporativo);
        }

        /* Botón de Acción Principal */
        .btn-submit {
            width: 100%;
            background-color: var(--verde-sanna);
            color: white;
            border: none;
            padding: 15px;
            font-size: 15.5px;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(2, 179, 150, 0.25);
        }

        .btn-submit:hover {
            background-color: var(--verde-hover);
            transform: translateY(-1px);
            box-shadow: 0 6px 15px rgba(2, 179, 150, 0.35);
        }

        /* Enlaces de pie de tarjeta */
        .card-footer-links {
            margin-top: 25px;
            font-size: 13.5px;
        }

        .card-footer-links a {
            color: var(--verde-sanna);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .card-footer-links a:hover {
            color: var(--azul-corporativo);
            text-decoration: underline;
        }

        /* Adaptabilidad Móvil (Responsive) */
        @media (max-width: 900px) {
            .brand-panel {
                display: none; /* Oculta panel de marca en pantallas chicas como la referencia */
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        
        <div class="brand-panel">
            <div class="logo-area">
                <i class="fa-solid fa-square-h"></i> SANNA
            </div>
            
            <div class="brand-content">
                <div class="tagline-badge">
                    <i class="fa-solid fa-award"></i> Sistema Integrado Clínico Edición 2026
                </div>
                <h1>Gestión inteligente de tu entorno médico</h1>
                <p>Centraliza la información de pacientes, agendas de citas y la infraestructura del staff médico desde un único ecosistema digital de alta velocidad.</p>
                
                <div class="features-list">
                    <div class="feature-item">
                        <i class="fa-solid fa-shield-medical"></i>
                        <div class="feature-text">
                            <h4>Seguro y Confiable</h4>
                            <p>Protección y encriptación de datos clínicos normados.</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fa-solid fa-chart-line"></i>
                        <div class="feature-text">
                            <h4>Monitoreo en Tiempo Real</h4>
                            <p>Control exacto de médicos activos y consultas.</p>
                        </div>
                    </div>
                    <div class="feature-item">
                        <i class="fa-solid fa-bolt"></i>
                        <div class="feature-text">
                            <h4>Arquitectura Ágil</h4>
                            <p>Sincronización instantánea mediante MVC y Sesiones JSP.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="brand-footer">
                &copy; Clínica Sanna S.A. — Todos los derechos reservados.
            </div>
        </div>

        <div class="form-panel">
            <div class="login-card">
                <div class="portal-badge">
                    <i class="fa-solid fa-lock"></i> Portal de Acceso
                </div>
                <h2>Bienvenido de vuelta</h2>
                <p class="subtitle">Ingresa tus credenciales para acceder al panel</p>
                
                <form action="LoginControlador" method="POST">
                    
                    <div class="input-group">
                        <label for="txtUsuario">Usuario / Correo</label>
                        <div class="input-wrapper">
                            <input type="text" id="txtUsuario" name="txtUsuario" placeholder="Escribe tu respectivo usuario" required>
                            <i class="fa-solid fa-user input-icon-right"></i>
                        </div>
                    </div>
                    
                    <div class="input-group">
                        <label for="txtClave">Contraseña</label>
                        <div class="input-wrapper">
                            <input type="password" id="txtClave" name="txtClave" placeholder="••••••••" required>
                            <i class="fa-solid fa-eye input-icon-right" id="togglePassword" onclick="conmutarVisibilidadClave()"></i>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        Ingresar al Sistema <i class="fa-solid fa-arrow-right"></i>
                    </button>
                    
                </form>
                
                <div class="card-footer-links">
                    <a href="#">¿No tienes una cuenta? Regístrate aquí</a>
                </div>
            </div>
        </div>

    </div>

    <script>
        function conmutarVisibilidadClave() {
            const inputClave = document.getElementById('txtClave');
            const iconoOjo = document.getElementById('togglePassword');
            
            if (inputClave.type === 'password') {
                inputClave.type = 'text';
                iconoOjo.classList.remove('fa-eye');
                iconoOjo.classList.add('fa-eye-slash');
            } else {
                inputClave.type = 'password';
                iconoOjo.classList.remove('fa-eye-slash');
                iconoOjo.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>