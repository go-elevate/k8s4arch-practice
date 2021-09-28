controller:
    autoscaling:
        enabled: true
        minReplicas: ${nginx_min_replicas}
        maxReplicas: ${nginx_max_replicas}
    service:
        externalIPs:
            %{~ for ip in external_nodes_ip ~} 
            - ${ip}
            %{~ endfor ~}