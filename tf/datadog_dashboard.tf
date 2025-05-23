resource "datadog_dashboard" "aws_overview" {
  title       = "AWS Overview"
  description = "Dashboard de métricas clave de AWS"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      title = "CPU Utilization"
      request {
        q = "avg:aws.ec2.cpuutilization{*}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Network In"
      request {
        q = "avg:aws.ec2.network_in{*}"
        display_type = "line"
      }
    }
  }
}