#!/bin/bash

kubectl apply -f https://bit.ly/k4k8s
export PROXY_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].hostname}" service -n kong kong-proxy)
