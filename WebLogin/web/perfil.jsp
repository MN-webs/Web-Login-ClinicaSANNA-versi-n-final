<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil de Usuario - Clínica Sanna</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .contenedor-perfil { background-color: white; border: 2px solid #ffa500; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 450px; padding: 20px; }
        .header-perfil { text-align: center; margin-bottom: 20px; }
        .campo-datos { margin-bottom: 15px; }
        .label-datos { font-weight: bold; font-size: 16px; color: #333; margin-bottom: 5px; }
        .valor-datos { background-color: #e9ecef; padding: 10px; border-radius: 4px; font-size: 15px; color: #555; border: 1px solid #ccc; }
        .btn-volver { display: block; width: 100px; margin: 20px auto 0 auto; padding: 10px; background-color: #0056b3; color: white; text-align: center; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .btn-volver:hover { background-color: #004085; }
    </style>
</head>
<body>

    <div class="contenedor-perfil">
        <div class="header-perfil">
            <h2>Información del Personal</h2>
        </div>

        <div class="campo-datos">
            <div class="label-datos">Nombre:</div>
            <div class="valor-datos">Marco Nakashima</div>
        </div>

        <div class="campo-datos">
            <div class="label-datos">Número telefónico:</div>
            <div class="valor-datos">*********</div>
        </div>

        <div class="campo-datos">
            <div class="label-datos">Sede frecuente:</div>
            <div class="valor-datos">Javier Prado Oeste</div>
        </div>

        <div class="campo-datos">
            <div class="label-datos">Correo Electrónico:</div>
            <div class="valor-datos">ManE123@gmail.com</div>
        </div>

        <a href="principal.jsp" class="btn-volver">Volver</a>
    </div>

</body>
</html>