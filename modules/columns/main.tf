resource "null_resource" "create_metrics_columns" {
  provisioner "local-exec" {
    command = <<-EOT
      cat > metrics-event.json <<EOF
{
%{for m in var.metrics_columns~}
%{if m != element(var.metrics_columns, length(var.metrics_columns) - 1)~}
%{if m != "hostname"~}
"${m}": 0.0,
%{else~}
"${m}": "",
%{endif~}
%{else~}
%{if m != "hostname"~}
"${m}": 0.0
%{else~}
"${m}": ""
%{endif~}
%{endif~}
%{endfor~}
}
EOF

      HONEYCOMB_DATASET="${var.metrics_dataset}"

      curl https://api.honeycomb.io/1/events/$HONEYCOMB_DATASET -X POST \
        -H "X-Honeycomb-Team: $HONEYCOMB_API_KEY" -d @metrics-event.json

      sleep 15
    EOT
  }
}

resource "null_resource" "create_logs_columns" {
  provisioner "local-exec" {
    command = <<-EOT
      cat > logs-event.json <<EOF
{
%{for m in var.logs_columns~}
%{if m != element(var.logs_columns, length(var.logs_columns) - 1)~}
"${m}": "",
%{else~}
"${m}": ""
%{endif~}
%{endfor~}
}
EOF

      HONEYCOMB_DATASET="${var.logs_dataset}"

      curl https://api.honeycomb.io/1/events/$HONEYCOMB_DATASET -X POST \
        -H "X-Honeycomb-Team: $HONEYCOMB_API_KEY" -d @logs-event.json

      sleep 15
    EOT
  }
}
