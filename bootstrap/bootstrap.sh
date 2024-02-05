#!/usr/bin/env bash

DIR="$( dirname -- "${BASH_SOURCE[0]}"; )";

#helm upgrade argocd --namespace argocd argo/argo-cd --set server.ingress.enabled=true --set 'server.ingress.hosts[0]=argocd.cloud.dodeka.be' --set 'server.extraArgs[0]=--insecure' --install --create-namespace
nohup bash -c 'minikube start' > minikube.log 2>&1
# Run this to forward to localhost in the background
sleep 10
helm repo add argo https://argoproj.github.io/argo-helm
helm upgrade argocd --namespace argocd argo/argo-cd --values=$DIR/argocd.yaml --install --create-namespace

minikube addons enable ingress

nohup kubectl port-forward --pod-running-timeout=24h -n ingress-nginx service/ingress-nginx-controller :80 &