resource "datadog_monitor" "ec2_cpu_high" {
  name               = "EC2 CPU Utilization alta"
  type               = "metric alert"
  query              = "avg(last_5m):avg:aws.ec2.cpuutilization{*} by {host} > 80"
  message            = <<EOM
La utilización de CPU en EC2 está por encima del 80% en {{host.name}}. Revisa la carga de trabajo.
@slack-monitoring

# Verificación:
# - Tras aplicar este monitor, baja el umbral a 1% para forzar la alerta.
# - Verifica que el mensaje llega al canal de Slack configurado.

# Errores comunes:
# - Si no llega la alerta, revisa que el handle (@slack-monitoring) es correcto y que el bot está invitado al canal.
# - Si el mensaje llega sin {{host.name}}, revisa que usas la sintaxis correcta de variables de Datadog.
# - Si Terraform da error, revisa el formato heredoc (EOM) y que no falten comillas o cierres.
EOM
  tags               = ["env:prod", "project:AI4Devs-monitoring"]
  escalation_message = "Escalado: CPU alta persistente en EC2. @slack-monitoring"
  thresholds {
    critical = 80
    warning  = 60
  }
  notify_no_data    = true
  no_data_timeframe = 10
}

resource "datadog_monitor" "ec2_status_check_failed" {
  name    = "EC2 Status Check Failed"
  type    = "metric alert"
  query   = "avg(last_5m):max:aws.ec2.status_check_failed{*} by {host} > 0"
  message = <<EOM
El status check de EC2 ha fallado en {{host.name}}. Revisa la instancia.
@slack-monitoring

# Verificación:
# - Tras aplicar este monitor, fuerza una falla en la instancia EC2 o baja el umbral a 1 para probar.
# - Verifica que el mensaje llega al canal de Slack configurado.
EOM
  tags    = ["env:prod", "project:AI4Devs-monitoring"]
  thresholds {
    critical = 1
  }
  notify_no_data    = true
  no_data_timeframe = 10
}

resource "datadog_monitor" "ec2_disk_in" {
  name    = "EC2 Network In Anómalo"
  type    = "metric alert"
  query   = "avg(last_5m):avg:aws.ec2.network_in{*} by {host} > 100000000"
  message = <<EOM
El tráfico de red entrante en EC2 es inusualmente alto en {{host.name}}.
@slack-monitoring

# Verificación:
# - Tras aplicar este monitor, fuerza un alto tráfico de red entrante en la instancia EC2 o baja el umbral a 10000000 para probar.
# - Verifica que el mensaje llega al canal de Slack configurado.
EOM
  tags    = ["env:prod", "project:AI4Devs-monitoring"]
  thresholds {
    critical = 100000000
    warning  = 50000000
  }
  notify_no_data    = true
  no_data_timeframe = 10
}

resource "datadog_monitor" "ec2_disk_out" {
  name    = "EC2 Network Out Anómalo"
  type    = "metric alert"
  query   = "avg(last_5m):avg:aws.ec2.network_out{*} by {host} > 100000000"
  message = <<EOM
El tráfico de red saliente en EC2 es inusualmente alto en {{host.name}}.
@slack-monitoring

# Verificación:
# - Tras aplicar este monitor, fuerza un alto tráfico de red saliente en la instancia EC2 o baja el umbral a 10000000 para probar.
# - Verifica que el mensaje llega al canal de Slack configurado.
EOM
  tags    = ["env:prod", "project:AI4Devs-monitoring"]
  thresholds {
    critical = 100000000
    warning  = 50000000
  }
  notify_no_data    = true
  no_data_timeframe = 10
}