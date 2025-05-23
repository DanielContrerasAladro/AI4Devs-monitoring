# Prompts utilizados para la integración Datadog-AWS

- "Configura la integración de Datadog con AWS usando Terraform."
- "Instala el agente Datadog en la instancia EC2."
- "Crea un dashboard en Datadog para visualizar métricas clave de AWS."

# Integración Datadog-Slack

Para recibir alertas de Datadog en Slack, sigue estos pasos:

1. Ve a [Integrations > Slack](https://app.datadoghq.com/account/settings#integrations/slack) en la UI de Datadog.
2. Haz clic en "Add to Slack" y sigue el proceso de autorización OAuth.
3. Selecciona el workspace y canal de Slack donde quieres recibir las alertas (por ejemplo, #monitoring).
4. Copia el handle que te muestra Datadog para ese canal, por ejemplo: `@slack-monitoring`.
5. Usa ese handle en los monitores de Terraform, como se muestra en los archivos de este repositorio.

---

## Verificación de la integración

1. **Forzar una alerta de prueba**:
   - Modifica temporalmente el umbral de un monitor para que se dispare (por ejemplo, baja el umbral de CPU a 1%).
   - Espera a que la alerta se active y verifica que el mensaje aparece en el canal de Slack configurado.

2. **Verifica en Datadog**:
   - En la UI de Datadog, ve a Monitors > [Nombre del monitor] y revisa el historial de alertas.
   - Asegúrate de que el evento muestra el envío a Slack.

3. **Verifica en Slack**:
   - Comprueba que el canal recibe el mensaje y que el formato es correcto.

---

## Troubleshooting y errores comunes

### 1. No llegan alertas a Slack

**Causas posibles:**
- El handle de Slack (`@slack-monitoring`) es incorrecto o no corresponde al canal configurado.
- La integración de Slack no está activa o no tiene permisos en el canal.
- El monitor no se está disparando (la condición nunca se cumple).
- El bot de Datadog no está invitado al canal de Slack.

**Ejemplo:**
```hcl
message = "Alerta de CPU alta en EC2. @slack-monitoring"
# Si el canal real es #devops, pero el handle es @slack-devops, asegúrate de usar el handle correcto.
```

**Solución:**
- Verifica el handle en la UI de Datadog (Integrations > Slack).
- Invita al bot de Datadog al canal con `/invite @Datadog`.
- Usa la opción "Test Notifications" en la UI de Datadog.

---

### 2. El mensaje llega pero sin formato o sin variables

**Causas posibles:**
- El mensaje no usa la sintaxis de variables de Datadog (`{{host.name}}`, etc.).
- El canal de Slack tiene restricciones de apps externas.

**Ejemplo incorrecto:**
```hcl
message = "CPU alta en EC2 host.name"
```
**Ejemplo correcto:**
```hcl
message = "CPU alta en EC2 {{host.name}}"
```

**Solución:**
- Usa siempre las llaves dobles para variables de Datadog.
- Verifica que el bot de Datadog tiene permisos para publicar mensajes enriquecidos.

---

### 3. El monitor no se dispara nunca

**Causas posibles:**
- La query del monitor es demasiado restrictiva o el umbral es muy alto.
- El recurso (EC2, etc.) no está enviando métricas a Datadog.

**Ejemplo:**
```hcl
query = "avg(last_5m):avg:aws.ec2.cpuutilization{*} by {host} > 99"
# Si tus instancias nunca superan el 50%, la alerta nunca se disparará.
```

**Solución:**
- Baja el umbral temporalmente para probar (por ejemplo, a 1%).
- Asegúrate de que el agente Datadog está instalado y enviando métricas.
- Verifica en la UI de Datadog que ves datos recientes de la métrica.

---

### 4. El bot de Datadog no puede publicar en el canal

**Causas posibles:**
- El bot no está invitado al canal.
- El canal es privado y el bot no tiene acceso.

**Solución:**
- Invita al bot con `/invite @Datadog` en el canal de Slack.
- Si el canal es privado, asegúrate de que el bot tiene acceso.

---

### 5. Error de sintaxis en Terraform

**Causas posibles:**
- Uso incorrecto de variables o formato heredoc en el campo `message`.

**Ejemplo incorrecto:**
```hcl
message = <<EOM
Alerta de CPU alta en EC2 {{host.name}}
@slack-monitoring
EOM
```
**(Correcto, pero si olvidas EOM o usas comillas mal, Terraform fallará)**

**Solución:**
- Usa siempre el formato heredoc correctamente y revisa los logs de `terraform plan/apply` para errores de sintaxis.

---

## Notas adicionales

- Puedes añadir varios canales de Slack en el campo `message` separando los handles por espacio.
- Si usas Terraform Cloud/Enterprise, asegúrate de que los cambios se aplican correctamente y revisa los logs del plan/apply.

---

## 3. **Ejemplo de monitor con integración Slack**

Ya reflejado en el archivo `datadog_monitors.tf`:

```hcl:AI4Devs-monitoring/tf/datadog_monitors.tf
resource "datadog_monitor" "ec2_cpu_high" {
  // ... existing code ...
  message = <<EOM
La utilización de CPU en EC2 está por encima del 80% en {{host.name}}. Revisa la carga de trabajo.
@slack-monitoring
EOM
  // ... existing code ...
}
```

---

## 4. **Resumen de cambios**

- **Documentación clara** en `prompts/datadog-aws-prompts.md` sobre cómo hacer la integración.
- **Monitores de Terraform** ya preparados para notificar a Slack usando el handle adecuado.
- **No es necesario** añadir recursos Terraform adicionales para la integración, ya que Datadog la gestiona desde su UI.

