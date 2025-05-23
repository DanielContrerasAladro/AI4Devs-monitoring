Tu misión es extender el código Terraform existente para:

- Revisar el código de Terraform del proyecto
- Revisa los ficheros de prompts en la carpeta prompt y revisa que lo que se pide en ellos se cumple en el proyecto, sino, aplícalo
- Configurar la integración de Datadog con AWS usando Terraform.
- Instalar el agente Datadog en la instancia EC2.
- Crear un dashboard en Datadog para visualizar métricas clave de AWS.

Pasos a seguir:
a) Configurar la Integración AWS-Datadog:
Utiliza Terraform para configurar la integración entre AWS y Datadog, siguiendo la guía proporcionada.
b) Configurar el Proveedor Datadog:
Añade el proveedor Datadog a tu configuración de Terraform.
c) Instalar el Agente Datadog:
Modifica el script de usuario de la instancia EC2 para instalar y configurar el agente Datadog.
d) Crear un Dashboard:
Utiliza Terraform para definir un dashboard en Datadog que muestre métricas relevantes de tu infraestructura AWS.

Objetivo:
- Actualiza los archivos Terraform existentes y añade nuevos según sea necesario.
- Incluye un archivo README.md en la raiz del proyecto con:
  - Explicación de los cambios realizados.
  - Capturas de pantalla del dashboard y la alerta en Datadog.
  - Documentación de los prompts utilizados en datadog-aws-prompts.md.
  - Cualquier desafío encontrado y cómo lo resolviste.
- Un fichero prompts-DCA.md en la carpeta prompts que incluya los prompts utilizados para generar el pipeline.
